import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, LessThanOrEqual, Between } from 'typeorm';
import { Part } from './entities/part.entity';
import { StockMovement } from './entities/stock-movement.entity';
import { CreatePartDto } from './dto/create-part.dto';
import { UpdatePartDto } from './dto/update-part.dto';

@Injectable()
export class PartsService {
  constructor(
    @InjectRepository(Part)
    private partsRepository: Repository<Part>,
    @InjectRepository(StockMovement)
    private stockMovementsRepository: Repository<StockMovement>,
  ) {}

  async create(createPartDto: CreatePartDto): Promise<Part> {
    const part = this.partsRepository.create(createPartDto);
    return await this.partsRepository.save(part);
  }

  async findAll(filters?: any): Promise<Part[]> {
    const where: any = {};

    if (filters?.category) {
      where.category = filters.category;
    }

    if (filters?.supplier) {
      where.supplier = filters.supplier;
    }

    if (filters?.isActive !== undefined) {
      where.isActive = filters.isActive;
    }

    if (filters?.search) {
      return await this.partsRepository
        .createQueryBuilder('part')
        .where('part.partName ILIKE :search', {
          search: `%${filters.search}%`,
        })
        .orWhere('part.partCode ILIKE :search', {
          search: `%${filters.search}%`,
        })
        .orWhere('part.barcode LIKE :search', { search: `%${filters.search}%` })
        .getMany();
    }

    return await this.partsRepository.find({
      where,
      order: { partName: 'ASC' },
    });
  }

  async findOne(id: string): Promise<Part> {
    const part = await this.partsRepository.findOne({
      where: { id },
      relations: ['stockMovements'],
    });

    if (!part) {
      throw new NotFoundException(`Part with ID ${id} not found`);
    }

    return part;
  }

  async findByBarcode(barcode: string): Promise<Part> {
    const part = await this.partsRepository.findOne({ where: { barcode } });

    if (!part) {
      throw new NotFoundException(`Part with barcode ${barcode} not found`);
    }

    return part;
  }

  async update(id: string, updatePartDto: UpdatePartDto): Promise<Part> {
    const part = await this.findOne(id);
    Object.assign(part, updatePartDto);
    return await this.partsRepository.save(part);
  }

  async remove(id: string): Promise<void> {
    const part = await this.findOne(id);
    await this.partsRepository.softDelete(id);
  }

  // Stok hareketleri
  async addStock(
    partId: string,
    quantity: number,
    reference?: string,
    referenceType?: string,
    userId?: string,
  ): Promise<StockMovement> {
    const part = await this.findOne(partId);
    const previousStock = part.stockQuantity;
    const newStock = previousStock + quantity;

    const movement = this.stockMovementsRepository.create({
      partId,
      movementType: 'in',
      quantity,
      previousStock,
      newStock,
      reference,
      referenceType,
      performedById: userId,
      movementDate: new Date(),
    });

    await this.stockMovementsRepository.save(movement);

    // Parça stoğunu güncelle
    part.stockQuantity = newStock;
    part.lastRestockedDate = new Date();
    await this.partsRepository.save(part);

    return movement;
  }

  async removeStock(
    partId: string,
    quantity: number,
    reference?: string,
    referenceType?: string,
    userId?: string,
  ): Promise<StockMovement> {
    const part = await this.findOne(partId);
    const previousStock = part.stockQuantity;
    const newStock = Math.max(0, previousStock - quantity);

    const movement = this.stockMovementsRepository.create({
      partId,
      movementType: 'out',
      quantity,
      previousStock,
      newStock,
      reference,
      referenceType,
      performedById: userId,
      movementDate: new Date(),
    });

    await this.stockMovementsRepository.save(movement);

    // Parça stoğunu güncelle
    part.stockQuantity = newStock;
    part.totalUsed += quantity;
    part.lastUsedDate = new Date();
    await this.partsRepository.save(part);

    return movement;
  }

  async adjustStock(
    partId: string,
    newQuantity: number,
    reason: string,
    userId?: string,
  ): Promise<StockMovement> {
    const part = await this.findOne(partId);
    const previousStock = part.stockQuantity;
    const difference = newQuantity - previousStock;

    const movement = this.stockMovementsRepository.create({
      partId,
      movementType: 'adjustment',
      quantity: Math.abs(difference),
      previousStock,
      newStock: newQuantity,
      notes: reason,
      performedById: userId,
      movementDate: new Date(),
    });

    await this.stockMovementsRepository.save(movement);

    // Parça stoğunu güncelle
    part.stockQuantity = newQuantity;
    await this.partsRepository.save(part);

    return movement;
  }

  // Kritik stoklar
  async getCriticalStock(): Promise<Part[]> {
    return await this.partsRepository
      .createQueryBuilder('part')
      .where('part.stockQuantity <= part.minStockLevel')
      .andWhere('part.isActive = true')
      .orderBy('part.stockQuantity', 'ASC')
      .getMany();
  }

  // Düşük stoklar
  async getLowStock(): Promise<Part[]> {
    return await this.partsRepository
      .createQueryBuilder('part')
      .where('part.stockQuantity <= part.reorderLevel')
      .andWhere('part.isActive = true')
      .orderBy('part.stockQuantity', 'ASC')
      .getMany();
  }

  // Stok raporu
  async getStockReport(): Promise<any> {
    const allParts = await this.partsRepository.find({
      where: { isActive: true },
    });

    const critical = allParts.filter(
      (p) => p.stockQuantity <= p.minStockLevel,
    );
    const low = allParts.filter(
      (p) =>
        p.stockQuantity > p.minStockLevel &&
        p.stockQuantity <= p.reorderLevel,
    );
    const normal = allParts.filter(
      (p) =>
        p.stockQuantity > p.reorderLevel &&
        p.stockQuantity < p.maxStockLevel,
    );
    const overstock = allParts.filter(
      (p) => p.stockQuantity >= p.maxStockLevel,
    );

    const totalValue = allParts.reduce(
      (acc, p) => acc + Number(p.unitPrice) * p.stockQuantity,
      0,
    );

    return {
      total: allParts.length,
      critical: critical.length,
      low: low.length,
      normal: normal.length,
      overstock: overstock.length,
      totalValue,
      criticalParts: critical,
      lowStockParts: low,
    };
  }

  // En çok kullanılan parçalar
  async getMostUsedParts(limit: number = 10): Promise<Part[]> {
    return await this.partsRepository.find({
      where: { isActive: true },
      order: { totalUsed: 'DESC' },
      take: limit,
    });
  }

  // Aylık ortalama hesaplama (AI için)
  async updateMonthlyAverages(): Promise<void> {
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

    const parts = await this.partsRepository.find({
      where: { isActive: true },
    });

    for (const part of parts) {
      const movements = await this.stockMovementsRepository.find({
        where: {
          partId: part.id,
          movementType: 'out',
          movementDate: Between(thirtyDaysAgo, new Date()),
        },
      });

      const totalUsed = movements.reduce((acc, m) => acc + m.quantity, 0);
      part.monthlyAverage = totalUsed;
      await this.partsRepository.save(part);
    }
  }
}
