import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Like, Between, In } from 'typeorm';
import { Customer } from './entities/customer.entity';
import { Device } from './entities/device.entity';
import { Document } from './entities/document.entity';
import { Communication } from './entities/communication.entity';
import { CreateCustomerDto } from './dto/create-customer.dto';
import { UpdateCustomerDto } from './dto/update-customer.dto';
import { CreateDeviceDto } from './dto/create-device.dto';

@Injectable()
export class CustomersService {
  constructor(
    @InjectRepository(Customer)
    private customersRepository: Repository<Customer>,
    @InjectRepository(Device)
    private devicesRepository: Repository<Device>,
    @InjectRepository(Document)
    private documentsRepository: Repository<Document>,
    @InjectRepository(Communication)
    private communicationsRepository: Repository<Communication>,
  ) {}

  // Müşteri CRUD işlemleri
  async create(createCustomerDto: CreateCustomerDto): Promise<Customer> {
    const customer = this.customersRepository.create(createCustomerDto);
    return await this.customersRepository.save(customer);
  }

  async findAll(filters?: any): Promise<Customer[]> {
    const where: any = {};

    if (filters?.customerType) {
      where.customerType = filters.customerType;
    }

    if (filters?.city) {
      where.city = filters.city;
    }

    if (filters?.tags) {
      // Tag filtreleme - array içinde arama
      where.tags = filters.tags;
    }

    if (filters?.search) {
      // Fuzzy search
      return await this.customersRepository
        .createQueryBuilder('customer')
        .where('customer.firstName ILIKE :search', {
          search: `%${filters.search}%`,
        })
        .orWhere('customer.lastName ILIKE :search', {
          search: `%${filters.search}%`,
        })
        .orWhere('customer.phone LIKE :search', { search: `%${filters.search}%` })
        .orWhere('customer.email ILIKE :search', {
          search: `%${filters.search}%`,
        })
        .orWhere('customer.companyName ILIKE :search', {
          search: `%${filters.search}%`,
        })
        .getMany();
    }

    return await this.customersRepository.find({
      where,
      relations: ['devices', 'services'],
      order: { createdAt: 'DESC' },
    });
  }

  async findOne(id: string): Promise<Customer> {
    const customer = await this.customersRepository.findOne({
      where: { id },
      relations: ['devices', 'services', 'invoices', 'documents', 'communications'],
    });

    if (!customer) {
      throw new NotFoundException(`Customer with ID ${id} not found`);
    }

    return customer;
  }

  async update(id: string, updateCustomerDto: UpdateCustomerDto): Promise<Customer> {
    const customer = await this.findOne(id);
    Object.assign(customer, updateCustomerDto);
    return await this.customersRepository.save(customer);
  }

  async remove(id: string): Promise<void> {
    const customer = await this.findOne(id);
    await this.customersRepository.softDelete(id);
  }

  // Cihaz işlemleri
  async addDevice(customerId: string, createDeviceDto: CreateDeviceDto): Promise<Device> {
    const customer = await this.findOne(customerId);
    const device = this.devicesRepository.create({
      ...createDeviceDto,
      customerId,
    });
    return await this.devicesRepository.save(device);
  }

  async findDevicesByCustomer(customerId: string): Promise<Device[]> {
    return await this.devicesRepository.find({
      where: { customerId },
      relations: ['services'],
      order: { installationDate: 'DESC' },
    });
  }

  // İstatistikler
  async getCustomerStats(customerId: string): Promise<any> {
    const customer = await this.findOne(customerId);
    const devices = await this.findDevicesByCustomer(customerId);

    return {
      totalServices: customer.totalServices,
      totalSpent: customer.totalSpent,
      satisfactionScore: customer.satisfactionScore,
      lastServiceDate: customer.lastServiceDate,
      devicesCount: devices.length,
      activeDevices: devices.filter((d) => d.isActive).length,
    };
  }

  // Müşteri segmentasyonu (RFM analizi)
  async segmentCustomers(): Promise<any> {
    // Recency, Frequency, Monetary analizi
    const customers = await this.customersRepository
      .createQueryBuilder('customer')
      .select([
        'customer.id',
        'customer.firstName',
        'customer.lastName',
        'customer.totalServices',
        'customer.totalSpent',
        'customer.lastServiceDate',
      ])
      .getMany();

    const now = new Date();
    const segments = {
      vip: [],
      loyal: [],
      potential: [],
      atRisk: [],
      inactive: [],
    };

    for (const customer of customers) {
      const daysSinceLastService = customer.lastServiceDate
        ? Math.floor(
            (now.getTime() - new Date(customer.lastServiceDate).getTime()) /
              (1000 * 60 * 60 * 24),
          )
        : 9999;

      if (customer.totalSpent > 10000 && customer.totalServices >= 10) {
        segments.vip.push(customer);
      } else if (customer.totalServices >= 5 && daysSinceLastService < 180) {
        segments.loyal.push(customer);
      } else if (customer.totalServices < 3 && daysSinceLastService < 60) {
        segments.potential.push(customer);
      } else if (daysSinceLastService > 180 && daysSinceLastService < 365) {
        segments.atRisk.push(customer);
      } else if (daysSinceLastService >= 365) {
        segments.inactive.push(customer);
      }
    }

    return segments;
  }

  // İletişim geçmişi ekleme
  async addCommunication(customerId: string, communicationData: any): Promise<Communication> {
    const customer = await this.findOne(customerId);
    const communication = this.communicationsRepository.create({
      ...communicationData,
      customerId,
    });
    return (await this.communicationsRepository.save(communication)) as unknown as Communication;
  }

  // Müşteri memnuniyeti güncelleme
  async updateSatisfactionScore(customerId: string, score: number): Promise<Customer> {
    const customer = await this.findOne(customerId);
    customer.satisfactionScore = score;
    return await this.customersRepository.save(customer);
  }
}
