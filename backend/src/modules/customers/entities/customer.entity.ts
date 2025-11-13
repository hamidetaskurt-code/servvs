import { Entity, Column, OneToMany, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { CustomerType } from '../../../common/enums/customer-type.enum';
import { Device } from './device.entity';
import { Service } from '../../services/entities/service.entity';
import { Invoice } from '../../finance/entities/invoice.entity';
import { Document } from './document.entity';
import { Communication } from './communication.entity';

/**
 * Customer Entity - Müşteriler
 * Hem bireysel hem kurumsal müşteriler
 */
@Entity('customers')
export class Customer extends BaseEntity {
  @Column({ type: 'varchar', length: 100 })
  @Index()
  firstName: string;

  @Column({ type: 'varchar', length: 100 })
  lastName: string;

  @Column({ type: 'varchar', length: 20 })
  @Index()
  phone: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  email?: string;

  @Column({
    type: 'enum',
    enum: CustomerType,
    default: CustomerType.INDIVIDUAL,
  })
  customerType: CustomerType;

  // Kurumsal müşteriler için
  @Column({ type: 'varchar', length: 255, nullable: true })
  companyName?: string;

  @Column({ type: 'varchar', length: 20, nullable: true })
  taxNumber?: string;

  // Adres bilgileri
  @Column({ type: 'text' })
  address: string;

  @Column({ type: 'varchar', length: 50 })
  city: string;

  @Column({ type: 'varchar', length: 50 })
  district: string;

  @Column({ type: 'varchar', length: 100, nullable: true })
  neighborhood?: string;

  @Column({ type: 'varchar', length: 10, nullable: true })
  postalCode?: string;

  // Geocoded location
  @Column({ type: 'decimal', precision: 10, scale: 7, nullable: true })
  latitude?: number;

  @Column({ type: 'decimal', precision: 10, scale: 7, nullable: true })
  longitude?: number;

  @Column({ type: 'varchar', length: 255, nullable: true })
  placeId?: string; // Google Places ID

  // Etiketler (VIP, Sadık, Sorunlu, vb.)
  @Column({ type: 'simple-array', nullable: true })
  tags?: string[];

  // Müşteri notları
  @Column({ type: 'text', nullable: true })
  notes?: string;

  // İletişim tercihleri
  @Column({ type: 'boolean', default: true })
  allowSms: boolean;

  @Column({ type: 'boolean', default: true })
  allowEmail: boolean;

  @Column({ type: 'boolean', default: true })
  allowWhatsapp: boolean;

  // Müşteri skoru ve istatistikler
  @Column({ type: 'decimal', precision: 3, scale: 2, default: 0 })
  satisfactionScore: number; // 0-5 arası

  @Column({ type: 'int', default: 0 })
  totalServices: number;

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  totalSpent: number;

  @Column({ type: 'timestamp', nullable: true })
  lastServiceDate?: Date;

  // Relations
  @OneToMany(() => Device, (device) => device.customer)
  devices: Device[];

  @OneToMany(() => Service, (service) => service.customer)
  services: Service[];

  @OneToMany(() => Invoice, (invoice) => invoice.customer)
  invoices: Invoice[];

  @OneToMany(() => Document, (document) => document.customer)
  documents: Document[];

  @OneToMany(() => Communication, (communication) => communication.customer)
  communications: Communication[];

  // Virtual fields
  get fullName(): string {
    return `${this.firstName} ${this.lastName}`;
  }

  get displayName(): string {
    return this.customerType === CustomerType.CORPORATE && this.companyName
      ? this.companyName
      : this.fullName;
  }
}
