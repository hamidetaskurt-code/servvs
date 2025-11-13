import { IsNotEmpty, IsString, IsArray, IsEmail, IsOptional } from 'class-validator';
import { Transform } from 'class-transformer';

export class SendEmailDto {
  @IsNotEmpty()
  @IsArray()
  @IsEmail({}, { each: true })
  @Transform(({ value }) => Array.isArray(value) ? value : [value])
  recipients: string[];

  @IsNotEmpty()
  @IsString()
  subject: string;

  @IsNotEmpty()
  @IsString()
  body: string;

  @IsOptional()
  @IsString()
  templateId?: string;

  @IsOptional()
  @IsArray()
  @IsEmail({}, { each: true })
  cc?: string[];

  @IsOptional()
  @IsArray()
  @IsEmail({}, { each: true })
  bcc?: string[];

  @IsOptional()
  @IsArray()
  attachments?: any[];

  @IsOptional()
  scheduledAt?: Date;
}
