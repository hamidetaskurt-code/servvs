import { IsNotEmpty, IsString, IsArray, IsOptional } from 'class-validator';
import { Transform } from 'class-transformer';

export class SendSmsDto {
  @IsNotEmpty()
  @IsArray()
  @IsString({ each: true })
  @Transform(({ value }) => Array.isArray(value) ? value : [value])
  recipients: string[]; // Telefon numaraları

  @IsNotEmpty()
  @IsString()
  message: string;

  @IsOptional()
  @IsString()
  templateId?: string;

  @IsOptional()
  @IsString()
  senderId?: string; // SMS gönderen ismi

  @IsOptional()
  scheduledAt?: Date;
}
