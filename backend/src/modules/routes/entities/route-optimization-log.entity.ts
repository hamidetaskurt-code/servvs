import { Entity, Column, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';

/**
 * RouteOptimizationLog Entity - Rota Optimizasyon Logları
 * Gemini AI tarafından yapılan analizlerin logları
 */
@Entity('route_optimization_logs')
export class RouteOptimizationLog extends BaseEntity {
  @Column({ type: 'date' })
  @Index()
  optimizationDate: Date;

  @Column({ type: 'uuid' })
  @Index()
  technicianId: string;

  @Column({ type: 'int' })
  totalServices: number;

  @Column({ type: 'int' })
  alternativesGenerated: number;

  // Seçilen rota bilgileri
  @Column({ type: 'varchar', length: 10 })
  selectedAlternative: string; // A, B, C

  @Column({ type: 'int' })
  optimizationScore: number; // 0-100

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  totalDistanceKm: number;

  @Column({ type: 'int' })
  totalDurationMinutes: number;

  // AI analiz sonuçları (JSON)
  @Column({ type: 'jsonb' })
  analysisResult: any; // Gemini'den gelen tam analiz

  @Column({ type: 'jsonb', nullable: true })
  risks?: any; // Tespit edilen riskler

  @Column({ type: 'jsonb', nullable: true })
  suggestions?: any; // Öneriler

  @Column({ type: 'text', nullable: true })
  reasoning?: string; // Gemini'nin açıklaması

  @Column({ type: 'timestamp' })
  @Index()
  createdAt: Date;

  @Column({ type: 'int', nullable: true })
  processingTimeMs?: number; // İşlem süresi (milisaniye)
}
