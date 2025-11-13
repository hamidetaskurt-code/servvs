import { IsUUID, IsNumber, IsDateString, IsOptional, IsString, Min } from 'class-validator';

export class CreateInstallmentPlanDto {
  @IsUUID()
  invoiceId: string;

  @IsNumber()
  @Min(2)
  numberOfInstallments: number; // Kaç taksit

  @IsDateString()
  firstDueDate: string; // İlk taksit tarihi

  @IsNumber()
  @Min(1)
  intervalDays: number; // Taksitler arası gün sayısı (örn: 30 gün)

  @IsOptional()
  @IsString()
  notes?: string;
}
