import { Entity, Column, ManyToOne, JoinColumn } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { Service } from './service.entity';
import { Part } from '../../parts/entities/part.entity';

/**
 * ServicePart Entity - Serviste kullanılan parçalar
 * Many-to-Many ilişki için junction table
 */
@Entity('service_parts')
export class ServicePart extends BaseEntity {
  @Column({ type: 'int' })
  quantity: number;

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  unitPrice: number;

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  totalPrice: number;

  @Column({ type: 'text', nullable: true })
  notes?: string;

  // Relations
  @ManyToOne(() => Service, (service) => service.serviceParts)
  @JoinColumn({ name: 'serviceId' })
  service: Service;

  @Column({ type: 'uuid' })
  serviceId: string;

  @ManyToOne(() => Part)
  @JoinColumn({ name: 'partId' })
  part: Part;

  @Column({ type: 'uuid' })
  partId: string;
}
