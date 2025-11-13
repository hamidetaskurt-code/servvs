import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from '@nestjs/common';
import { AppointmentsService } from './appointments.service';

@Controller('appointments')
export class AppointmentsController {
  constructor(private readonly appointmentsService: AppointmentsService) {}

  @Get('calendar')
  getCalendar(
    @Query('year') year: string,
    @Query('month') month: string,
  ) {
    return this.appointmentsService.getCalendarData(
      parseInt(year),
      parseInt(month),
    );
  }

  @Get('daily')
  getDailyAppointments(@Query('date') date: string) {
    return this.appointmentsService.getDailyAppointments(new Date(date));
  }

  @Get('weekly')
  getWeeklyAppointments(@Query('startDate') startDate: string) {
    return this.appointmentsService.getWeeklyAppointments(new Date(startDate));
  }

  @Get('technician/:technicianId')
  getTechnicianAppointments(
    @Param('technicianId') technicianId: string,
    @Query('date') date: string,
  ) {
    return this.appointmentsService.getTechnicianAppointments(
      technicianId,
      new Date(date),
    );
  }

  @Get('available-slots')
  getAvailableSlots(
    @Query('date') date: string,
    @Query('technicianId') technicianId?: string,
  ) {
    return this.appointmentsService.getAvailableSlots(
      new Date(date),
      technicianId,
    );
  }

  @Post('reschedule/:id')
  reschedule(
    @Param('id') id: string,
    @Body() body: { newDate: string; newTime: string },
  ) {
    return this.appointmentsService.rescheduleAppointment(
      id,
      new Date(`${body.newDate} ${body.newTime}`),
    );
  }

  @Get('conflicts')
  checkConflicts(
    @Query('technicianId') technicianId: string,
    @Query('date') date: string,
    @Query('duration') duration: string,
  ) {
    return this.appointmentsService.checkConflicts(
      technicianId,
      new Date(date),
      parseInt(duration),
    );
  }
}
