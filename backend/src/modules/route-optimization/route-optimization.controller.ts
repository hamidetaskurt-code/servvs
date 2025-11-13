import { Controller, Post, Body } from '@nestjs/common';
import { RouteOptimizationService } from './route-optimization.service';

// DTO for incoming optimization requests
class OptimizeRouteDto {
  technician: {
    startLat: number;
    startLon: number;
  };
  services: {
    id: number;
    lat: number;
    lon: number;
  }[];
}

@Controller('route-optimization')
export class RouteOptimizationController {
  constructor(private readonly optimizationService: RouteOptimizationService) {}

  @Post('optimize')
  optimizeRoute(@Body() optimizeRouteDto: OptimizeRouteDto) {
    return this.optimizationService.optimizeRoute(optimizeRouteDto);
  }
}