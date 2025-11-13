import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
} from '@nestjs/common';
import { CustomersService } from './customers.service';
import { CreateCustomerDto } from './dto/create-customer.dto';
import { UpdateCustomerDto } from './dto/update-customer.dto';
import { CreateDeviceDto } from './dto/create-device.dto';

@Controller('customers')
export class CustomersController {
  constructor(private readonly customersService: CustomersService) {}

  @Post()
  create(@Body() createCustomerDto: CreateCustomerDto) {
    return this.customersService.create(createCustomerDto);
  }

  @Get()
  findAll(@Query() filters?: any) {
    return this.customersService.findAll(filters);
  }

  @Get('segments')
  getSegments() {
    return this.customersService.segmentCustomers();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.customersService.findOne(id);
  }

  @Get(':id/stats')
  getStats(@Param('id') id: string) {
    return this.customersService.getCustomerStats(id);
  }

  @Get(':id/devices')
  findDevices(@Param('id') id: string) {
    return this.customersService.findDevicesByCustomer(id);
  }

  @Post(':id/devices')
  addDevice(@Param('id') id: string, @Body() createDeviceDto: CreateDeviceDto) {
    return this.customersService.addDevice(id, createDeviceDto);
  }

  @Post(':id/communications')
  addCommunication(@Param('id') id: string, @Body() communicationData: any) {
    return this.customersService.addCommunication(id, communicationData);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCustomerDto: UpdateCustomerDto) {
    return this.customersService.update(id, updateCustomerDto);
  }

  @Patch(':id/satisfaction')
  updateSatisfaction(@Param('id') id: string, @Body() body: { score: number }) {
    return this.customersService.updateSatisfactionScore(id, body.score);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.customersService.remove(id);
  }
}
