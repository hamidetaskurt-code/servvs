import { Controller, Get, Query } from '@nestjs/common';
import { ReportsService } from './reports.service';

@Controller('reports')
export class ReportsController {
  constructor(private readonly reportsService: ReportsService) {}

  @Get('financial/summary')
  getFinancialSummary(
    @Query('startDate') startDate: string,
    @Query('endDate') endDate: string,
  ) {
    return this.reportsService.getFinancialSummary(
      new Date(startDate),
      new Date(endDate),
    );
  }

  @Get('financial/income-expense')
  getIncomeExpenseReport(
    @Query('startDate') startDate: string,
    @Query('endDate') endDate: string,
  ) {
    return this.reportsService.getIncomeExpenseReport(
      new Date(startDate),
      new Date(endDate),
    );
  }

  @Get('financial/profit-loss')
  getProfitLossReport(
    @Query('startDate') startDate: string,
    @Query('endDate') endDate: string,
  ) {
    return this.reportsService.getProfitLossReport(
      new Date(startDate),
      new Date(endDate),
    );
  }

  @Get('operational/services')
  getServicesReport(
    @Query('startDate') startDate: string,
    @Query('endDate') endDate: string,
  ) {
    return this.reportsService.getServicesReport(
      new Date(startDate),
      new Date(endDate),
    );
  }

  @Get('operational/technicians')
  getTechniciansReport(
    @Query('startDate') startDate: string,
    @Query('endDate') endDate: string,
  ) {
    return this.reportsService.getTechniciansReport(
      new Date(startDate),
      new Date(endDate),
    );
  }

  @Get('customer/analysis')
  getCustomerAnalysis(
    @Query('startDate') startDate: string,
    @Query('endDate') endDate: string,
  ) {
    return this.reportsService.getCustomerAnalysis(
      new Date(startDate),
      new Date(endDate),
    );
  }

  @Get('customer/satisfaction')
  getSatisfactionReport(
    @Query('startDate') startDate: string,
    @Query('endDate') endDate: string,
  ) {
    return this.reportsService.getSatisfactionReport(
      new Date(startDate),
      new Date(endDate),
    );
  }

  @Get('inventory/stock')
  getStockReport() {
    return this.reportsService.getStockReport();
  }

  @Get('inventory/usage')
  getPartsUsageReport(
    @Query('startDate') startDate: string,
    @Query('endDate') endDate: string,
  ) {
    return this.reportsService.getPartsUsageReport(
      new Date(startDate),
      new Date(endDate),
    );
  }
}
