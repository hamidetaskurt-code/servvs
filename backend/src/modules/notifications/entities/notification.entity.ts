import { Entity, Column, ManyToOne, JoinColumn, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { User } from '../../users/entities/user.entity';

/**
 * Notification Entity - Bildirimler
 * Sistem bildirimleri, uyarılar, hatırlatıcılar
 */
@Entity('notifications')
export class Notification extends BaseEntity {
  @Column({ type: 'varchar', length: 50 })
  notificationType: string; // info, warning, error, success, reminder

  @Column({ type: 'varchar', length: 255 })
  title: string;

  @Column({ type: 'text' })
  message: string;

  @Column({ type: 'varchar', length: 100, nullable: true })
  category?: string; // service, stock, payment, system

  @Column({ type: 'varchar', length: 50 })
  priority: string; // low, normal, high, urgent

  @Column({ type: 'boolean', default: false })
  isRead: boolean;

  @Column({ type: 'timestamp', nullable: true })
  readAt?: Date;

  @Column({ type: 'varchar', length: 255, nullable: true })
  actionUrl?: string; // Tıklanınca gidilecek URL

  @Column({ type: 'jsonb', nullable: true })
  metadata?: any; // Ek bilgiler

  @Column({ type: 'timestamp' })
  @Index()
  createdAt: Date;

  @Column({ type: 'timestamp', nullable: true })
  expiresAt?: Date; // Bildirim son kullanma tarihi

  // Relations
  @ManyToOne(() => User, { nullable: true })
  @JoinColumn({ name: 'userId' })
  user?: User;

  @Column({ type: 'uuid', nullable: true })
  @Index()
  userId?: string; // null ise tüm kullanıcılar için
}
