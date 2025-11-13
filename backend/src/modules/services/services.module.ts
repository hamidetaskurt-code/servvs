import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ServicesController } from './services.controller';
import { ServicesService } from './services.service';
import { Service } from './entities/service.entity';
import { ServicePart } from './entities/service-part.entity';
import { ServiceTask } from './entities/service-task.entity';
import { ServicePhoto } from './entities/service-photo.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Service,
      ServicePart,
      ServiceTask,
      ServicePhoto,
    ]),
  ],
  controllers: [ServicesController],
  providers: [ServicesService],
  exports: [ServicesService],
})
export class ServicesModule {}
