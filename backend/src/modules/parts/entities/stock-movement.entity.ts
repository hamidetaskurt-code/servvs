import { Entity, Column, ManyToOne, JoinColumn, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { Part } from './part.entity';
import { User } from '../../users/entities/user.entity';

/**
 * StockMovement Entity - Stok Hareketleri
 * Giriş, çıkış ve düzeltme hareketleri
 */
@Entity('stock_movements')
export class StockMovement extends BaseEntity {
  @Column({ type: 'varchar', length: 20 })
  movementType: string; // in (giriş), out (çıkış), adjustment (düzeltme)

  @Column({ type: 'int' })
  quantity: number;

  @Column({ type: 'int' })
  previousStock: number;

  @Column({ type: 'int' })
  newStock: number;

  @Column({ type: 'varchar', length: 255, nullable: true })
  reference?: string; // Referans (sipariş no, servis no, vb.)

  @Column({ type: 'varchar', length: 100, nullable: true })
  referenceType?: string; // order, service, adjustment, return

  @Column({ type: 'text', nullable: true })
  notes?: string;

  @Column({ type: 'timestamp' })
  @Index()
  movementDate: Date;

  // Relations
  @ManyToOne(() => Part, (part) => part.stockMovements)
  @JoinColumn({ name: 'partId' })
  part: Part;

  @Column({ type: 'uuid' })
  @Index()
  partId: string;

  @ManyToOne(() => User, { nullable: true })
  @JoinColumn({ name: 'performedById' })
  performedBy?: User;

  @Column({ type: 'uuid', nullable: true })
  performedById?: string;
}
