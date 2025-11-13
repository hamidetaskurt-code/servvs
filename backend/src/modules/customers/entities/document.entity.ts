import { Entity, Column, ManyToOne, JoinColumn, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { Customer } from './customer.entity';

/**
 * Document Entity - Dökümanlar
 * Sözleşmeler, faturalar, fotoğraflar, imzalı formlar
 */
@Entity('documents')
export class Document extends BaseEntity {
  @Column({ type: 'varchar', length: 255 })
  @Index()
  fileName: string;

  @Column({ type: 'varchar', length: 255 })
  filePath: string;

  @Column({ type: 'varchar', length: 50 })
  fileType: string; // contract, invoice, photo, form

  @Column({ type: 'varchar', length: 50 })
  mimeType: string; // application/pdf, image/jpeg, vb.

  @Column({ type: 'int' })
  fileSize: number; // Byte cinsinden

  @Column({ type: 'varchar', length: 100, nullable: true })
  category?: string;

  @Column({ type: 'text', nullable: true })
  description?: string;

  @Column({ type: 'timestamp' })
  @Index()
  uploadDate: Date;

  // Relations
  @ManyToOne(() => Customer, (customer) => customer.documents)
  @JoinColumn({ name: 'customerId' })
  customer: Customer;

  @Column({ type: 'uuid' })
  @Index()
  customerId: string;
}
