import { Controller, Get, Post, Body, Query, Param } from '@nestjs/common';
import { CommunicationsService } from './communications.service';

@Controller('communications')
export class CommunicationsController {
  constructor(private readonly communicationsService: CommunicationsService) {}

  @Get('stats')
  getStats(
    @Query('startDate') startDate?: string,
    @Query('endDate') endDate?: string,
  ) {
    return this.communicationsService.getStats(
      startDate ? new Date(startDate) : undefined,
      endDate ? new Date(endDate) : undefined,
    );
  }

  @Post('sms/send')
  sendSMS(@Body() body: { to: string; message: string }) {
    return this.communicationsService.sendSMS(body.to, body.message);
  }

  @Post('sms/bulk')
  sendBulkSMS(@Body() body: { recipients: string[]; message: string }) {
    return this.communicationsService.sendBulkSMS(body.recipients, body.message);
  }

  @Post('email/send')
  sendEmail(@Body() body: { to: string; subject: string; body: string }) {
    return this.communicationsService.sendEmail(body.to, body.subject, body.body);
  }

  @Post('email/bulk')
  sendBulkEmail(
    @Body() body: { recipients: string[]; subject: string; body: string },
  ) {
    return this.communicationsService.sendBulkEmail(
      body.recipients,
      body.subject,
      body.body,
    );
  }

  @Post('whatsapp/send')
  sendWhatsApp(@Body() body: { to: string; message: string }) {
    return this.communicationsService.sendWhatsApp(body.to, body.message);
  }

  @Get('templates')
  getTemplates(@Query('type') type?: string) {
    return this.communicationsService.getTemplates(type);
  }

  @Post('templates')
  createTemplate(@Body() templateData: any) {
    return this.communicationsService.createTemplate(templateData);
  }

  @Get('history')
  getHistory(
    @Query('customerId') customerId?: string,
    @Query('type') type?: string,
    @Query('limit') limit?: string,
  ) {
    return this.communicationsService.getHistory(
      customerId,
      type,
      limit ? parseInt(limit) : 50,
    );
  }

  @Post('campaigns')
  createCampaign(@Body() campaignData: any) {
    return this.communicationsService.createCampaign(campaignData);
  }

  @Get('campaigns')
  getCampaigns() {
    return this.communicationsService.getCampaigns();
  }

  @Get('campaigns/:id/stats')
  getCampaignStats(@Param('id') id: string) {
    return this.communicationsService.getCampaignStats(id);
  }
}
