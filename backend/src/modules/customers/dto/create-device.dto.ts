import { IsString, IsDate, IsOptional, IsBoolean, IsInt } from 'class-validator';
import { Type } from 'class-transformer';

export class CreateDeviceDto {
  @IsString()
  brand: string;

  @IsString()
  model: string;

  @IsString()
  serialNumber: string;

  @IsDate()
  @Type(() => Date)
  installationDate: Date;

  @IsDate()
  @Type(() => Date)
  @IsOptional()
  warrantyEndDate?: Date;

  @IsInt()
  @IsOptional()
  warrantyMonths?: number;

  @IsString()
  @IsOptional()
  capacity?: string;

  @IsString()
  @IsOptional()
  notes?: string;

  @IsBoolean()
  @IsOptional()
  isActive?: boolean;
}
