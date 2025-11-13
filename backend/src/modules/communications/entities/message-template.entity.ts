import { Entity, Column } from 'typeorm';
import { BaseEntity } from '../../../common/entities/base.entity';

@Entity('message_templates')
export class MessageTemplate extends BaseEntity {
  @Column({ type: 'varchar', length: 100 })
  name: string;

  @Column({ type: 'varchar', length: 20 })
  type: string; // SMS, EMAIL, WHATSAPP

  @Column({ type: 'varchar', length: 255, nullable: true })
  subject?: string; // Email için

  @Column({ type: 'text' })
  content: string;

  @Column({ type: 'simple-array', nullable: true })
  variables?: string[]; // {{name}}, {{date}}, vb.

  @Column({ type: 'boolean', default: true })
  isActive: boolean;
}
