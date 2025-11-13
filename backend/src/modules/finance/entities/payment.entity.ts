import { Entity, Column, ManyToOne, JoinColumn, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { PaymentMethod } from '../../../common/enums/payment-method.enum';
import { Invoice } from './invoice.entity';
import { User } from '../../users/entities/user.entity';

/**
 * Payment Entity - Ödemeler
 * Fatura ödemeleri
 */
@Entity('payments')
export class Payment extends BaseEntity {
  @Column({ type: 'varchar', length: 20, unique: true })
  @Index()
  paymentNumber: string; // Örn: P-2024-1234

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  amount: number;

  @Column({
    type: 'enum',
    enum: PaymentMethod,
  })
  paymentMethod: PaymentMethod;

  @Column({ type: 'date' })
  @Index()
  paymentDate: Date;

  @Column({ type: 'varchar', length: 255, nullable: true })
  transactionId?: string; // Banka işlem numarası

  @Column({ type: 'text', nullable: true })
  notes?: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  receiptPath?: string; // Makbuz dosya yolu

  // Relations
  @ManyToOne(() => Invoice, (invoice) => invoice.payments)
  @JoinColumn({ name: 'invoiceId' })
  invoice: Invoice;

  @Column({ type: 'uuid' })
  @Index()
  invoiceId: string;

  @ManyToOne(() => User, { nullable: true })
  @JoinColumn({ name: 'receivedById' })
  receivedBy?: User;

  @Column({ type: 'uuid', nullable: true })
  receivedById?: string;
}
