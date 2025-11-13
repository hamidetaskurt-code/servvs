import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ReportsController } from './reports.controller';
import { ReportsService } from './reports.service';
import { Service } from '../services/entities/service.entity';
import { Invoice } from '../finance/entities/invoice.entity';
import { Payment } from '../finance/entities/payment.entity';
import { Customer } from '../customers/entities/customer.entity';
import { User } from '../users/entities/user.entity';
import { Part } from '../parts/entities/part.entity';
import { StockMovement } from '../parts/entities/stock-movement.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Service,
      Invoice,
      Payment,
      Customer,
      User,
      Part,
      StockMovement,
    ]),
  ],
  controllers: [ReportsController],
  providers: [ReportsService],
  exports: [ReportsService],
})
export class ReportsModule {}
