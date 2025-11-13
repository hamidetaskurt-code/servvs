import { Entity, Column, OneToMany, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';
import { UserRole } from '../../../common/enums/user-role.enum';
import { Service } from '../../services/entities/service.entity';

/**
 * User Entity - Kullanıcılar
 * Admin, Manager, Technician, vb. tüm sistem kullanıcıları
 */
@Entity('users')
export class User extends BaseEntity {
  @Column({ type: 'varchar', length: 100 })
  @Index()
  firstName: string;

  @Column({ type: 'varchar', length: 100 })
  lastName: string;

  @Column({ type: 'varchar', length: 255, unique: true })
  @Index()
  email: string;

  @Column({ type: 'varchar', length: 20, unique: true })
  @Index()
  phone: string;

  @Column({ type: 'varchar', length: 255 })
  password: string;

  @Column({
    type: 'enum',
    enum: UserRole,
    default: UserRole.CUSTOMER_SERVICE,
  })
  role: UserRole;

  @Column({ type: 'boolean', default: true })
  isActive: boolean;

  @Column({ type: 'varchar', length: 255, nullable: true })
  profilePicture?: string;

  @Column({ type: 'text', nullable: true })
  address?: string;

  @Column({ type: 'varchar', length: 50, nullable: true })
  city?: string;

  @Column({ type: 'varchar', length: 50, nullable: true })
  district?: string;

  // JWT için refresh token
  @Column({ type: 'varchar', length: 500, nullable: true })
  refreshToken?: string;

  // 2FA secret
  @Column({ type: 'varchar', length: 255, nullable: true })
  twoFactorSecret?: string;

  @Column({ type: 'boolean', default: false })
  twoFactorEnabled: boolean;

  // Son giriş zamanı
  @Column({ type: 'timestamp', nullable: true })
  lastLoginAt?: Date;

  // Relations
  @OneToMany(() => Service, (service) => service.assignedTechnician)
  assignedServices: Service[];

  // Virtual fields
  get fullName(): string {
    return `${this.firstName} ${this.lastName}`;
  }
}
