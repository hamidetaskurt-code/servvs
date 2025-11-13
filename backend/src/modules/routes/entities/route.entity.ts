import {
  Entity,
  Column,
  ManyToOne,
  OneToMany,
  JoinColumn,
  Index,
} from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { User } from '../../users/entities/user.entity';
import { RouteLeg } from './route-leg.entity';

/**
 * Route Entity - Rota Planları
 * Teknisyenlerin günlük rota planları
 */
@Entity('routes')
export class Route extends BaseEntity {
  @Column({ type: 'varchar', length: 20, unique: true })
  @Index()
  routeNumber: string; // Örn: R-2024-1234

  @Column({ type: 'date' })
  @Index()
  routeDate: Date;

  @Column({ type: 'varchar', length: 50, default: 'planned' })
  status: string; // planned, in_progress, completed, cancelled

  // Rota istatistikleri
  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  totalDistanceKm: number;

  @Column({ type: 'int', default: 0 })
  estimatedDurationMinutes: number;

  @Column({ type: 'int', default: 0 })
  actualDurationMinutes: number;

  @Column({ type: 'int', default: 0 })
  totalServices: number;

  @Column({ type: 'int', default: 0 })
  completedServices: number;

  // Optimizasyon skoru (0-100)
  @Column({ type: 'int', nullable: true })
  optimizationScore?: number;

  // Başlangıç ve bitiş lokasyonları
  @Column({ type: 'varchar', length: 255, nullable: true })
  startLocation?: string;

  @Column({ type: 'decimal', precision: 10, scale: 7, nullable: true })
  startLatitude?: number;

  @Column({ type: 'decimal', precision: 10, scale: 7, nullable: true })
  startLongitude?: number;

  @Column({ type: 'varchar', length: 255, nullable: true })
  endLocation?: string;

  @Column({ type: 'decimal', precision: 10, scale: 7, nullable: true })
  endLatitude?: number;

  @Column({ type: 'decimal', precision: 10, scale: 7, nullable: true })
  endLongitude?: number;

  // Google Maps polyline (rota çizgisi için)
  @Column({ type: 'text', nullable: true })
  polyline?: string;

  // Zaman bilgileri
  @Column({ type: 'timestamp', nullable: true })
  startedAt?: Date;

  @Column({ type: 'timestamp', nullable: true })
  completedAt?: Date;

  @Column({ type: 'text', nullable: true })
  notes?: string;

  // Relations
  @ManyToOne(() => User)
  @JoinColumn({ name: 'technicianId' })
  technician: User;

  @Column({ type: 'uuid' })
  @Index()
  technicianId: string;

  @OneToMany(() => RouteLeg, (routeLeg) => routeLeg.route)
  routeLegs: RouteLeg[];
}
