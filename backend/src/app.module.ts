import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { DashboardModule } from './modules/dashboard/dashboard.module';
import { CustomersModule } from './modules/customers/customers.module';
import { ServicesModule } from './modules/services/services.module';
import { PartsModule } from './modules/parts/parts.module';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './modules/auth/auth.module';
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
      envFilePath: '.env',
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        host: configService.get('DB_HOST'),
        port: parseInt(configService.get('DB_PORT') || '5432'),
        username: configService.get('DB_USER'),
        password: String(configService.get('DB_PASSWORD') || ''),
        database: configService.get('DB_NAME'),
        entities: [__dirname + '/**/*.entity{.ts,.js}'],
        synchronize: false,
        logging: false,
      }),
      inject: [ConfigService],
    }),
    DashboardModule,
    CustomersModule,
    ServicesModule,
    PartsModule,
    UsersModule,
    AuthModule,
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
