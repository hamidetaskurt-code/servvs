import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Between, LessThan, MoreThanOrEqual, LessThanOrEqual } from 'typeorm';
import { Invoice } from './entities/invoice.entity';
import { Payment } from './entities/payment.entity';
import { Installment } from './entities/installment.entity';
import { PaymentStatus } from '../../common/enums/payment-status.enum';
import { CreateInvoiceDto } from './dto/create-invoice.dto';
import { CreatePaymentDto } from './dto/create-payment.dto';
import { CreateInstallmentPlanDto } from './dto/create-installment-plan.dto';
import { CommunicationsService } from '../communications/communications.service';

@Injectable()
export class FinanceService {
  constructor(
    @InjectRepository(Invoice)
    private invoicesRepository: Repository<Invoice>,
    @InjectRepository(Payment)
    private paymentsRepository: Repository<Payment>,
    @InjectRepository(Installment)
    private installmentsRepository: Repository<Installment>,
    private communicationsService: CommunicationsService,
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

  // Vadesi geçmiş fatura hatırlatmaları
  async sendOverdueInvoiceReminders(
    type: 'sms' | 'email' | 'both' = 'both',
    minDaysOverdue: number = 1,
  ): Promise<any> {
    const overdueInvoices = await this.getOverdueInvoices();

    // Minimum gecikme gününe göre filtrele
    const filteredInvoices = overdueInvoices.filter(
      (invoice) => invoice.daysPastDue >= minDaysOverdue,
    );

    const results = {
      total: filteredInvoices.length,
      sent: 0,
      failed: 0,
      errors: [],
    };

    for (const invoice of filteredInvoices) {
      const customer = invoice.customer;
      if (!customer) continue;

      const message = `Sayın ${customer.fullName},\n\n${
        invoice.invoiceNumber
      } numaralı faturanızın vadesi ${
        invoice.daysPastDue
      } gün önce dolmuştur.\n\nFatura Tarihi: ${new Date(
        invoice.invoiceDate,
      ).toLocaleDateString('tr-TR')}\nVade Tarihi: ${new Date(
        invoice.dueDate,
      ).toLocaleDateString('tr-TR')}\nToplam Tutar: ₺${Number(
        invoice.totalAmount,
      ).toFixed(2)}\nKalan Tutar: ₺${Number(invoice.remainingAmount).toFixed(
        2,
      )}\n\nÖdemenizi en kısa sürede yapmanızı rica ederiz.\n\nTeşekkür ederiz,\nAkın Kombi`;

      try {
        if (type === 'sms' || type === 'both') {
          await this.communicationsService.sendSMS(customer.phone, message);
        }

        if (type === 'email' || type === 'both') {
          await this.communicationsService.sendEmail(
            customer.email,
            'Fatura Ödeme Hatırlatması',
            message,
          );
        }

        results.sent++;
      } catch (error) {
        results.failed++;
        results.errors.push({
          invoiceId: invoice.id,
          customerId: customer.id,
          error: error.message,
        });
      }
    }

    return results;
  }

  // Belirli bir fatura için hatırlatma gönder
  async sendInvoiceReminder(
    invoiceId: string,
    type: 'sms' | 'email' | 'both' = 'both',
  ): Promise<any> {
    const invoice = await this.findOneInvoice(invoiceId);
    const customer = invoice.customer;

    if (!customer) {
      throw new NotFoundException('Customer not found for this invoice');
    }

    if (invoice.status === PaymentStatus.PAID) {
      return {
        success: false,
        message: 'Invoice is already paid',
      };
    }

    const isOverdue = invoice.isOverdue;
    const subject = isOverdue
      ? 'Fatura Ödeme Hatırlatması - VADESİ GEÇMİŞ'
      : 'Fatura Ödeme Hatırlatması';

    const message = `Sayın ${customer.fullName},\n\n${
      invoice.invoiceNumber
    } numaralı faturanız ${
      isOverdue
        ? `${invoice.daysPastDue} gün önce vadesi dolmuştur`
        : `yakında sona erecektir`
    }.\n\nFatura Tarihi: ${new Date(invoice.invoiceDate).toLocaleDateString(
      'tr-TR',
    )}\nVade Tarihi: ${new Date(invoice.dueDate).toLocaleDateString(
      'tr-TR',
    )}\nToplam Tutar: ₺${Number(invoice.totalAmount).toFixed(
      2,
    )}\nÖdenen Tutar: ₺${Number(invoice.paidAmount).toFixed(
      2,
    )}\nKalan Tutar: ₺${Number(invoice.remainingAmount).toFixed(
      2,
    )}\n\nÖdemenizi yapmanızı rica ederiz.\n\nTeşekkür ederiz,\nAkın Kombi`;

    const results = { sms: false, email: false };

    try {
      if (type === 'sms' || type === 'both') {
        await this.communicationsService.sendSMS(customer.phone, message);
        results.sms = true;
      }

      if (type === 'email' || type === 'both') {
        await this.communicationsService.sendEmail(
          customer.email,
          subject,
          message,
        );
        results.email = true;
      }

      return {
        success: true,
        message: 'Reminder sent successfully',
        results,
      };
    } catch (error) {
      throw new Error(`Failed to send reminder: ${error.message}`);
    }
  }

  // Taksitli ödeme planı oluşturma
  async createInstallmentPlan(
    createInstallmentPlanDto: CreateInstallmentPlanDto,
  ): Promise<Installment[]> {
    const invoice = await this.findOneInvoice(
      createInstallmentPlanDto.invoiceId,
    );

    if (invoice.status === PaymentStatus.PAID) {
      throw new Error('Cannot create installment plan for paid invoice');
    }

    // Mevcut taksitler varsa iptal et
    await this.installmentsRepository.delete({
      invoiceId: invoice.id,
      status: PaymentStatus.PENDING,
    });

    const installmentAmount = Number(
      (invoice.remainingAmount / createInstallmentPlanDto.numberOfInstallments).toFixed(2),
    );

    const installments: Installment[] = [];
    const firstDueDate = new Date(createInstallmentPlanDto.firstDueDate);

    for (let i = 0; i < createInstallmentPlanDto.numberOfInstallments; i++) {
      const dueDate = new Date(firstDueDate);
      dueDate.setDate(
        dueDate.getDate() + i * createInstallmentPlanDto.intervalDays,
      );

      const installmentNumber = `T-${invoice.invoiceNumber}-${i + 1}`;

      // Son taksitte kalan tutarı ekleme (yuvarlama farkı)
      const isLastInstallment =
        i === createInstallmentPlanDto.numberOfInstallments - 1;
      const amount = isLastInstallment
        ? Number(
            (
              invoice.remainingAmount -
              installmentAmount * i
            ).toFixed(2),
          )
        : installmentAmount;

      const installment = this.installmentsRepository.create({
        installmentNumber,
        installmentOrder: i + 1,
        totalInstallments: createInstallmentPlanDto.numberOfInstallments,
        amount,
        dueDate,
        status: PaymentStatus.PENDING,
        invoiceId: invoice.id,
        customerId: invoice.customerId,
        notes: createInstallmentPlanDto.notes,
      });

      installments.push(installment);
    }

    return await this.installmentsRepository.save(installments);
  }

  // Faturaya göre taksitleri getir
  async getInstallmentsByInvoice(invoiceId: string): Promise<Installment[]> {
    return await this.installmentsRepository.find({
      where: { invoiceId },
      relations: ['invoice', 'customer'],
      order: { installmentOrder: 'ASC' },
    });
  }

  // Müşteriye göre taksitleri getir
  async getInstallmentsByCustomer(customerId: string): Promise<Installment[]> {
    return await this.installmentsRepository.find({
      where: { customerId },
      relations: ['invoice', 'customer'],
      order: { dueDate: 'ASC' },
    });
  }

  // Taksit ödeme
  async payInstallment(
    installmentId: string,
    paymentTransactionId?: string,
  ): Promise<Installment> {
    const installment = await this.installmentsRepository.findOne({
      where: { id: installmentId },
      relations: ['invoice'],
    });

    if (!installment) {
      throw new NotFoundException('Installment not found');
    }

    if (installment.status === PaymentStatus.PAID) {
      throw new Error('Installment is already paid');
    }

    installment.status = PaymentStatus.PAID;
    installment.paidDate = new Date();
    installment.paymentTransactionId = paymentTransactionId;

    const savedInstallment = await this.installmentsRepository.save(
      installment,
    );

    // Fatura ödeme bilgilerini güncelle
    if (installment.invoice) {
      const invoice = installment.invoice;
      invoice.paidAmount = Number(invoice.paidAmount) + Number(installment.amount);
      invoice.remainingAmount = Number(invoice.totalAmount) - Number(invoice.paidAmount);

      if (invoice.remainingAmount <= 0) {
        invoice.status = PaymentStatus.PAID;
      } else if (invoice.paidAmount > 0) {
        invoice.status = PaymentStatus.PARTIAL;
      }

      await this.invoicesRepository.save(invoice);
    }

    return savedInstallment;
  }

  // Yaklaşan taksitler
  async getUpcomingInstallments(daysAhead: number = 7): Promise<Installment[]> {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const futureDate = new Date(today);
    futureDate.setDate(futureDate.getDate() + daysAhead);

    return await this.installmentsRepository.find({
      where: {
        status: PaymentStatus.PENDING,
        dueDate: Between(today, futureDate),
      },
      relations: ['invoice', 'customer'],
      order: { dueDate: 'ASC' },
    });
  }

  // Vadesi geçmiş taksitler
  async getOverdueInstallments(): Promise<Installment[]> {
    const today = new Date();
    return await this.installmentsRepository.find({
      where: {
        status: PaymentStatus.PENDING,
        dueDate: LessThan(today),
      },
      relations: ['invoice', 'customer'],
      order: { dueDate: 'ASC' },
    });
  }
}
