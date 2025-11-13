import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Query,
} from '@nestjs/common';
import { RoutesService } from './routes.service';

@Controller('routes')
export class RoutesController {
  constructor(private readonly routesService: RoutesService) {}

  @Post()
  create(@Body() routeData: any) {
    return this.routesService.createRoute(routeData);
  }

  @Get()
  findAll(@Query() filters?: any) {
    return this.routesService.findAll(filters);
  }

  @Get('optimization-history')
  getOptimizationHistory(
    @Query('technicianId') technicianId?: string,
    @Query('limit') limit?: number,
  ) {
    return this.routesService.getOptimizationHistory(technicianId, limit);
  }

  @Get('technician/:technicianId/daily')
  getTechnicianDailyRoute(
    @Param('technicianId') technicianId: string,
    @Query('date') date: string,
  ) {
    return this.routesService.getTechnicianDailyRoute(
      technicianId,
      new Date(date),
    );
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.routesService.findOne(id);
  }

  @Patch(':id/status')
  updateStatus(@Param('id') id: string, @Body() body: { status: string }) {
    return this.routesService.updateStatus(id, body.status);
  }

  @Post(':id/legs')
  addRouteLeg(@Param('id') id: string, @Body() legData: any) {
    return this.routesService.addRouteLeg(id, legData);
  }

  @Post('optimization-log')
  saveOptimizationLog(@Body() logData: any) {
    return this.routesService.saveOptimizationLog(logData);
  }
}
