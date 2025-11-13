import { Entity, Column, ManyToOne, JoinColumn } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { Service } from './service.entity';

/**
 * ServicePhoto Entity - Servis fotoğrafları
 * Servis öncesi, sorun detayı, servis sonrası fotoğraflar
 */
@Entity('service_photos')
export class ServicePhoto extends BaseEntity {
  @Column({ type: 'varchar', length: 255 })
  filePath: string;

  @Column({ type: 'varchar', length: 50 })
  photoType: string; // before, problem, after, part

  @Column({ type: 'text', nullable: true })
  description?: string;

  @Column({ type: 'int', default: 0 })
  order: number;

  // Relations
  @ManyToOne(() => Service, (service) => service.servicePhotos)
  @JoinColumn({ name: 'serviceId' })
  service: Service;

  @Column({ type: 'uuid' })
  serviceId: string;
}
