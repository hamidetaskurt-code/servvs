import { IsString, IsDate, IsOptional, IsNumber, IsBoolean, IsUUID, IsEnum } from 'class-validator';
import { Type } from 'class-transformer';
import { PaymentStatus } from '../../../common/enums/payment-status.enum';

export class CreateInvoiceDto {
  @IsDate()
  @Type(() => Date)
  invoiceDate: Date;

  @IsDate()
  @Type(() => Date)
  dueDate: Date;

  @IsEnum(PaymentStatus)
  @IsOptional()
  status?: PaymentStatus;

  @IsNumber()
  subtotal: number;

  @IsNumber()
  @IsOptional()
  taxRate?: number;

  @IsNumber()
  @IsOptional()
  discountAmount?: number;

  @IsString()
  @IsOptional()
  notes?: string;

  @IsString()
  @IsOptional()
  paymentInstructions?: string;

  @IsBoolean()
  @IsOptional()
  isEInvoice?: boolean;

  @IsUUID()
  customerId: string;

  @IsUUID()
  @IsOptional()
  serviceId?: string;
}
