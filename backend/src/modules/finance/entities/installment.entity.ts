import { Entity, Column, ManyToOne, JoinColumn, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { PaymentStatus } from '../../../common/enums/payment-status.enum';
import { Invoice } from './invoice.entity';
import { Customer } from '../../customers/entities/customer.entity';

/**
 * Installment Entity - Taksitler
 * Ödeme planı taksitleri
 */
@Entity('installments')
export class Installment extends BaseEntity {
  @Column({ type: 'varchar', length: 20, unique: true })
  @Index()
  installmentNumber: string; // Örn: T-2024-1234-1

  @Column({ type: 'int' })
  installmentOrder: number; // Kaçıncı taksit (1, 2, 3...)

  @Column({ type: 'int' })
  totalInstallments: number; // Toplam taksit sayısı

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  amount: number; // Taksit tutarı

  @Column({ type: 'date' })
  @Index()
  dueDate: Date; // Vade tarihi

  @Column({
    type: 'enum',
    enum: PaymentStatus,
    default: PaymentStatus.PENDING,
  })
  @Index()
  status: PaymentStatus;

  @Column({ type: 'date', nullable: true })
  paidDate?: Date; // Ödenme tarihi

  @Column({ type: 'varchar', length: 255, nullable: true })
  paymentTransactionId?: string; // Ödeme işlem numarası

  @Column({ type: 'text', nullable: true })
  notes?: string;

  // Relations
  @ManyToOne(() => Invoice, { nullable: true })
  @JoinColumn({ name: 'invoiceId' })
  invoice?: Invoice;

  @Column({ type: 'uuid', nullable: true })
  @Index()
  invoiceId?: string;

  @ManyToOne(() => Customer)
  @JoinColumn({ name: 'customerId' })
  customer: Customer;

  @Column({ type: 'uuid' })
  @Index()
  customerId: string;

  // Virtual fields
  get isPaid(): boolean {
    return this.status === PaymentStatus.PAID;
  }

  get isOverdue(): boolean {
    return (
      this.status !== PaymentStatus.PAID && new Date() > new Date(this.dueDate)
    );
  }

  get daysPastDue(): number {
    if (!this.isOverdue) return 0;
    const today = new Date();
    const due = new Date(this.dueDate);
    return Math.ceil((today.getTime() - due.getTime()) / (1000 * 60 * 60 * 24));
  }
}
