import { Entity, Column, ManyToOne, OneToMany, JoinColumn, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { Customer } from './customer.entity';
import { Service } from '../../services/entities/service.entity';

/**
 * Device Entity - Cihazlar (Kombiler)
 * Her cihaz bir müşteriye ait
 */
@Entity('devices')
export class Device extends BaseEntity {
  @Column({ type: 'varchar', length: 100 })
  brand: string;

  @Column({ type: 'varchar', length: 100 })
  model: string;

  @Column({ type: 'varchar', length: 100, unique: true })
  @Index()
  serialNumber: string;

  @Column({ type: 'date' })
  installationDate: Date;

  @Column({ type: 'date', nullable: true })
  warrantyEndDate?: Date;

  @Column({ type: 'int', nullable: true })
  warrantyMonths?: number;

  @Column({ type: 'varchar', length: 50, nullable: true })
  capacity?: string; // Örn: "24 kW"

  @Column({ type: 'text', nullable: true })
  notes?: string;

  @Column({ type: 'boolean', default: true })
  isActive: boolean;

  // Cihaz yaşı (yıl)
  @Column({ type: 'int', default: 0 })
  ageInYears: number;

  // Toplam servis sayısı
  @Column({ type: 'int', default: 0 })
  totalServices: number;

  // Son servis tarihi
  @Column({ type: 'timestamp', nullable: true })
  lastServiceDate?: Date;

  // Relations
  @ManyToOne(() => Customer, (customer) => customer.devices)
  @JoinColumn({ name: 'customerId' })
  customer: Customer;

  @Column({ type: 'uuid' })
  @Index()
  customerId: string;

  @OneToMany(() => Service, (service) => service.device)
  services: Service[];

  // Virtual fields
  get isUnderWarranty(): boolean {
    if (!this.warrantyEndDate) return false;
    return new Date() < new Date(this.warrantyEndDate);
  }

  get warrantyStatus(): string {
    if (!this.warrantyEndDate) return 'no_warranty';
    const now = new Date();
    const endDate = new Date(this.warrantyEndDate);

    if (now > endDate) return 'expired';

    const daysLeft = Math.ceil((endDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24));
    if (daysLeft <= 30) return 'expiring_soon';

    return 'active';
  }
}
