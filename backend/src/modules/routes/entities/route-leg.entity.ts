import { Entity, Column, ManyToOne, JoinColumn } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { Route } from './route.entity';
import { Service } from '../../services/entities/service.entity';

/**
 * RouteLeg Entity - Rota Ayakları
 * Her bir servis durağı
 */
@Entity('route_legs')
export class RouteLeg extends BaseEntity {
  @Column({ type: 'int' })
  legOrder: number; // Rota sırası (0, 1, 2, ...)

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  distanceFromPreviousKm: number;

  @Column({ type: 'int', default: 0 })
  durationFromPreviousMinutes: number;

  @Column({ type: 'timestamp' })
  estimatedArrival: Date;

  @Column({ type: 'timestamp', nullable: true })
  actualArrival?: Date;

  @Column({ type: 'timestamp' })
  estimatedDeparture: Date;

  @Column({ type: 'timestamp', nullable: true })
  actualDeparture?: Date;

  @Column({ type: 'varchar', length: 50, default: 'pending' })
  status: string; // pending, arrived, in_progress, completed, skipped

  @Column({ type: 'text', nullable: true })
  notes?: string;

  // Relations
  @ManyToOne(() => Route, (route) => route.routeLegs)
  @JoinColumn({ name: 'routeId' })
  route: Route;

  @Column({ type: 'uuid' })
  routeId: string;

  @ManyToOne(() => Service)
  @JoinColumn({ name: 'serviceId' })
  service: Service;

  @Column({ type: 'uuid' })
  serviceId: string;
}
