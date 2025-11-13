import { Entity, Column, Index } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';

@Entity('settings')
export class Setting extends BaseEntity {
  @Column({ type: 'varchar', length: 100, unique: true })
  @Index()
  key: string;

  @Column({ type: 'jsonb' })
  value: any;

  @Column({ type: 'varchar', length: 50, default: 'general' })
  category: string; // company, notification, integration, backup, etc.

  @Column({ type: 'text', nullable: true })
  description?: string;
}
