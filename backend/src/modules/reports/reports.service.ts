import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Between } from 'typeorm';
import { Service } from '../services/entities/service.entity';
import { Invoice } from '../finance/entities/invoice.entity';
import { Payment } from '../finance/entities/payment.entity';
import { Customer } from '../customers/entities/customer.entity';
import { User } from '../users/entities/user.entity';
import { Part } from '../parts/entities/part.entity';
import { StockMovement } from '../parts/entities/stock-movement.entity';
import { ServiceStatus } from '../../common/enums/service-status.enum';
import { PaymentStatus } from '../../common/enums/payment-status.enum';
import { UserRole } from '../../common/enums/user-role.enum';

@Injectable()
export class ReportsService {
  constructor(
    @InjectRepository(Service)
    private servicesRepository: Repository<Service>,
    @InjectRepository(Invoice)
    private invoicesRepository: Repository<Invoice>,
    @InjectRepository(Payment)
    private paymentsRepository: Repository<Payment>,
    @InjectRepository(Customer)
    private customersRepository: Repository<Customer>,
    @InjectRepository(User)
    private usersRepository: Repository<User>,
    @InjectRepository(Part)
    private partsRepository: Repository<Part>,
    @InjectRepository(StockMovement)
    private stockMovementsRepository: Repository<StockMovement>,
  ) {}

  async getFinancialSummary(startDate: Date, endDate: Date) {
    // Gelir
    const revenueResult = await this.servicesRepository
      .createQueryBuilder('service')
      .select('SUM(service.totalCost)', 'total')
      .where('service.completedAt BETWEEN :start AND :end', { start: startDate, end: endDate })
      .andWhere('service.status = :status', { status: ServiceStatus.COMPLETED })
      .getRawOne();

    const totalRevenue = parseFloat(revenueResult?.total || '0');

    // Tahsilat
    const collectionResult = await this.paymentsRepository
      .createQueryBuilder('payment')
      .select('SUM(payment.amount)', 'total')
      .where('payment.paymentDate BETWEEN :start AND :end', { start: startDate, end: endDate })
      .getRawOne();

    const totalCollection = parseFloat(collectionResult?.total || '0');

    // Bekleyen ödemeler
    const pendingResult = await this.invoicesRepository
      .createQueryBuilder('invoice')
      .select('SUM(invoice.remainingAmount)', 'total')
      .where('invoice.status = :status', { status: PaymentStatus.PENDING })
      .getRawOne();

    const pendingAmount = parseFloat(pendingResult?.total || '0');

    // Giderler (parça maliyetleri)
    const expenseResult = await this.servicesRepository
      .createQueryBuilder('service')
      .select('SUM(service.partsCost)', 'total')
      .where('service.completedAt BETWEEN :start AND :end', { start: startDate, end: endDate })
      .andWhere('service.status = :status', { status: ServiceStatus.COMPLETED })
      .getRawOne();

    const totalExpense = parseFloat(expenseResult?.total || '0');

    const netProfit = totalRevenue - totalExpense;
    const profitMargin = totalRevenue > 0 ? (netProfit / totalRevenue) * 100 : 0;

    return {
      period: { startDate, endDate },
      revenue: totalRevenue,
      collection: totalCollection,
      pending: pendingAmount,
      expense: totalExpense,
      netProfit,
      profitMargin: parseFloat(profitMargin.toFixed(2)),
    };
  }

  async getIncomeExpenseReport(startDate: Date, endDate: Date) {
    // Aylık breakdown
    const months = [];
    const current = new Date(startDate);

    while (current <= endDate) {
      const monthStart = new Date(current.getFullYear(), current.getMonth(), 1);
      const monthEnd = new Date(current.getFullYear(), current.getMonth() + 1, 0);

      const revenue = await this.servicesRepository
        .createQueryBuilder('service')
        .select('SUM(service.totalCost)', 'total')
        .where('service.completedAt BETWEEN :start AND :end', { start: monthStart, end: monthEnd })
        .andWhere('service.status = :status', { status: ServiceStatus.COMPLETED })
        .getRawOne();

      const expense = await this.servicesRepository
        .createQueryBuilder('service')
        .select('SUM(service.partsCost)', 'total')
        .where('service.completedAt BETWEEN :start AND :end', { start: monthStart, end: monthEnd })
        .andWhere('service.status = :status', { status: ServiceStatus.COMPLETED })
        .getRawOne();

      months.push({
        month: monthStart.toLocaleDateString('tr-TR', { year: 'numeric', month: 'long' }),
        revenue: parseFloat(revenue?.total || '0'),
        expense: parseFloat(expense?.total || '0'),
        profit: parseFloat(revenue?.total || '0') - parseFloat(expense?.total || '0'),
      });

      current.setMonth(current.getMonth() + 1);
    }

    return months;
  }

  async getProfitLossReport(startDate: Date, endDate: Date) {
    const summary = await this.getFinancialSummary(startDate, endDate);

    // Servis tiplerine göre gelir
    const serviceTypes = await this.servicesRepository
      .createQueryBuilder('service')
      .select('service.serviceType', 'type')
      .addSelect('SUM(service.totalCost)', 'revenue')
      .addSelect('COUNT(service.id)', 'count')
      .where('service.completedAt BETWEEN :start AND :end', { start: startDate, end: endDate })
      .andWhere('service.status = :status', { status: ServiceStatus.COMPLETED })
      .groupBy('service.serviceType')
      .getRawMany();

    return {
      summary,
      breakdown: {
        byServiceType: serviceTypes.map((st) => ({
          type: st.type,
          revenue: parseFloat(st.revenue),
          count: parseInt(st.count),
        })),
      },
    };
  }

  async getServicesReport(startDate: Date, endDate: Date) {
    const total = await this.servicesRepository.count({
      where: {
        scheduledDate: Between(startDate, endDate),
      },
    });

    const completed = await this.servicesRepository.count({
      where: {
        completedAt: Between(startDate, endDate),
        status: ServiceStatus.COMPLETED,
      },
    });

    const cancelled = await this.servicesRepository.count({
      where: {
        scheduledDate: Between(startDate, endDate),
        status: ServiceStatus.CANCELLED,
      },
    });

    // Servis tiplerine göre dağılım
    const byType = await this.servicesRepository
      .createQueryBuilder('service')
      .select('service.serviceType', 'type')
      .addSelect('COUNT(service.id)', 'count')
      .where('service.scheduledDate BETWEEN :start AND :end', { start: startDate, end: endDate })
      .groupBy('service.serviceType')
      .getRawMany();

    // Ortalama tamamlanma süresi
    const services = await this.servicesRepository.find({
      where: {
        completedAt: Between(startDate, endDate),
        status: ServiceStatus.COMPLETED,
      },
      select: ['scheduledDate', 'completedAt'],
    });

    let totalDuration = 0;
    services.forEach((service) => {
      if (service.completedAt && service.scheduledDate) {
        totalDuration += service.completedAt.getTime() - service.scheduledDate.getTime();
      }
    });

    const avgDuration = services.length > 0 ? Math.round(totalDuration / services.length / (1000 * 60)) : 0;

    return {
      period: { startDate, endDate },
      total,
      completed,
      cancelled,
      completionRate: total > 0 ? ((completed / total) * 100).toFixed(2) : 0,
      avgDuration, // dakika
      byType: byType.map((t) => ({
        type: t.type,
        count: parseInt(t.count),
      })),
    };
  }

  async getTechniciansReport(startDate: Date, endDate: Date) {
    const technicians = await this.usersRepository.find({
      where: { role: UserRole.TECHNICIAN, isActive: true },
    });

    const report = await Promise.all(
      technicians.map(async (tech) => {
        const completed = await this.servicesRepository.count({
          where: {
            technicianId: tech.id,
            completedAt: Between(startDate, endDate),
            status: ServiceStatus.COMPLETED,
          },
        });

        const ratingResult = await this.servicesRepository
          .createQueryBuilder('service')
          .select('AVG(service.customerRating)', 'avg')
          .where('service.technicianId = :id', { id: tech.id })
          .andWhere('service.completedAt BETWEEN :start AND :end', { start: startDate, end: endDate })
          .andWhere('service.customerRating IS NOT NULL')
          .getRawOne();

        const revenueResult = await this.servicesRepository
          .createQueryBuilder('service')
          .select('SUM(service.totalCost)', 'total')
          .where('service.technicianId = :id', { id: tech.id })
          .andWhere('service.completedAt BETWEEN :start AND :end', { start: startDate, end: endDate })
          .andWhere('service.status = :status', { status: ServiceStatus.COMPLETED })
          .getRawOne();

        return {
          id: tech.id,
          name: tech.fullName,
          completedServices: completed,
          avgRating: parseFloat((ratingResult?.avg || 0).toFixed(2)),
          totalRevenue: parseFloat(revenueResult?.total || '0'),
        };
      }),
    );

    return report.sort((a, b) => b.completedServices - a.completedServices);
  }

  async getCustomerAnalysis(startDate: Date, endDate: Date) {
    const newCustomers = await this.customersRepository.count({
      where: {
        createdAt: Between(startDate, endDate),
      },
    });

    const totalCustomers = await this.customersRepository.count();

    // En çok harcama yapan müşteriler
    const topSpenders = await this.customersRepository
      .createQueryBuilder('customer')
      .select(['customer.id', 'customer.firstName', 'customer.lastName', 'customer.totalSpent'])
      .orderBy('customer.totalSpent', 'DESC')
      .limit(10)
      .getMany();

    // Müşteri segmentasyonu
    const segments = {
      vip: await this.customersRepository.count({
        where: { totalSpent: Between(10000, 999999) },
      }),
      regular: await this.customersRepository.count({
        where: { totalSpent: Between(1000, 9999) },
      }),
      new: await this.customersRepository.count({
        where: { totalSpent: Between(0, 999) },
      }),
    };

    return {
      period: { startDate, endDate },
      newCustomers,
      totalCustomers,
      topSpenders: topSpenders.map((c) => ({
        id: c.id,
        name: c.fullName,
        totalSpent: c.totalSpent,
      })),
      segments,
    };
  }

  async getSatisfactionReport(startDate: Date, endDate: Date) {
    const ratingResult = await this.servicesRepository
      .createQueryBuilder('service')
      .select('AVG(service.customerRating)', 'avg')
      .addSelect('COUNT(service.id)', 'count')
      .where('service.completedAt BETWEEN :start AND :end', { start: startDate, end: endDate })
      .andWhere('service.customerRating IS NOT NULL')
      .getRawOne();

    // Rating dağılımı
    const distribution = await this.servicesRepository
      .createQueryBuilder('service')
      .select('service.customerRating', 'rating')
      .addSelect('COUNT(service.id)', 'count')
      .where('service.completedAt BETWEEN :start AND :end', { start: startDate, end: endDate })
      .andWhere('service.customerRating IS NOT NULL')
      .groupBy('service.customerRating')
      .orderBy('service.customerRating', 'DESC')
      .getRawMany();

    return {
      period: { startDate, endDate },
      avgRating: parseFloat((ratingResult?.avg || 0).toFixed(2)),
      totalRatings: parseInt(ratingResult?.count || '0'),
      distribution: distribution.map((d) => ({
        rating: parseFloat(d.rating),
        count: parseInt(d.count),
      })),
    };
  }

  async getStockReport() {
    const total = await this.partsRepository.count({ where: { isActive: true } });

    const critical = await this.partsRepository
      .createQueryBuilder('part')
      .where('part.stockQuantity <= part.minStockLevel')
      .andWhere('part.isActive = true')
      .getCount();

    const low = await this.partsRepository
      .createQueryBuilder('part')
      .where('part.stockQuantity > part.minStockLevel')
      .andWhere('part.stockQuantity <= part.minStockLevel * 2')
      .andWhere('part.isActive = true')
      .getCount();

    const valueResult = await this.partsRepository
      .createQueryBuilder('part')
      .select('SUM(part.stockQuantity * part.unitPrice)', 'total')
      .where('part.isActive = true')
      .getRawOne();

    const totalValue = parseFloat(valueResult?.total || '0');

    return {
      total,
      critical,
      low,
      normal: total - critical - low,
      totalValue,
    };
  }

  async getPartsUsageReport(startDate: Date, endDate: Date) {
    const movements = await this.stockMovementsRepository
      .createQueryBuilder('movement')
      .leftJoinAndSelect('movement.part', 'part')
      .where('movement.createdAt BETWEEN :start AND :end', { start: startDate, end: endDate })
      .andWhere('movement.movementType = :type', { type: 'OUT' })
      .getMany();

    // Parçalara göre grupla
    const usage = {};
    movements.forEach((movement) => {
      const partId = movement.partId;
      if (!usage[partId]) {
        usage[partId] = {
          partId,
          partName: movement.part?.partName,
          totalQuantity: 0,
          totalCost: 0,
        };
      }
      usage[partId].totalQuantity += movement.quantity;
      usage[partId].totalCost += movement.quantity * (movement.part?.unitPrice || 0);
    });

    const usageArray = Object.values(usage).sort(
      (a: any, b: any) => b.totalQuantity - a.totalQuantity,
    );

    return {
      period: { startDate, endDate },
      mostUsed: usageArray.slice(0, 10),
      totalMovements: movements.length,
    };
  }
}
