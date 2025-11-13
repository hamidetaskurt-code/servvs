import { Entity, Column, OneToMany, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { StockMovement } from './stock-movement.entity';

/**
 * Part Entity - Yedek Parçalar
 * Stok yönetimi için parça bilgileri
 */
@Entity('parts')
export class Part extends BaseEntity {
  @Column({ type: 'varchar', length: 50, unique: true })
  @Index()
  partCode: string; // Örn: PR-001245

  @Column({ type: 'varchar', length: 255 })
  @Index()
  partName: string;

  @Column({ type: 'varchar', length: 100 })
  category: string; // Örn: Isıtma Elemanları

  @Column({ type: 'text', nullable: true })
  description?: string;

  @Column({ type: 'varchar', length: 100, nullable: true })
  brand?: string;

  @Column({ type: 'varchar', length: 100, nullable: true })
  model?: string;

  @Column({ type: 'varchar', length: 100, unique: true, nullable: true })
  @Index()
  barcode?: string;

  // Stok bilgileri
  @Column({ type: 'int', default: 0 })
  stockQuantity: number;

  @Column({ type: 'int', default: 10 })
  minStockLevel: number; // Minimum stok seviyesi

  @Column({ type: 'int', default: 100 })
  maxStockLevel: number; // Maximum stok seviyesi

  @Column({ type: 'int', default: 20 })
  reorderLevel: number; // Yeniden sipariş seviyesi

  // Fiyat bilgileri
  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  unitPrice: number; // Birim fiyat

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  costPrice: number; // Maliyet fiyatı

  @Column({ type: 'varchar', length: 20, default: 'adet' })
  unit: string; // Birim (adet, metre, kg, vb.)

  // Raf ve lokasyon
  @Column({ type: 'varchar', length: 50, nullable: true })
  shelfLocation?: string; // Örn: A-12-03

  @Column({ type: 'varchar', length: 100, default: 'Ana Depo' })
  warehouse: string;

  // Tedarikçi bilgisi
  @Column({ type: 'varchar', length: 255, nullable: true })
  supplier?: string;

  @Column({ type: 'varchar', length: 20, nullable: true })
  supplierPhone?: string;

  @Column({ type: 'int', nullable: true })
  leadTimeDays?: number; // Tedarik süresi (gün)

  // İstatistikler
  @Column({ type: 'int', default: 0 })
  totalUsed: number; // Toplam kullanım

  @Column({ type: 'decimal', precision: 5, scale: 2, default: 0 })
  monthlyAverage: number; // Aylık ortalama kullanım

  @Column({ type: 'timestamp', nullable: true })
  lastUsedDate?: Date;

  @Column({ type: 'timestamp', nullable: true })
  lastRestockedDate?: Date;

  // Durum
  @Column({ type: 'boolean', default: true })
  isActive: boolean;

  @Column({ type: 'text', nullable: true })
  notes?: string;

  // Relations
  @OneToMany(() => StockMovement, (movement) => movement.part)
  stockMovements: StockMovement[];

  // Virtual fields
  get stockStatus(): string {
    if (this.stockQuantity === 0) return 'out_of_stock';
    if (this.stockQuantity <= this.minStockLevel) return 'critical';
    if (this.stockQuantity <= this.reorderLevel) return 'low';
    if (this.stockQuantity >= this.maxStockLevel) return 'overstock';
    return 'normal';
  }

  get estimatedDaysUntilEmpty(): number | null {
    if (this.monthlyAverage === 0) return null;
    const dailyAverage = this.monthlyAverage / 30;
    return Math.ceil(this.stockQuantity / dailyAverage);
  }
}
