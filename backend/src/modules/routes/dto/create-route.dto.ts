import { IsNotEmpty, IsUUID, IsDateString, IsArray, IsOptional, IsString, IsEnum } from 'class-validator';

export enum RouteStatus {
  DRAFT = 'draft',
  PLANNED = 'planned',
  IN_PROGRESS = 'in_progress',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
}

export class CreateRouteDto {
  @IsNotEmpty()
  @IsUUID()
  technicianId: string;

  @IsNotEmpty()
  @IsDateString()
  date: string;

  @IsNotEmpty()
  @IsArray()
  @IsUUID('4', { each: true })
  serviceIds: string[];

  @IsOptional()
  @IsEnum(RouteStatus)
  status?: RouteStatus;

  @IsOptional()
  @IsString()
  optimizationGoal?: string; // 'minimize_distance', 'minimize_time', 'balanced'

  @IsOptional()
  @IsString()
  startLocation?: string;

  @IsOptional()
  @IsString()
  endLocation?: string;

  @IsOptional()
  @IsString()
  notes?: string;
}
