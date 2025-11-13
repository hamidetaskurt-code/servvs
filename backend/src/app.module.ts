import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { DashboardModule } from './modules/dashboard/dashboard.module';
import { CustomersModule } from './modules/customers/customers.module';
import { ServicesModule } from './modules/services/services.module';
import { PartsModule } from './modules/parts/parts.module';
import { UsersModule } from './modules/users/users.module';
import { FinanceModule } from './modules/finance/finance.module';
import { RoutesModule } from './modules/routes/routes.module';
import { RouteOptimizationModule } from './modules/route-optimization/route-optimization.module';
import { AppointmentsModule } from './modules/appointments/appointments.module';
import { TechniciansModule } from './modules/technicians/technicians.module';
import { ReportsModule } from './modules/reports/reports.module';
import { CommunicationsModule } from './modules/communications/communications.module';
import { SettingsModule } from './modules/settings/settings.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST || 'akin-kombi-db.cefaws2swb2i.us-east-1.rds.amazonaws.com',
      port: parseInt(process.env.DB_PORT) || 5432,
      username: process.env.DB_USERNAME || 'akinadmin',
      password: process.env.DB_PASSWORD || 'AkinKombi2024!Secure',
      database: process.env.DB_NAME || 'akinkombi_new',
      entities: [__dirname + '/**/*.entity{.ts,.js}'],
      synchronize: false, // Production'da false olmalı
      logging: true,
    }),
    DashboardModule,
    CustomersModule,
    ServicesModule,
    PartsModule,
    UsersModule,
    FinanceModule,
    RoutesModule,
    RouteOptimizationModule,
    AppointmentsModule,
    TechniciansModule,
    ReportsModule,
    CommunicationsModule,
    SettingsModule,
  ],
})
export class AppModule {}
