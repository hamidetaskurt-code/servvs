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
import { ServicesService } from './services.service';
import { CreateServiceDto } from './dto/create-service.dto';
import { UpdateServiceDto } from './dto/update-service.dto';
import { ServiceStatus } from '../../common/enums/service-status.enum';

@Controller('services')
export class ServicesController {
  constructor(private readonly servicesService: ServicesService) {}

  @Post()
  create(@Body() createServiceDto: CreateServiceDto) {
    return this.servicesService.create(createServiceDto);
  }

  @Get()
  findAll(@Query() filters?: any) {
    return this.servicesService.findAll(filters);
  }

  @Get('kanban')
  getKanbanData() {
    return this.servicesService.getKanbanData();
  }

  @Get('stats')
  getStats(@Query('startDate') startDate?: string, @Query('endDate') endDate?: string) {
    return this.servicesService.getStats(
      startDate ? new Date(startDate) : undefined,
      endDate ? new Date(endDate) : undefined,
    );
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.servicesService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateServiceDto: UpdateServiceDto) {
    return this.servicesService.update(id, updateServiceDto);
  }

  @Patch(':id/status')
  updateStatus(@Param('id') id: string, @Body() body: { status: ServiceStatus }) {
    return this.servicesService.updateStatus(id, body.status);
  }

  @Patch(':id/assign-technician')
  assignTechnician(@Param('id') id: string, @Body() body: { technicianId: string }) {
    return this.servicesService.assignTechnician(id, body.technicianId);
  }

  @Post(':id/parts')
  addPart(
    @Param('id') id: string,
    @Body() body: { partId: string; quantity: number; unitPrice: number },
  ) {
    return this.servicesService.addPart(id, body.partId, body.quantity, body.unitPrice);
  }

  @Post(':id/tasks')
  addTask(@Param('id') id: string, @Body() taskData: any) {
    return this.servicesService.addTask(id, taskData);
  }

  @Patch('tasks/:taskId/complete')
  completeTask(@Param('taskId') taskId: string) {
    return this.servicesService.completeTask(taskId);
  }

  @Post(':id/photos')
  addPhoto(@Param('id') id: string, @Body() photoData: any) {
    return this.servicesService.addPhoto(id, photoData);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.servicesService.remove(id);
  }
}
