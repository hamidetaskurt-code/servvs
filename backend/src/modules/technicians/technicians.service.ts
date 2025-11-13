import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Between, MoreThan } from 'typeorm';
import { User } from '../users/entities/user.entity';
import { Service } from '../services/entities/service.entity';
import { UserRole } from '../../common/enums/user-role.enum';
import { ServiceStatus } from '../../common/enums/service-status.enum';

@Injectable()
export class TechniciansService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
    @InjectRepository(Service)
    private servicesRepository: Repository<Service>,
  ) {}

  async findAll(filters?: any) {
    const where: any = { role: UserRole.TECHNICIAN };

    if (filters?.status) {
      where.isActive = filters.status === 'active';
    }

    if (filters?.expertise) {
      where.expertise = filters.expertise;
    }

    const technicians = await this.usersRepository.find({
      where,
      order: { firstName: 'ASC' },
    });

    // Her teknisyen için bugünkü istatistikleri ekle
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const techsWithStats = await Promise.all(
      technicians.map(async (tech) => {
        const todayServices = await this.servicesRepository.count({
          where: {
            technicianId: tech.id,
            scheduledDate: Between(today, tomorrow),
          },
        });

        const inProgress = await this.servicesRepository.count({
          where: {
            technicianId: tech.id,
            status: ServiceStatus.IN_PROGRESS,
          },
        });

        return {
          ...tech,
          todayServices,
          currentStatus: inProgress > 0 ? 'busy' : 'available',
        };
      }),
    );

    return techsWithStats;
  }

  async findOne(id: string) {
    const technician = await this.usersRepository.findOne({
      where: { id, role: UserRole.TECHNICIAN },
      relations: ['assignedServices'],
    });

    if (!technician) {
      throw new NotFoundException(`Technician with ID ${id} not found`);
    }

    return technician;
  }

  async getPerformance(id: string, startDate?: Date, endDate?: Date) {
    if (!startDate) {
      startDate = new Date();
      startDate.setDate(1); // Ayın ilk günü
    }
    if (!endDate) {
      endDate = new Date();
    }

    const technician = await this.findOne(id);

    // Tamamlanan servisler
    const completedServices = await this.servicesRepository.count({
      where: {
        technicianId: id,
        status: ServiceStatus.COMPLETED,
        completedAt: Between(startDate, endDate),
      },
    });

    // Ortalama tamamlanma süresi
    const services = await this.servicesRepository.find({
      where: {
        technicianId: id,
        status: ServiceStatus.COMPLETED,
        completedAt: Between(startDate, endDate),
      },
      select: ['scheduledDate', 'completedAt'],
    });

    let totalDuration = 0;
    services.forEach((service) => {
      if (service.completedAt && service.scheduledDate) {
        const duration =
          service.completedAt.getTime() - service.scheduledDate.getTime();
        totalDuration += duration;
      }
    });

    const avgDuration =
      services.length > 0
        ? Math.round(totalDuration / services.length / (1000 * 60))
        : 0; // dakika

    // Müşteri memnuniyeti
    const ratingResult = await this.servicesRepository
      .createQueryBuilder('service')
      .select('AVG(service.customerRating)', 'avg')
      .where('service.technicianId = :id', { id })
      .andWhere('service.completedAt BETWEEN :start AND :end', {
        start: startDate,
        end: endDate,
      })
      .andWhere('service.customerRating IS NOT NULL')
      .getRawOne();

    const avgRating = parseFloat((ratingResult?.avg || 0).toFixed(2));

    // İlk seferde çözüm oranı
    const totalCompleted = await this.servicesRepository.count({
      where: {
        technicianId: id,
        status: ServiceStatus.COMPLETED,
        completedAt: Between(startDate, endDate),
      },
    });

    const repeatServices = await this.servicesRepository
      .createQueryBuilder('service')
      .where('service.technicianId = :id', { id })
      .andWhere('service.completedAt BETWEEN :start AND :end', {
        start: startDate,
        end: endDate,
      })
      .andWhere('service.isRepeat = true')
      .getCount();

    const firstTimeFixRate =
      totalCompleted > 0
        ? Math.round(((totalCompleted - repeatServices) / totalCompleted) * 100)
        : 0;

    // Gelir katkısı
    const revenueResult = await this.servicesRepository
      .createQueryBuilder('service')
      .select('SUM(service.totalCost)', 'total')
      .where('service.technicianId = :id', { id })
      .andWhere('service.completedAt BETWEEN :start AND :end', {
        start: startDate,
        end: endDate,
      })
      .andWhere('service.status = :status', { status: ServiceStatus.COMPLETED })
      .getRawOne();

    const totalRevenue = parseFloat(revenueResult?.total || '0');

    return {
      technician: {
        id: technician.id,
        name: technician.fullName,
      },
      period: {
        startDate,
        endDate,
      },
      metrics: {
        completedServices,
        avgDuration, // dakika
        avgRating,
        firstTimeFixRate, // yüzde
        totalRevenue,
      },
    };
  }

  async getDailySchedule(id: string, date: Date) {
    const startOfDay = new Date(date);
    startOfDay.setHours(0, 0, 0, 0);
    const endOfDay = new Date(date);
    endOfDay.setHours(23, 59, 59, 999);

    const services = await this.servicesRepository.find({
      where: {
        technicianId: id,
        scheduledDate: Between(startOfDay, endOfDay),
      },
      relations: ['customer', 'device'],
      order: { scheduledDate: 'ASC' },
    });

    return services.map((service) => ({
      id: service.id,
      serviceNumber: service.serviceNumber,
      customer: {
        name: service.customer?.fullName,
        phone: service.customer?.phone,
        address: service.customer?.address,
        district: service.customer?.district,
      },
      device: {
        brand: service.device?.brand,
        model: service.device?.model,
      },
      scheduledTime: service.scheduledDate,
      estimatedDuration: service.estimatedDuration,
      status: service.status,
      priority: service.priority,
      serviceType: service.serviceType,
    }));
  }

  async getLeaderboard(startDate?: Date, endDate?: Date) {
    if (!startDate) {
      startDate = new Date();
      startDate.setDate(1);
    }
    if (!endDate) {
      endDate = new Date();
    }

    const technicians = await this.usersRepository.find({
      where: { role: UserRole.TECHNICIAN, isActive: true },
    });

    const leaderboard = await Promise.all(
      technicians.map(async (tech) => {
        const performance = await this.getPerformance(tech.id, startDate, endDate);
        return {
          id: tech.id,
          name: tech.fullName,
          completedServices: performance.metrics.completedServices,
          avgRating: performance.metrics.avgRating,
          totalRevenue: performance.metrics.totalRevenue,
          efficiency: performance.metrics.firstTimeFixRate,
        };
      }),
    );

    // Tamamlanan servise göre sırala
    return leaderboard.sort((a, b) => b.completedServices - a.completedServices);
  }

  async updateLocation(id: string, latitude: number, longitude: number) {
    const technician = await this.findOne(id);
    // Location tracking will be implemented with a separate tracking table
    return {
      success: true,
      message: 'Location updated',
      latitude,
      longitude,
    };
  }

  async getAvailableTechnicians(date: Date, duration: number) {
    const startOfDay = new Date(date);
    startOfDay.setHours(0, 0, 0, 0);
    const endOfDay = new Date(date);
    endOfDay.setHours(23, 59, 59, 999);

    const allTechnicians = await this.usersRepository.find({
      where: { role: UserRole.TECHNICIAN, isActive: true },
    });

    const available = await Promise.all(
      allTechnicians.map(async (tech) => {
        const servicesCount = await this.servicesRepository.count({
          where: {
            technicianId: tech.id,
            scheduledDate: Between(startOfDay, endOfDay),
            status: Between(ServiceStatus.PLANNED, ServiceStatus.IN_PROGRESS),
          },
        });

        // Maksimum günlük 8 servis varsayalım
        const isAvailable = servicesCount < 8;

        return {
          id: tech.id,
          name: tech.fullName,
          phone: tech.phone,
          currentLoad: servicesCount,
          available: isAvailable,
        };
      }),
    );

    return available.filter((t) => t.available);
  }
}
