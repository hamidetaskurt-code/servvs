import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Query,
} from '@nestjs/common';
import { FinanceService } from './finance.service';
import { CreateInvoiceDto } from './dto/create-invoice.dto';
import { CreatePaymentDto } from './dto/create-payment.dto';
import { CreateInstallmentPlanDto } from './dto/create-installment-plan.dto';
import { PaymentStatus } from '../../common/enums/payment-status.enum';

@Controller('finance')
export class FinanceController {
  constructor(private readonly financeService: FinanceService) {}

  @Post('invoices')
  createInvoice(@Body() createInvoiceDto: CreateInvoiceDto) {
    return this.financeService.createInvoice(createInvoiceDto);
  }

  @Get('invoices')
  findAllInvoices(@Query() filters?: any) {
    return this.financeService.findAllInvoices(filters);
  }

  @Get('invoices/overdue')
  getOverdueInvoices() {
    return this.financeService.getOverdueInvoices();
  }

  @Get('invoices/:id')
  findOneInvoice(@Param('id') id: string) {
    return this.financeService.findOneInvoice(id);
  }

  @Patch('invoices/:id/status')
  updateInvoiceStatus(@Param('id') id: string, @Body() body: { status: PaymentStatus }) {
    return this.financeService.updateInvoiceStatus(id, body.status);
  }

  @Post('payments')
  addPayment(@Body() createPaymentDto: CreatePaymentDto) {
    return this.financeService.addPayment(createPaymentDto);
  }

  @Get('summary')
  getFinanceSummary(
    @Query('startDate') startDate?: string,
    @Query('endDate') endDate?: string,
  ) {
    return this.financeService.getFinanceSummary(
      startDate ? new Date(startDate) : undefined,
      endDate ? new Date(endDate) : undefined,
    );
  }

  @Get('report/income-expense')
  getIncomeExpenseReport(
    @Query('startDate') startDate: string,
    @Query('endDate') endDate: string,
  ) {
    return this.financeService.getIncomeExpenseReport(
      new Date(startDate),
      new Date(endDate),
    );
  }

  @Get('customers/:customerId/profitability')
  getCustomerProfitability(@Param('customerId') customerId: string) {
    return this.financeService.getCustomerProfitability(customerId);
  }

  @Post('invoices/reminders/bulk')
  sendOverdueInvoiceReminders(
    @Body()
    body: {
      type?: 'sms' | 'email' | 'both';
      minDaysOverdue?: number;
    },
  ) {
    return this.financeService.sendOverdueInvoiceReminders(
      body.type || 'both',
      body.minDaysOverdue || 1,
    );
  }

  @Post('invoices/:id/reminder')
  sendInvoiceReminder(
    @Param('id') id: string,
    @Body() body: { type?: 'sms' | 'email' | 'both' },
  ) {
    return this.financeService.sendInvoiceReminder(id, body.type || 'both');
  }

  @Post('installments/plan')
  createInstallmentPlan(@Body() createInstallmentPlanDto: CreateInstallmentPlanDto) {
    return this.financeService.createInstallmentPlan(createInstallmentPlanDto);
  }

  @Get('installments/invoice/:invoiceId')
  getInstallmentsByInvoice(@Param('invoiceId') invoiceId: string) {
    return this.financeService.getInstallmentsByInvoice(invoiceId);
  }

  @Get('installments/customer/:customerId')
  getInstallmentsByCustomer(@Param('customerId') customerId: string) {
    return this.financeService.getInstallmentsByCustomer(customerId);
  }

  @Post('installments/:id/pay')
  payInstallment(
    @Param('id') id: string,
    @Body() body: { paymentTransactionId?: string },
  ) {
    return this.financeService.payInstallment(id, body.paymentTransactionId);
  }

  @Get('installments/upcoming')
  getUpcomingInstallments(@Query('daysAhead') daysAhead?: string) {
    return this.financeService.getUpcomingInstallments(
      daysAhead ? parseInt(daysAhead) : 7,
    );
  }

  @Get('installments/overdue')
  getOverdueInstallments() {
    return this.financeService.getOverdueInstallments();
  }
}
