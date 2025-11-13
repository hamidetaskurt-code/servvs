import { IsNotEmpty, IsString, IsUUID, IsDateString, IsOptional, IsEnum } from 'class-validator';

export enum AppointmentStatus {
  PENDING = 'pending',
  CONFIRMED = 'confirmed',
  IN_PROGRESS = 'in_progress',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
  RESCHEDULED = 'rescheduled',
}

export enum AppointmentPriority {
  LOW = 'low',
  NORMAL = 'normal',
  HIGH = 'high',
  URGENT = 'urgent',
}

export class CreateAppointmentDto {
  @IsNotEmpty()
  @IsUUID()
  customerId: string;

  @IsNotEmpty()
  @IsUUID()
  deviceId: string;

  @IsNotEmpty()
  @IsUUID()
  technicianId: string;

  @IsNotEmpty()
  @IsDateString()
  scheduledDate: string;

  @IsNotEmpty()
  @IsString()
  timeSlot: string; // Örn: "09:00-10:00"

  @IsEnum(AppointmentStatus)
  status: AppointmentStatus;

  @IsOptional()
  @IsEnum(AppointmentPriority)
  priority?: AppointmentPriority;

  @IsOptional()
  @IsString()
  serviceType?: string;

  @IsOptional()
  @IsString()
  problemDescription?: string;

  @IsOptional()
  @IsString()
  notes?: string;

  @IsOptional()
  @IsString()
  address?: string;
}
