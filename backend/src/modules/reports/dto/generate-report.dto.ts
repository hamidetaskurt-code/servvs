import { IsNotEmpty, IsString, IsDateString, IsOptional, IsEnum, IsArray } from 'class-validator';

export enum ReportType {
  FINANCIAL_SUMMARY = 'financial_summary',
  INCOME_EXPENSE = 'income_expense',
  PROFIT_LOSS = 'profit_loss',
  SERVICE_REPORT = 'service_report',
  TECHNICIAN_PERFORMANCE = 'technician_performance',
  CUSTOMER_ANALYSIS = 'customer_analysis',
  SATISFACTION = 'satisfaction',
  STOCK_REPORT = 'stock_report',
  PARTS_USAGE = 'parts_usage',
}

export enum ReportFormat {
  PDF = 'pdf',
  EXCEL = 'excel',
  CSV = 'csv',
  JSON = 'json',
}

export class GenerateReportDto {
  @IsNotEmpty()
  @IsEnum(ReportType)
  reportType: ReportType;

  @IsNotEmpty()
  @IsDateString()
  startDate: string;

  @IsNotEmpty()
  @IsDateString()
  endDate: string;

  @IsOptional()
  @IsEnum(ReportFormat)
  format?: ReportFormat;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  filters?: string[]; // Örn: ['technicianId:uuid', 'status:completed']

  @IsOptional()
  @IsString()
  groupBy?: string; // Örn: 'day', 'week', 'month', 'technician'

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  includeColumns?: string[]; // Hangi kolonlar dahil edilsin

  @IsOptional()
  @IsString()
  title?: string;
}
