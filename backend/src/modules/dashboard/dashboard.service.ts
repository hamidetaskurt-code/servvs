import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Between, MoreThan } from 'typeorm';
import { Customer } from '../customers/entities/customer.entity';
import { Service } from '../services/entities/service.entity';
import { Part } from '../parts/entities/part.entity';
import { User } from '../users/entities/user.entity';
import { Invoice } from '../finance/entities/invoice.entity';
import { ServiceStatus } from '../../common/enums/service-status.enum';
import { PaymentStatus } from '../../common/enums/payment-status.enum';
import { UserRole } from '../../common/enums/user-role.enum';

/**
 * Dashboard Service
 * Ana dashboard için istatistik ve özet bilgiler
 */
@Injectable()
export class DashboardService {
  constructor(
    @InjectRepository(Customer)
    private customersRepository: Repository<Customer>,
    @InjectRepository(Service)
    private servicesRepository: Repository<Service>,
    @InjectRepository(Part)
    private partsRepository: Repository<Part>,
    @InjectRepository(User)
    private usersRepository: Repository<User>,
    @InjectRepository(Invoice)
    private invoicesRepository: Repository<Invoice>,
  ) {}

  /**
   * Ana dashboard istatistikleri
   */
  async getStats(): Promise<any> {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    // Bugünkü servisler
    const todayServices = await this.servicesRepository.count({
      where: {
        scheduledDate: Between(today, tomorrow),
      },
    });

    const todayCompleted = await this.servicesRepository.count({
      where: {
        scheduledDate: Between(today, tomorrow),
        status: ServiceStatus.COMPLETED,
      },
    });

    const todayInProgress = await this.servicesRepository.count({
      where: {
        scheduledDate: Between(today, tomorrow),
        status: ServiceStatus.IN_PROGRESS,
      },
    });

    // Aktif teknisyenler
    const activeTechnicians = await this.usersRepository.count({
      where: {
        role: UserRole.TECHNICIAN,
        isActive: true,
      },
    });

    // Bugün sahada çalışan teknisyenler
    const techInField = await this.servicesRepository
      .createQueryBuilder('service')
      .select('DISTINCT service.technicianId')
      .where('service.scheduledDate >= :today', { today })
      .andWhere('service.scheduledDate < :tomorrow', { tomorrow })
      .andWhere('service.status = :status', { status: ServiceStatus.IN_PROGRESS })
      .getRawMany();

    // Toplam müşteri sayısı
    const totalCustomers = await this.customersRepository.count();

    // Kritik stoklar
    const criticalStock = await this.partsRepository
      .createQueryBuilder('part')
      .where('part.stockQuantity <= part.minStockLevel')
      .andWhere('part.isActive = true')
      .getCount();

    // Bugünkü gelir
    const todayRevenue = await this.servicesRepository
      .createQueryBuilder('service')
      .select('SUM(service.totalCost)', 'total')
      .where('DATE(service.completedAt) = DATE(:today)', { today })
      .andWhere('service.status = :status', { status: ServiceStatus.COMPLETED })
      .getRawOne();

    // Ortalama müşteri memnuniyeti (son 30 gün)
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const avgSatisfaction = await this.servicesRepository
      .createQueryBuilder('service')
      .select('AVG(service.customerRating)', 'avg')
      .where('service.completedAt >= :thirtyDaysAgo', { thirtyDaysAgo })
      .andWhere('service.customerRating IS NOT NULL')
      .getRawOne();

    // Bekleyen faturalar
    const pendingInvoices = await this.invoicesRepository.count({
      where: {
        status: PaymentStatus.PENDING,
      },
    });

    const pendingAmount = await this.invoicesRepository
      .createQueryBuilder('invoice')
      .select('SUM(invoice.remainingAmount)', 'total')
      .where('invoice.status = :status', { status: PaymentStatus.PENDING })
      .getRawOne();

    return {
      services: {
        today: todayServices,
        completed: todayCompleted,
        inProgress: todayInProgress,
        pending: todayServices - todayCompleted - todayInProgress,
      },
      technicians: {
        total: activeTechnicians,
        inField: techInField.length,
        available: activeTechnicians - techInField.length,
      },
      customers: {
        total: totalCustomers,
      },
      inventory: {
        criticalItems: criticalStock,
      },
      finance: {
        todayRevenue: parseFloat(todayRevenue?.total || '0'),
        pendingInvoices,
        pendingAmount: parseFloat(pendingAmount?.total || '0'),
      },
      satisfaction: {
        average: parseFloat((avgSatisfaction?.avg || 0).toFixed(2)),
      },
    };
  }

  /**
   * Aylık trendler (son 12 ay)
   */
  async getMonthlyTrends(): Promise<any> {
    const months = [];
    const currentDate = new Date();

    for (let i = 11; i >= 0; i--) {
      const monthStart = new Date(
        currentDate.getFullYear(),
        currentDate.getMonth() - i,
        1,
      );
      const monthEnd = new Date(
        currentDate.getFullYear(),
        currentDate.getMonth() - i + 1,
        0,
      );

      const services = await this.servicesRepository.count({
        where: {
          scheduledDate: Between(monthStart, monthEnd),
          status: ServiceStatus.COMPLETED,
        },
      });

      const revenue = await this.servicesRepository
        .createQueryBuilder('service')
        .select('SUM(service.totalCost)', 'total')
        .where('service.completedAt BETWEEN :start AND :end', {
          start: monthStart,
          end: monthEnd,
        })
        .andWhere('service.status = :status', { status: ServiceStatus.COMPLETED })
        .getRawOne();

      months.push({
        month: monthStart.toLocaleDateString('tr-TR', {
          year: 'numeric',
          month: 'long',
        }),
        services,
        revenue: parseFloat(revenue?.total || '0'),
      });
    }

    return months;
  }

  /**
   * Teknisyen performans sıralaması (top 5)
   */
  async getTopTechnicians(limit: number = 5): Promise<any> {
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const technicians = await this.usersRepository
      .createQueryBuilder('user')
      .leftJoinAndSelect('user.assignedServices', 'service')
      .where('user.role = :role', { role: 'technician' })
      .andWhere('service.status = :status', { status: ServiceStatus.COMPLETED })
      .andWhere('service.completedAt >= :thirtyDaysAgo', { thirtyDaysAgo })
      .select([
        'user.id',
        'user.firstName',
        'user.lastName',
        'COUNT(service.id) as completedCount',
        'AVG(service.customerRating) as avgRating',
      ])
      .groupBy('user.id')
      .orderBy('completedCount', 'DESC')
      .limit(limit)
      .getRawMany();

    return technicians.map((tech) => ({
      id: tech.user_id,
      name: `${tech.user_firstName} ${tech.user_lastName}`,
      completedServices: parseInt(tech.completedCount),
      avgRating: parseFloat((tech.avgRating || 0).toFixed(2)),
    }));
  }

  /**
   * Bugünkü canlı aktivite feed
   */
  async getRecentActivities(limit: number = 10): Promise<any> {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const services = await this.servicesRepository.find({
      where: {
        updatedAt: MoreThan(today),
      },
      relations: ['customer', 'assignedTechnician'],
      order: { updatedAt: 'DESC' },
      take: limit,
    });

    return services.map((service) => ({
      id: service.id,
      type: 'service',
      message: this.getActivityMessage(service),
      timestamp: service.updatedAt,
      icon: this.getActivityIcon(service.status),
    }));
  }

  private getActivityMessage(service: Service): string {
    const techName = service.assignedTechnician?.fullName || 'Teknisyen';
    const customerName = service.customer?.fullName || 'Müşteri';

    switch (service.status) {
      case ServiceStatus.IN_PROGRESS:
        return `${techName} → ${service.customer?.district}'de servise başladı (#${service.serviceNumber})`;
      case ServiceStatus.COMPLETED:
        return `${techName} → Servis tamamlandı (#${service.serviceNumber}) ${service.customerRating ? `- ${service.customerRating}⭐` : ''}`;
      case ServiceStatus.PLANNED:
        return `Yeni randevu oluşturuldu: ${customerName} (#${service.serviceNumber})`;
      case ServiceStatus.CANCELLED:
        return `Servis iptal edildi (#${service.serviceNumber})`;
      default:
        return `Servis güncellendi (#${service.serviceNumber})`;
    }
  }

  private getActivityIcon(status: ServiceStatus): string {
    switch (status) {
      case ServiceStatus.IN_PROGRESS:
        return '🔴';
      case ServiceStatus.COMPLETED:
        return '🔵';
      case ServiceStatus.PLANNED:
        return '🟢';
      case ServiceStatus.CANCELLED:
        return '⚪';
      default:
        return '🟡';
    }
  }
}
