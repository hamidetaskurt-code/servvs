import { IsString, IsEnum, IsDate, IsOptional, IsBoolean, IsNumber, IsUUID } from 'class-validator';
import { Type } from 'class-transformer';
import { ServiceType } from '../../../common/enums/service-type.enum';
import { Priority } from '../../../common/enums/priority.enum';

export class CreateServiceDto {
  @IsEnum(ServiceType)
  serviceType: ServiceType;

  @IsEnum(Priority)
  @IsOptional()
  priority?: Priority;

  @IsString()
  problemDescription: string;

  @IsDate()
  @Type(() => Date)
  scheduledDate: Date;

  @IsNumber()
  @IsOptional()
  estimatedDuration?: number;

  @IsBoolean()
  @IsOptional()
  isUnderWarranty?: boolean;

  @IsNumber()
  @IsOptional()
  laborCost?: number;

  @IsString()
  @IsOptional()
  internalNotes?: string;

  @IsUUID()
  customerId: string;

  @IsUUID()
  @IsOptional()
  deviceId?: string;

  @IsUUID()
  @IsOptional()
  technicianId?: string;
}
