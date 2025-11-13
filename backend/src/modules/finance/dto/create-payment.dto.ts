import { IsString, IsDate, IsOptional, IsNumber, IsEnum, IsUUID } from 'class-validator';
import { Type } from 'class-transformer';
import { PaymentMethod } from '../../../common/enums/payment-method.enum';

export class CreatePaymentDto {
  @IsNumber()
  amount: number;

  @IsEnum(PaymentMethod)
  paymentMethod: PaymentMethod;

  @IsDate()
  @Type(() => Date)
  paymentDate: Date;

  @IsString()
  @IsOptional()
  transactionId?: string;

  @IsString()
  @IsOptional()
  notes?: string;

  @IsUUID()
  invoiceId: string;

  @IsUUID()
  @IsOptional()
  receivedById?: string;
}
