import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DashboardController } from './dashboard.controller';
import { DashboardService } from './dashboard.service';
import { Customer } from '../customers/entities/customer.entity';
import { Service } from '../services/entities/service.entity';
import { Part } from '../parts/entities/part.entity';
import { User } from '../users/entities/user.entity';
import { Invoice } from '../finance/entities/invoice.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([Customer, Service, Part, User, Invoice]),
  ],
  controllers: [DashboardController],
  providers: [DashboardService],
})
export class DashboardModule {}
