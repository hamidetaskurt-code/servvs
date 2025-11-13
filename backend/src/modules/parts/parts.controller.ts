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
import { PartsService } from './parts.service';
import { CreatePartDto } from './dto/create-part.dto';
import { UpdatePartDto } from './dto/update-part.dto';

@Controller('parts')
export class PartsController {
  constructor(private readonly partsService: PartsService) {}

  @Post()
  create(@Body() createPartDto: CreatePartDto) {
    return this.partsService.create(createPartDto);
  }

  @Get()
  findAll(@Query() filters?: any) {
    return this.partsService.findAll(filters);
  }

  @Get('barcode/:barcode')
  findByBarcode(@Param('barcode') barcode: string) {
    return this.partsService.findByBarcode(barcode);
  }

  @Get('critical')
  getCriticalStock() {
    return this.partsService.getCriticalStock();
  }

  @Get('low-stock')
  getLowStock() {
    return this.partsService.getLowStock();
  }

  @Get('most-used')
  getMostUsed(@Query('limit') limit?: number) {
    return this.partsService.getMostUsedParts(limit ? parseInt(limit as any) : 10);
  }

  @Get('report')
  getStockReport() {
    return this.partsService.getStockReport();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.partsService.findOne(id);
  }

  @Post(':id/stock/add')
  addStock(
    @Param('id') id: string,
    @Body() body: { quantity: number; reference?: string; referenceType?: string },
  ) {
    return this.partsService.addStock(id, body.quantity, body.reference, body.referenceType);
  }

  @Post(':id/stock/remove')
  removeStock(
    @Param('id') id: string,
    @Body() body: { quantity: number; reference?: string; referenceType?: string },
  ) {
    return this.partsService.removeStock(id, body.quantity, body.reference, body.referenceType);
  }

  @Post(':id/stock/adjust')
  adjustStock(
    @Param('id') id: string,
    @Body() body: { newQuantity: number; reason: string },
  ) {
    return this.partsService.adjustStock(id, body.newQuantity, body.reason);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updatePartDto: UpdatePartDto) {
    return this.partsService.update(id, updatePartDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.partsService.remove(id);
  }

  @Post('update-averages')
  updateAverages() {
    return this.partsService.updateMonthlyAverages();
  }
}
