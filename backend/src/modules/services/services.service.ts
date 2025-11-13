import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Between, Like } from 'typeorm';
import { Service } from './entities/service.entity';
import { ServicePart } from './entities/service-part.entity';
import { ServiceTask } from './entities/service-task.entity';
import { ServicePhoto } from './entities/service-photo.entity';
import { CreateServiceDto } from './dto/create-service.dto';
import { UpdateServiceDto } from './dto/update-service.dto';
import { ServiceStatus } from '../../common/enums/service-status.enum';

@Injectable()
export class ServicesService {
  constructor(
    @InjectRepository(Service)
    private servicesRepository: Repository<Service>,
    @InjectRepository(ServicePart)
    private servicePartsRepository: Repository<ServicePart>,
    @InjectRepository(ServiceTask)
    private serviceTasksRepository: Repository<ServiceTask>,
    @InjectRepository(ServicePhoto)
    private servicePhotosRepository: Repository<ServicePhoto>,
  ) {}

  // Servis numarası oluştur
  private async generateServiceNumber(): Promise<string> {
    const year = new Date().getFullYear();
    const count = await this.servicesRepository.count({
      where: {
        serviceNumber: Like(`S-${year}-%`),
      },
    });
    return `S-${year}-${String(count + 1).padStart(4, '0')}`;
  }

  // Servis CRUD işlemleri
  async create(createServiceDto: CreateServiceDto): Promise<Service> {
    const serviceNumber = await this.generateServiceNumber();
    const service = this.servicesRepository.create({
      ...createServiceDto,
      serviceNumber,
    });
    return await this.servicesRepository.save(service);
  }

  async findAll(filters?: any): Promise<Service[]> {
    const where: any = {};

    if (filters?.status) {
      where.status = filters.status;
    }

    if (filters?.serviceType) {
      where.serviceType = filters.serviceType;
    }

    if (filters?.priority) {
      where.priority = filters.priority;
    }

    if (filters?.technicianId) {
      where.technicianId = filters.technicianId;
    }

    if (filters?.customerId) {
      where.customerId = filters.customerId;
    }

    if (filters?.dateFrom && filters?.dateTo) {
      where.scheduledDate = Between(
        new Date(filters.dateFrom),
        new Date(filters.dateTo),
      );
    }

    return await this.servicesRepository.find({
      where,
      relations: [
        'customer',
        'device',
        'assignedTechnician',
        'serviceParts',
        'serviceTasks',
        'servicePhotos',
      ],
      order: { scheduledDate: 'DESC' },
    });
  }

  async findOne(id: string): Promise<Service> {
    const service = await this.servicesRepository.findOne({
      where: { id },
      relations: [
        'customer',
        'device',
        'assignedTechnician',
        'serviceParts',
        'serviceParts.part',
        'serviceTasks',
        'servicePhotos',
      ],
    });

    if (!service) {
      throw new NotFoundException(`Service with ID ${id} not found`);
    }

    return service;
  }

  async update(
    id: string,
    updateServiceDto: UpdateServiceDto,
  ): Promise<Service> {
    const service = await this.findOne(id);
    Object.assign(service, updateServiceDto);

    // Gerçek süreyi hesapla
    if (service.startedAt && service.completedAt) {
      const duration = Math.ceil(
        (new Date(service.completedAt).getTime() -
          new Date(service.startedAt).getTime()) /
          (1000 * 60),
      );
      service.actualDuration = duration;
    }

    // Toplam maliyeti hesapla
    service.totalCost = service.laborCost + service.partsCost;

    return await this.servicesRepository.save(service);
  }

  async remove(id: string): Promise<void> {
    const service = await this.findOne(id);
    await this.servicesRepository.softDelete(id);
  }

  // Durum değiştirme
  async updateStatus(id: string, status: ServiceStatus): Promise<Service> {
    const service = await this.findOne(id);
    service.status = status;

    if (status === ServiceStatus.IN_PROGRESS && !service.startedAt) {
      service.startedAt = new Date();
    }

    if (status === ServiceStatus.COMPLETED) {
      service.completedAt = new Date();
      // Gerçek süreyi hesapla
      if (service.startedAt) {
        service.actualDuration = Math.ceil(
          (service.completedAt.getTime() - service.startedAt.getTime()) /
            (1000 * 60),
        );
      }
    }

    return await this.servicesRepository.save(service);
  }

  // Teknisyen atama
  async assignTechnician(id: string, technicianId: string): Promise<Service> {
    const service = await this.findOne(id);
    service.technicianId = technicianId;
    return await this.servicesRepository.save(service);
  }

  // Parça ekleme
  async addPart(
    serviceId: string,
    partId: string,
    quantity: number,
    unitPrice: number,
  ): Promise<ServicePart> {
    const service = await this.findOne(serviceId);
    const totalPrice = quantity * unitPrice;

    const servicePart = this.servicePartsRepository.create({
      serviceId,
      partId,
      quantity,
      unitPrice,
      totalPrice,
    });

    const savedPart = await this.servicePartsRepository.save(servicePart);

    // Servis parça maliyetini güncelle
    service.partsCost += totalPrice;
    service.totalCost = service.laborCost + service.partsCost;
    await this.servicesRepository.save(service);

    return savedPart;
  }

  // Görev ekleme
  async addTask(
    serviceId: string,
    taskData: any,
  ): Promise<ServiceTask> {
    const service = await this.findOne(serviceId);
    const task = this.serviceTasksRepository.create({
      ...taskData,
      serviceId,
    });
    return (await this.serviceTasksRepository.save(task)) as unknown as ServiceTask;
  }

  // Görev tamamlama
  async completeTask(taskId: string): Promise<ServiceTask> {
    const task = await this.serviceTasksRepository.findOne({
      where: { id: taskId },
    });

    if (!task) {
      throw new NotFoundException(`Task with ID ${taskId} not found`);
    }

    task.isCompleted = true;
    task.completedAt = new Date();

    return await this.serviceTasksRepository.save(task);
  }

  // Fotoğraf ekleme
  async addPhoto(
    serviceId: string,
    photoData: any,
  ): Promise<ServicePhoto> {
    const service = await this.findOne(serviceId);
    const photo = this.servicePhotosRepository.create({
      ...photoData,
      serviceId,
    });
    return (await this.servicePhotosRepository.save(photo)) as unknown as ServicePhoto;
  }

  // Kanban board verisi
  async getKanbanData(): Promise<any> {
    const pending = await this.servicesRepository.count({
      where: { status: ServiceStatus.PENDING },
    });
    const planned = await this.servicesRepository.count({
      where: { status: ServiceStatus.PLANNED },
    });
    const inProgress = await this.servicesRepository.count({
      where: { status: ServiceStatus.IN_PROGRESS },
    });
    const completed = await this.servicesRepository.count({
      where: { status: ServiceStatus.COMPLETED },
    });
    const cancelled = await this.servicesRepository.count({
      where: { status: ServiceStatus.CANCELLED },
    });

    const services = await this.servicesRepository.find({
      relations: ['customer', 'assignedTechnician'],
      order: { scheduledDate: 'ASC' },
    });

    return {
      counts: {
        pending,
        planned,
        inProgress,
        completed,
        cancelled,
      },
      services: {
        pending: services.filter((s) => s.status === ServiceStatus.PENDING),
        planned: services.filter((s) => s.status === ServiceStatus.PLANNED),
        inProgress: services.filter(
          (s) => s.status === ServiceStatus.IN_PROGRESS,
        ),
        completed: services.filter((s) => s.status === ServiceStatus.COMPLETED),
        cancelled: services.filter((s) => s.status === ServiceStatus.CANCELLED),
      },
    };
  }

  // İstatistikler
  async getStats(startDate?: Date, endDate?: Date): Promise<any> {
    const where: any = {};

    if (startDate && endDate) {
      where.scheduledDate = Between(startDate, endDate);
    }

    const total = await this.servicesRepository.count({ where });
    const completed = await this.servicesRepository.count({
      where: { ...where, status: ServiceStatus.COMPLETED },
    });
    const cancelled = await this.servicesRepository.count({
      where: { ...where, status: ServiceStatus.CANCELLED },
    });
    const inProgress = await this.servicesRepository.count({
      where: { ...where, status: ServiceStatus.IN_PROGRESS },
    });

    // Ortalama tamamlanma süresi
    const completedServices = await this.servicesRepository.find({
      where: {
        ...where,
        status: ServiceStatus.COMPLETED,
      },
      select: ['actualDuration'],
    });

    const avgDuration =
      completedServices.length > 0
        ? completedServices.reduce((acc, s) => acc + (s.actualDuration || 0), 0) /
          completedServices.length
        : 0;

    // Toplam gelir
    const services = await this.servicesRepository.find({
      where: { ...where, status: ServiceStatus.COMPLETED },
      select: ['totalCost'],
    });

    const totalRevenue = services.reduce((acc, s) => acc + Number(s.totalCost), 0);

    return {
      total,
      completed,
      cancelled,
      inProgress,
      avgDuration: Math.round(avgDuration),
      totalRevenue,
      completionRate: total > 0 ? ((completed / total) * 100).toFixed(2) : 0,
    };
  }
}
