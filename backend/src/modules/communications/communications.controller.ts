import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Query,
  Param,
} from '@nestjs/common';
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
  getCampaigns(@Query('status') status?: string) {
    return this.communicationsService.getCampaigns(status);
  }

  @Get('campaigns/:id')
  getCampaign(@Param('id') id: string) {
    return this.communicationsService.getCampaign(id);
  }

  @Put('campaigns/:id')
  updateCampaign(@Param('id') id: string, @Body() updateData: any) {
    return this.communicationsService.updateCampaign(id, updateData);
  }

  @Delete('campaigns/:id')
  deleteCampaign(@Param('id') id: string) {
    return this.communicationsService.deleteCampaign(id);
  }

  @Get('campaigns/:id/stats')
  getCampaignStats(@Param('id') id: string) {
    return this.communicationsService.getCampaignStats(id);
  }

  @Post('campaigns/:id/send')
  sendCampaign(@Param('id') id: string) {
    return this.communicationsService.sendCampaign(id);
  }
}
