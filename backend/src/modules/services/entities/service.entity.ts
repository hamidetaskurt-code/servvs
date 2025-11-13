import {
  Entity,
  Column,
  ManyToOne,
  OneToMany,
  JoinColumn,
  Index,
} from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { ServiceStatus } from '../../../common/enums/service-status.enum';
import { ServiceType } from '../../../common/enums/service-type.enum';
import { Priority } from '../../../common/enums/priority.enum';
import { Customer } from '../../customers/entities/customer.entity';
import { Device } from '../../customers/entities/device.entity';
import { User } from '../../users/entities/user.entity';
import { ServicePart } from './service-part.entity';
import { ServiceTask } from './service-task.entity';
import { ServicePhoto } from './service-photo.entity';

/**
 * Service Entity - Servisler
 * Tüm servis işlemleri
 */
@Entity('services')
export class Service extends BaseEntity {
  @Column({ type: 'varchar', length: 20, unique: true })
  @Index()
  serviceNumber: string; // Örn: S-2024-1234

  @Column({
    type: 'enum',
    enum: ServiceType,
  })
  serviceType: ServiceType;

  @Column({
    type: 'enum',
    enum: ServiceStatus,
    default: ServiceStatus.PENDING,
  })
  @Index()
  status: ServiceStatus;

  @Column({
    type: 'enum',
    enum: Priority,
    default: Priority.NORMAL,
  })
  priority: Priority;

  // Arıza tanımı
  @Column({ type: 'text' })
  problemDescription: string;

  // Teknisyen teşhisi
  @Column({ type: 'text', nullable: true })
  diagnosis?: string;

  // Yapılan işlemler özeti
  @Column({ type: 'text', nullable: true })
  workPerformed?: string;

  // Tarih ve saat bilgileri
  @Column({ type: 'timestamp' })
  @Index()
  scheduledDate: Date;

  @Column({ type: 'timestamp', nullable: true })
  startedAt?: Date;

  @Column({ type: 'timestamp', nullable: true })
  completedAt?: Date;

  // Tahmini süre (dakika)
  @Column({ type: 'int', default: 120 })
  estimatedDuration: number;

  // Gerçek süre (dakika)
  @Column({ type: 'int', nullable: true })
  actualDuration?: number;

  // Garanti kapsamında mı?
  @Column({ type: 'boolean', default: false })
  isUnderWarranty: boolean;

  // Maliyet bilgileri
  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  laborCost: number; // İşçilik

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  partsCost: number; // Parça maliyeti

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  totalCost: number; // Toplam

  // Müşteri memnuniyeti
  @Column({ type: 'int', nullable: true })
  customerRating?: number; // 1-5

  @Column({ type: 'text', nullable: true })
  customerFeedback?: string;

  // İmzalar (base64 veya dosya yolu)
  @Column({ type: 'text', nullable: true })
  technicianSignature?: string;

  @Column({ type: 'text', nullable: true })
  customerSignature?: string;

  // Notlar
  @Column({ type: 'text', nullable: true })
  internalNotes?: string; // İç notlar (sadece personel görür)

  @Column({ type: 'text', nullable: true })
  technicianRecommendation?: string; // Teknisyen tavsiyeleri

  // İptal nedeni
  @Column({ type: 'text', nullable: true })
  cancellationReason?: string;

  // Relations
  @ManyToOne(() => Customer, (customer) => customer.services)
  @JoinColumn({ name: 'customerId' })
  customer: Customer;

  @Column({ type: 'uuid' })
  @Index()
  customerId: string;

  @ManyToOne(() => Device, (device) => device.services, { nullable: true })
  @JoinColumn({ name: 'deviceId' })
  device?: Device;

  @Column({ type: 'uuid', nullable: true })
  @Index()
  deviceId?: string;

  @ManyToOne(() => User, (user) => user.assignedServices, { nullable: true })
  @JoinColumn({ name: 'technicianId' })
  assignedTechnician?: User;

  @Column({ type: 'uuid', nullable: true })
  @Index()
  technicianId?: string;

  @OneToMany(() => ServicePart, (servicePart) => servicePart.service)
  serviceParts: ServicePart[];

  @OneToMany(() => ServiceTask, (serviceTask) => serviceTask.service)
  serviceTasks: ServiceTask[];

  @OneToMany(() => ServicePhoto, (servicePhoto) => servicePhoto.service)
  servicePhotos: ServicePhoto[];

  // Virtual fields
  get isCompleted(): boolean {
    return this.status === ServiceStatus.COMPLETED;
  }

  get isPending(): boolean {
    return this.status === ServiceStatus.PENDING;
  }

  get isInProgress(): boolean {
    return this.status === ServiceStatus.IN_PROGRESS;
  }
}
