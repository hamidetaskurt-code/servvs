import {
  Entity,
  Column,
  ManyToOne,
  OneToMany,
  JoinColumn,
  Index,
} from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { PaymentStatus } from '../../../common/enums/payment-status.enum';
import { Customer } from '../../customers/entities/customer.entity';
import { Service } from '../../services/entities/service.entity';
import { Payment } from './payment.entity';

/**
 * Invoice Entity - Faturalar
 * Servis bazlı fatura yönetimi
 */
@Entity('invoices')
export class Invoice extends BaseEntity {
  @Column({ type: 'varchar', length: 20, unique: true })
  @Index()
  invoiceNumber: string; // Örn: F-2024-1234

  @Column({ type: 'date' })
  @Index()
  invoiceDate: Date;

  @Column({ type: 'date' })
  @Index()
  dueDate: Date;

  @Column({
    type: 'enum',
    enum: PaymentStatus,
    default: PaymentStatus.PENDING,
  })
  @Index()
  status: PaymentStatus;

  // Tutar bilgileri
  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  subtotal: number; // Ara toplam

  @Column({ type: 'decimal', precision: 5, scale: 2, default: 20 })
  taxRate: number; // KDV oranı (%)

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  taxAmount: number; // KDV tutarı

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  discountAmount: number; // İndirim

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  totalAmount: number; // Toplam tutar

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  paidAmount: number; // Ödenen tutar

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  remainingAmount: number; // Kalan tutar

  // Notlar
  @Column({ type: 'text', nullable: true })
  notes?: string;

  @Column({ type: 'text', nullable: true })
  paymentInstructions?: string;

  // E-Fatura bilgileri
  @Column({ type: 'boolean', default: false })
  isEInvoice: boolean;

  @Column({ type: 'varchar', length: 255, nullable: true })
  eInvoiceId?: string;

  @Column({ type: 'timestamp', nullable: true })
  eInvoiceSentAt?: Date;

  // PDF yolu
  @Column({ type: 'varchar', length: 255, nullable: true })
  pdfPath?: string;

  // Relations
  @ManyToOne(() => Customer, (customer) => customer.invoices)
  @JoinColumn({ name: 'customerId' })
  customer: Customer;

  @Column({ type: 'uuid' })
  @Index()
  customerId: string;

  @ManyToOne(() => Service, { nullable: true })
  @JoinColumn({ name: 'serviceId' })
  service?: Service;

  @Column({ type: 'uuid', nullable: true })
  @Index()
  serviceId?: string;

  @OneToMany(() => Payment, (payment) => payment.invoice)
  payments: Payment[];

  // Virtual fields
  get isPaid(): boolean {
    return this.status === PaymentStatus.PAID;
  }

  get isOverdue(): boolean {
    return (
      this.status !== PaymentStatus.PAID &&
      new Date() > new Date(this.dueDate)
    );
  }

  get daysPastDue(): number {
    if (!this.isOverdue) return 0;
    const today = new Date();
    const due = new Date(this.dueDate);
    return Math.ceil((today.getTime() - due.getTime()) / (1000 * 60 * 60 * 24));
  }
}
