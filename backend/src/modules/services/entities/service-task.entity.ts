import { Entity, Column, ManyToOne, JoinColumn } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { Service } from './service.entity';

/**
 * ServiceTask Entity - Serviste yapılan işlemler
 * Checklist tarzı iş listesi
 */
@Entity('service_tasks')
export class ServiceTask extends BaseEntity {
  @Column({ type: 'varchar', length: 255 })
  taskName: string;

  @Column({ type: 'text', nullable: true })
  description?: string;

  @Column({ type: 'boolean', default: false })
  isCompleted: boolean;

  @Column({ type: 'int', default: 0 })
  order: number; // Sıralama

  @Column({ type: 'int', nullable: true })
  durationMinutes?: number; // İşlem süresi (dakika)

  @Column({ type: 'timestamp', nullable: true })
  startedAt?: Date;

  @Column({ type: 'timestamp', nullable: true })
  completedAt?: Date;

  // Relations
  @ManyToOne(() => Service, (service) => service.serviceTasks)
  @JoinColumn({ name: 'serviceId' })
  service: Service;

  @Column({ type: 'uuid' })
  serviceId: string;
}
