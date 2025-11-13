import { Controller, Get, Param, Query, Patch, Body } from '@nestjs/common';
import { TechniciansService } from './technicians.service';

@Controller('technicians')
export class TechniciansController {
  constructor(private readonly techniciansService: TechniciansService) {}

  @Get()
  findAll(@Query() filters?: any) {
    return this.techniciansService.findAll(filters);
  }

  @Get('leaderboard')
  getLeaderboard(
    @Query('startDate') startDate?: string,
    @Query('endDate') endDate?: string,
  ) {
    return this.techniciansService.getLeaderboard(
      startDate ? new Date(startDate) : undefined,
      endDate ? new Date(endDate) : undefined,
    );
  }

  @Get('available')
  getAvailable(@Query('date') date: string, @Query('duration') duration: string) {
    return this.techniciansService.getAvailableTechnicians(
      new Date(date),
      parseInt(duration),
    );
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.techniciansService.findOne(id);
  }

  @Get(':id/performance')
  getPerformance(
    @Param('id') id: string,
    @Query('startDate') startDate?: string,
    @Query('endDate') endDate?: string,
  ) {
    return this.techniciansService.getPerformance(
      id,
      startDate ? new Date(startDate) : undefined,
      endDate ? new Date(endDate) : undefined,
    );
  }

  @Get(':id/schedule')
  getDailySchedule(@Param('id') id: string, @Query('date') date: string) {
    return this.techniciansService.getDailySchedule(id, new Date(date));
  }

  @Patch(':id/location')
  updateLocation(
    @Param('id') id: string,
    @Body() body: { latitude: number; longitude: number },
  ) {
    return this.techniciansService.updateLocation(id, body.latitude, body.longitude);
  }
}
