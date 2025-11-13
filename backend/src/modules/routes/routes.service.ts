import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Route } from './entities/route.entity';
import { RouteLeg } from './entities/route-leg.entity';
import { RouteOptimizationLog } from './entities/route-optimization-log.entity';

@Injectable()
export class RoutesService {
  constructor(
    @InjectRepository(Route)
    private routesRepository: Repository<Route>,
    @InjectRepository(RouteLeg)
    private routeLegsRepository: Repository<RouteLeg>,
    @InjectRepository(RouteOptimizationLog)
    private optimizationLogsRepository: Repository<RouteOptimizationLog>,
  ) {}

  // Rota numarası oluştur
  private async generateRouteNumber(): Promise<string> {
    const year = new Date().getFullYear();
    const count = await this.routesRepository.count();
    return `R-${year}-${String(count + 1).padStart(4, '0')}`;
  }

  async createRoute(routeData: any): Promise<Route> {
    const routeNumber = await this.generateRouteNumber();
    const route = this.routesRepository.create({
      ...routeData,
      routeNumber,
    });
    return (await this.routesRepository.save(route)) as unknown as Route;
  }

  async findAll(filters?: any): Promise<Route[]> {
    const where: any = {};

    if (filters?.technicianId) {
      where.technicianId = filters.technicianId;
    }

    if (filters?.status) {
      where.status = filters.status;
    }

    if (filters?.routeDate) {
      where.routeDate = new Date(filters.routeDate);
    }

    return await this.routesRepository.find({
      where,
      relations: ['technician', 'routeLegs', 'routeLegs.service'],
      order: { routeDate: 'DESC' },
    });
  }

  async findOne(id: string): Promise<Route> {
    const route = await this.routesRepository.findOne({
      where: { id },
      relations: [
        'technician',
        'routeLegs',
        'routeLegs.service',
        'routeLegs.service.customer',
      ],
    });

    if (!route) {
      throw new NotFoundException(`Route with ID ${id} not found`);
    }

    return route;
  }

  async updateStatus(id: string, status: string): Promise<Route> {
    const route = await this.findOne(id);
    route.status = status;

    if (status === 'in_progress' && !route.startedAt) {
      route.startedAt = new Date();
    }

    if (status === 'completed') {
      route.completedAt = new Date();
      if (route.startedAt) {
        route.actualDurationMinutes = Math.ceil(
          (route.completedAt.getTime() - route.startedAt.getTime()) /
            (1000 * 60),
        );
      }
    }

    return await this.routesRepository.save(route);
  }

  // Rota ayağı ekleme
  async addRouteLeg(routeId: string, legData: any): Promise<RouteLeg> {
    const route = await this.findOne(routeId);
    const leg = this.routeLegsRepository.create({
      ...legData,
      routeId,
    });
    return (await this.routeLegsRepository.save(leg)) as unknown as RouteLeg;
  }

  // Optimizasyon logu kaydetme
  async saveOptimizationLog(logData: any): Promise<RouteOptimizationLog> {
    const log = this.optimizationLogsRepository.create({
      ...logData,
      createdAt: new Date(),
    });
    return (await this.optimizationLogsRepository.save(log)) as unknown as RouteOptimizationLog;
  }

  // Teknisyen için günlük rota
  async getTechnicianDailyRoute(
    technicianId: string,
    date: Date,
  ): Promise<Route | null> {
    return await this.routesRepository.findOne({
      where: {
        technicianId,
        routeDate: date,
      },
      relations: ['routeLegs', 'routeLegs.service', 'routeLegs.service.customer'],
    });
  }

  // Rota optimizasyon geçmişi
  async getOptimizationHistory(
    technicianId?: string,
    limit: number = 10,
  ): Promise<RouteOptimizationLog[]> {
    const where: any = {};
    if (technicianId) {
      where.technicianId = technicianId;
    }

    return await this.optimizationLogsRepository.find({
      where,
      order: { createdAt: 'DESC' },
      take: limit,
    });
  }
}
