import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RoutesController } from './routes.controller';
import { RoutesService } from './routes.service';
import { Route } from './entities/route.entity';
import { RouteLeg } from './entities/route-leg.entity';
import { RouteOptimizationLog } from './entities/route-optimization-log.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([Route, RouteLeg, RouteOptimizationLog]),
  ],
  controllers: [RoutesController],
  providers: [RoutesService],
  exports: [RoutesService],
})
export class RoutesModule {}
