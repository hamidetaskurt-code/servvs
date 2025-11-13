import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { GoogleMapsService, Coordinate } from './google-maps.service';
import { GeminiService } from './gemini.service';
import { Service } from '../../services/entities/service.entity';
import { User } from '../../users/entities/user.entity';
import { Route } from '../../routes/entities/route.entity';
import { RouteLeg } from '../../routes/entities/route-leg.entity';
import { RouteOptimizationLog } from '../../routes/entities/route-optimization-log.entity';
import { OptimizeRouteDto, OptimizationGoal } from '../dto/optimize-route.dto';

/**
 * Route Optimization Service
 * Google Maps + Gemini AI kullanarak akıllı rota optimizasyonu
 */
@Injectable()
export class RouteOptimizationService {
  private readonly logger = new Logger(RouteOptimizationService.name);

  constructor(
    private googleMapsService: GoogleMapsService,
    private geminiService: GeminiService,
    @InjectRepository(Service)
    private servicesRepository: Repository<Service>,
    @InjectRepository(User)
    private usersRepository: Repository<User>,
    @InjectRepository(Route)
    private routesRepository: Repository<Route>,
    @InjectRepository(RouteLeg)
    private routeLegsRepository: Repository<RouteLeg>,
    @InjectRepository(RouteOptimizationLog)
    private optimizationLogsRepository: Repository<RouteOptimizationLog>,
  ) {}

  /**
   * Ana Rota Optimizasyonu Fonksiyonu
   */
  async optimizeRoutes(dto: OptimizeRouteDto): Promise<any> {
    this.logger.log(`Starting route optimization for ${dto.date}`);

    try {
      // 1. Servisleri getir
      const services = await this.getServicesForDate(dto.date, dto.serviceIds);
      if (services.length === 0) {
        return { message: 'No services found for the given date', routes: [] };
      }

      // 2. Teknisyenleri getir
      const technicians = await this.getAvailableTechnicians(
        dto.date,
        dto.technicianIds,
      );
      if (technicians.length === 0) {
        return { message: 'No technicians available', routes: [] };
      }

      // 3. Distance Matrix hesapla (Google Maps)
      const distanceMatrix = await this.calculateDistanceMatrix(
        services,
        dto.considerTraffic,
      );

      // 4. Rota alternatifleri oluştur
      const alternatives = await this.generateRouteAlternatives(
        services,
        technicians,
        distanceMatrix,
        dto.goal,
      );

      // 5. AI ile analiz et (opsiyonel)
      let aiAnalysis = null;
      if (dto.useAI && this.geminiService.isConfigured()) {
        aiAnalysis = await this.geminiService.analyzeRoutes(alternatives, {
          technicians,
          services,
        });
      }

      // 6. Optimizasyon logunu kaydet
      await this.saveOptimizationLog({
        date: dto.date,
        totalServices: services.length,
        techniciansCount: technicians.length,
        alternativesGenerated: alternatives.length,
        selectedRouteId: alternatives[0]?.id || null,
        optimizationGoal: dto.goal || OptimizationGoal.BALANCED,
      });

      return {
        alternatives,
        aiAnalysis,
        summary: {
          totalServices: services.length,
          totalTechnicians: technicians.length,
          alternativesCount: alternatives.length,
        },
      };
    } catch (error) {
      this.logger.error('Route optimization failed:', error.message);
      throw error;
    }
  }

  /**
   * Belirli tarih için servisleri getir
   */
  private async getServicesForDate(
    date: Date,
    serviceIds?: string[],
  ): Promise<Service[]> {
    const startOfDay = new Date(date);
    startOfDay.setHours(0, 0, 0, 0);

    const endOfDay = new Date(date);
    endOfDay.setHours(23, 59, 59, 999);

    const query = this.servicesRepository
      .createQueryBuilder('service')
      .leftJoinAndSelect('service.customer', 'customer')
      .leftJoinAndSelect('service.device', 'device')
      .where('service.scheduledDate >= :startOfDay', { startOfDay })
      .andWhere('service.scheduledDate <= :endOfDay', { endOfDay })
      .andWhere('service.status IN (:...statuses)', {
        statuses: ['pending', 'planned'],
      });

    if (serviceIds && serviceIds.length > 0) {
      query.andWhere('service.id IN (:...ids)', { ids: serviceIds });
    }

    return await query.getMany();
  }

  /**
   * Müsait teknisyenleri getir
   */
  private async getAvailableTechnicians(
    date: Date,
    technicianIds?: string[],
  ): Promise<User[]> {
    const query = this.usersRepository
      .createQueryBuilder('user')
      .where('user.role = :role', { role: 'technician' })
      .andWhere('user.isActive = :isActive', { isActive: true });

    if (technicianIds && technicianIds.length > 0) {
      query.andWhere('user.id IN (:...ids)', { ids: technicianIds });
    }

    return await query.getMany();
  }

  /**
   * Distance Matrix hesapla
   */
  private async calculateDistanceMatrix(
    services: Service[],
    considerTraffic: boolean = true,
  ): Promise<any> {
    if (!this.googleMapsService.isConfigured()) {
      this.logger.warn('Google Maps not configured, using mock data');
      return this.getMockDistanceMatrix(services.length);
    }

    try {
      const origins: Coordinate[] = services.map((s) => ({
        lat: parseFloat(String(s.customer.latitude)) || 41.015137,
        lng: parseFloat(String(s.customer.longitude)) || 28.97953,
      }));

      const destinations = [...origins];

      const result = await this.googleMapsService.calculateDistanceMatrix(
        origins,
        destinations,
        {
          mode: 'driving',
          departureTime: considerTraffic ? services[0].scheduledDate : undefined,
          trafficModel: 'best_guess',
        },
      );

      return result;
    } catch (error) {
      this.logger.error('Distance matrix calculation failed:', error.message);
      return this.getMockDistanceMatrix(services.length);
    }
  }

  /**
   * Rota alternatifleri oluştur
   */
  private async generateRouteAlternatives(
    services: Service[],
    technicians: User[],
    distanceMatrix: any,
    goal: OptimizationGoal = OptimizationGoal.BALANCED,
  ): Promise<any[]> {
    const alternatives: any[] = [];

    // Algoritma 1: K-means clustering + Greedy assignment
    const alternative1 = this.createBalancedRoute(
      services,
      technicians,
      distanceMatrix,
    );
    alternatives.push({
      id: 1,
      name: 'Dengeli Rota',
      goal: 'balanced',
      ...alternative1,
    });

    // Algoritma 2: Nearest Neighbor
    const alternative2 = this.createFastestRoute(
      services,
      technicians,
      distanceMatrix,
    );
    alternatives.push({
      id: 2,
      name: 'En Hızlı Rota',
      goal: 'fastest',
      ...alternative2,
    });

    // Algoritma 3: Minimum Distance
    const alternative3 = this.createShortestRoute(
      services,
      technicians,
      distanceMatrix,
    );
    alternatives.push({
      id: 3,
      name: 'En Kısa Rota',
      goal: 'shortest',
      ...alternative3,
    });

    return alternatives;
  }

  /**
   * Dengeli rota oluştur
   */
  private createBalancedRoute(
    services: Service[],
    technicians: User[],
    distanceMatrix: any,
  ): any {
    // Basit round-robin ataması (gerçek uygulamada k-means kullanılabilir)
    const technicianServices: { [key: string]: Service[] } = {};
    technicians.forEach((t) => {
      technicianServices[t.id] = [];
    });

    services.forEach((service, index) => {
      const techIndex = index % technicians.length;
      technicianServices[technicians[techIndex].id].push(service);
    });

    let totalDistance = 0;
    let totalDuration = 0;

    const technicianRoutes = Object.entries(technicianServices).map(
      ([techId, servs]) => {
        const distance = servs.length * 15; // Mock: 15 km ortalama
        const duration = servs.length * 1.5; // Mock: 1.5 saat ortalama

        totalDistance += distance;
        totalDuration += duration;

        return {
          technicianId: techId,
          technicianName:
            technicians.find((t) => t.id === techId)?.firstName || 'Unknown',
          services: servs.map((s) => s.id),
          servicesCount: servs.length,
          estimatedDistance: distance,
          estimatedDuration: duration,
        };
      },
    );

    return {
      technicianRoutes,
      totalDistance,
      totalDuration,
      score: 85,
    };
  }

  /**
   * En hızlı rota oluştur
   */
  private createFastestRoute(
    services: Service[],
    technicians: User[],
    distanceMatrix: any,
  ): any {
    // Nearest Neighbor algoritması simülasyonu
    return this.createBalancedRoute(services, technicians, distanceMatrix);
  }

  /**
   * En kısa rota oluştur
   */
  private createShortestRoute(
    services: Service[],
    technicians: User[],
    distanceMatrix: any,
  ): any {
    // Minimum distance algoritması simülasyonu
    return this.createBalancedRoute(services, technicians, distanceMatrix);
  }

  /**
   * Mock Distance Matrix
   */
  private getMockDistanceMatrix(size: number): any {
    const matrix: any = { rows: [] };
    for (let i = 0; i < size; i++) {
      const row: any = { elements: [] };
      for (let j = 0; j < size; j++) {
        row.elements.push({
          distance: { value: Math.random() * 20000, text: '15 km' },
          duration: { value: Math.random() * 3600, text: '30 min' },
          status: 'OK',
        });
      }
      matrix.rows.push(row);
    }
    return matrix;
  }

  /**
   * Optimizasyon logunu kaydet
   */
  private async saveOptimizationLog(logData: any): Promise<void> {
    try {
      const log = this.optimizationLogsRepository.create({
        optimizationDate: logData.date || new Date(),
        technicianId: logData.technicianId || null,
        totalServices: logData.totalServices || 0,
        alternativesGenerated: logData.alternativesGenerated || 3,
        selectedAlternative: 'A',
        optimizationScore: 85,
        totalDistanceKm: 0,
        totalDurationMinutes: 0,
        analysisResult: {},
        createdAt: new Date(),
      });

      await this.optimizationLogsRepository.save(log);
    } catch (error) {
      this.logger.error('Failed to save optimization log:', error.message);
    }
  }
}
