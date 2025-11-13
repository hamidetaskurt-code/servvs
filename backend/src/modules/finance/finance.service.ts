import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Between, LessThan } from 'typeorm';
import { Invoice } from './entities/invoice.entity';
import { Payment } from './entities/payment.entity';
import { PaymentStatus } from '../../common/enums/payment-status.enum';
import { CreateInvoiceDto } from './dto/create-invoice.dto';
import { CreatePaymentDto } from './dto/create-payment.dto';

@Injectable()
export class FinanceService {
  constructor(
    @InjectRepository(Invoice)
    private invoicesRepository: Repository<Invoice>,
    @InjectRepository(Payment)
    private paymentsRepository: Repository<Payment>,
  ) {}

  // Fatura numarası oluştur
  private async generateInvoiceNumber(): Promise<string> {
    const year = new Date().getFullYear();
    const count = await this.invoicesRepository.count();
    return `F-${year}-${String(count + 1).padStart(4, '0')}`;
  }

  // Ödeme numarası oluştur
  private async generatePaymentNumber(): Promise<string> {
    const year = new Date().getFullYear();
    const count = await this.paymentsRepository.count();
    return `P-${year}-${String(count + 1).padStart(4, '0')}`;
  }

  // Fatura CRUD
  async createInvoice(createInvoiceDto: CreateInvoiceDto): Promise<Invoice> {
    const invoiceNumber = await this.generateInvoiceNumber();

    // KDV hesapla
    const taxAmount =
      (createInvoiceDto.subtotal * createInvoiceDto.taxRate) / 100;
    const totalAmount =
      createInvoiceDto.subtotal +
      taxAmount -
      (createInvoiceDto.discountAmount || 0);

    const invoice = this.invoicesRepository.create({
      ...createInvoiceDto,
      invoiceNumber,
      taxAmount,
      totalAmount,
      paidAmount: 0,
      remainingAmount: totalAmount,
    });

    return await this.invoicesRepository.save(invoice);
  }

  async findAllInvoices(filters?: any): Promise<Invoice[]> {
    const where: any = {};

    if (filters?.status) {
      where.status = filters.status;
    }

    if (filters?.customerId) {
      where.customerId = filters.customerId;
    }

    if (filters?.dateFrom && filters?.dateTo) {
      where.invoiceDate = Between(
        new Date(filters.dateFrom),
        new Date(filters.dateTo),
      );
    }

    return await this.invoicesRepository.find({
      where,
      relations: ['customer', 'service', 'payments'],
      order: { invoiceDate: 'DESC' },
    });
  }

  async findOneInvoice(id: string): Promise<Invoice> {
    const invoice = await this.invoicesRepository.findOne({
      where: { id },
      relations: ['customer', 'service', 'payments'],
    });

    if (!invoice) {
      throw new NotFoundException(`Invoice with ID ${id} not found`);
    }

    return invoice;
  }

  async updateInvoiceStatus(
    id: string,
    status: PaymentStatus,
  ): Promise<Invoice> {
    const invoice = await this.findOneInvoice(id);
    invoice.status = status;
    return await this.invoicesRepository.save(invoice);
  }

  // Ödeme ekleme
  async addPayment(createPaymentDto: CreatePaymentDto): Promise<Payment> {
    const paymentNumber = await this.generatePaymentNumber();
    const invoice = await this.findOneInvoice(createPaymentDto.invoiceId);

    const payment = this.paymentsRepository.create({
      ...createPaymentDto,
      paymentNumber,
    });

    const savedPayment = await this.paymentsRepository.save(payment);

    // Fatura ödeme bilgilerini güncelle
    invoice.paidAmount = Number(invoice.paidAmount) + Number(createPaymentDto.amount);
    invoice.remainingAmount = Number(invoice.totalAmount) - Number(invoice.paidAmount);

    if (invoice.remainingAmount <= 0) {
      invoice.status = PaymentStatus.PAID;
    } else if (invoice.paidAmount > 0) {
      invoice.status = PaymentStatus.PARTIAL;
    }

    await this.invoicesRepository.save(invoice);

    return savedPayment;
  }

  // Vadesi geçmiş faturalar
  async getOverdueInvoices(): Promise<Invoice[]> {
    const today = new Date();
    return await this.invoicesRepository.find({
      where: {
        status: PaymentStatus.PENDING,
        dueDate: LessThan(today),
      },
      relations: ['customer'],
      order: { dueDate: 'ASC' },
    });
  }

  // Finans özeti
  async getFinanceSummary(startDate?: Date, endDate?: Date): Promise<any> {
    const where: any = {};

    if (startDate && endDate) {
      where.invoiceDate = Between(startDate, endDate);
    }

    const allInvoices = await this.invoicesRepository.find({ where });

    const totalInvoiced = allInvoices.reduce(
      (acc, inv) => acc + Number(inv.totalAmount),
      0,
    );

    const totalPaid = allInvoices.reduce(
      (acc, inv) => acc + Number(inv.paidAmount),
      0,
    );

    const totalOutstanding = allInvoices.reduce(
      (acc, inv) => acc + Number(inv.remainingAmount),
      0,
    );

    const paidInvoices = allInvoices.filter(
      (inv) => inv.status === PaymentStatus.PAID,
    );
    const pendingInvoices = allInvoices.filter(
      (inv) => inv.status === PaymentStatus.PENDING,
    );
    const overdueInvoices = allInvoices.filter((inv) => inv.isOverdue);

    // Ödeme yöntemleri dağılımı
    const payments = await this.paymentsRepository
      .createQueryBuilder('payment')
      .leftJoin('payment.invoice', 'invoice')
      .where(
        startDate && endDate
          ? 'invoice.invoiceDate BETWEEN :startDate AND :endDate'
          : '1=1',
        { startDate, endDate },
      )
      .getMany();

    const paymentMethodBreakdown = payments.reduce((acc, payment) => {
      const method = payment.paymentMethod;
      acc[method] = (acc[method] || 0) + Number(payment.amount);
      return acc;
    }, {} as Record<string, number>);

    return {
      summary: {
        totalInvoices: allInvoices.length,
        totalInvoiced,
        totalPaid,
        totalOutstanding,
        collectionRate: totalInvoiced > 0
          ? ((totalPaid / totalInvoiced) * 100).toFixed(2) + '%'
          : '0%',
      },
      breakdown: {
        paid: paidInvoices.length,
        pending: pendingInvoices.length,
        overdue: overdueInvoices.length,
        partial: allInvoices.filter((inv) => inv.status === PaymentStatus.PARTIAL)
          .length,
      },
      paymentMethods: paymentMethodBreakdown,
    };
  }

  // Gelir-gider raporu
  async getIncomeExpenseReport(startDate: Date, endDate: Date): Promise<any> {
    // Gelir (Ödenmiş faturalar)
    const income = await this.paymentsRepository
      .createQueryBuilder('payment')
      .where('payment.paymentDate BETWEEN :startDate AND :endDate', {
        startDate,
        endDate,
      })
      .getMany();

    const totalIncome = income.reduce(
      (acc, p) => acc + Number(p.amount),
      0,
    );

    // Gider hesabı için ayrı bir expense modülü gerekebilir
    // Şimdilik sadece gelir raporu

    return {
      period: {
        startDate,
        endDate,
      },
      income: {
        total: totalIncome,
        count: income.length,
        byMethod: income.reduce((acc, p) => {
          const method = p.paymentMethod;
          acc[method] = (acc[method] || 0) + Number(p.amount);
          return acc;
        }, {} as Record<string, number>),
      },
      // expense: {}, // Gelecekte eklenecek
      netProfit: totalIncome, // - totalExpense
    };
  }

  // Müşteri bazlı karlılık
  async getCustomerProfitability(customerId: string): Promise<any> {
    const invoices = await this.invoicesRepository.find({
      where: { customerId },
      relations: ['payments'],
    });

    const totalRevenue = invoices.reduce(
      (acc, inv) => acc + Number(inv.totalAmount),
      0,
    );
    const totalPaid = invoices.reduce(
      (acc, inv) => acc + Number(inv.paidAmount),
      0,
    );
    const totalOutstanding = invoices.reduce(
      (acc, inv) => acc + Number(inv.remainingAmount),
      0,
    );

    return {
      customerId,
      totalInvoices: invoices.length,
      totalRevenue,
      totalPaid,
      totalOutstanding,
      paymentRate:
        totalRevenue > 0
          ? ((totalPaid / totalRevenue) * 100).toFixed(2) + '%'
          : '0%',
    };
  }
}
