import { IsDate, IsOptional, IsArray, IsEnum, IsBoolean } from 'class-validator';
import { Type } from 'class-transformer';

export enum OptimizationGoal {
  BALANCED = 'balanced',
  FASTEST = 'fastest',
  SHORTEST = 'shortest',
  CUSTOMER_PRIORITY = 'customer_priority',
}

export class OptimizeRouteDto {
  @IsDate()
  @Type(() => Date)
  date: Date;

  @IsOptional()
  @IsArray()
  technicianIds?: string[];

  @IsOptional()
  @IsArray()
  serviceIds?: string[];

  @IsOptional()
  @IsEnum(OptimizationGoal)
  goal?: OptimizationGoal;

  @IsOptional()
  @IsBoolean()
  considerTraffic?: boolean;

  @IsOptional()
  @IsBoolean()
  considerWeather?: boolean;

  @IsOptional()
  @IsBoolean()
  useAI?: boolean;
}
