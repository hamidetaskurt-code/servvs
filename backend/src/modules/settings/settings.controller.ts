import { Controller, Get, Post, Body, Patch, Param } from '@nestjs/common';
import { SettingsService } from './settings.service';

@Controller('settings')
export class SettingsController {
  constructor(private readonly settingsService: SettingsService) {}

  @Get()
  findAll() {
    return this.settingsService.findAll();
  }

  @Get(':key')
  findOne(@Param('key') key: string) {
    return this.settingsService.findOne(key);
  }

  @Post()
  create(@Body() settingData: any) {
    return this.settingsService.create(settingData);
  }

  @Patch(':key')
  update(@Param('key') key: string, @Body() body: { value: any }) {
    return this.settingsService.update(key, body.value);
  }

  @Get('company/info')
  getCompanyInfo() {
    return this.settingsService.getCompanyInfo();
  }

  @Post('company/info')
  updateCompanyInfo(@Body() companyData: any) {
    return this.settingsService.updateCompanyInfo(companyData);
  }
}
