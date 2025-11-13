import { Entity, Column, ManyToOne, JoinColumn, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { Customer } from './customer.entity';
import { User } from '../../users/entities/user.entity';

/**
 * Communication Entity - İletişim Geçmişi
 * Telefon, SMS, Email, WhatsApp mesajları
 */
@Entity('communications')
export class Communication extends BaseEntity {
  @Column({ type: 'varchar', length: 50 })
  communicationType: string; // phone, sms, email, whatsapp, system

  @Column({ type: 'varchar', length: 50 })
  direction: string; // inbound (gelen), outbound (giden)

  @Column({ type: 'varchar', length: 255, nullable: true })
  subject?: string;

  @Column({ type: 'text' })
  content: string;

  @Column({ type: 'timestamp' })
  @Index()
  communicationDate: Date;

  @Column({ type: 'int', nullable: true })
  durationSeconds?: number; // Telefon görüşmeleri için

  @Column({ type: 'varchar', length: 50, nullable: true })
  status?: string; // sent, delivered, read, failed

  @Column({ type: 'text', nullable: true })
  notes?: string;

  // Relations
  @ManyToOne(() => Customer, (customer) => customer.communications)
  @JoinColumn({ name: 'customerId' })
  customer: Customer;

  @Column({ type: 'uuid' })
  @Index()
  customerId: string;

  @ManyToOne(() => User, { nullable: true })
  @JoinColumn({ name: 'performedById' })
  performedBy?: User;

  @Column({ type: 'uuid', nullable: true })
  performedById?: string;
}
