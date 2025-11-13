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

  // Otomatik sipariş önerileri
  async getReorderSuggestions(): Promise<any[]> {
    // Minimum stok seviyesinin altındaki veya reorder level'ının altındaki parçalar
    const parts = await this.partsRepository
      .createQueryBuilder('part')
      .where('part.isActive = true')
      .andWhere(
        '(part.stockQuantity <= part.minStockLevel OR part.stockQuantity <= part.reorderLevel)',
      )
      .orderBy('part.stockQuantity', 'ASC')
      .getMany();

    const suggestions = await Promise.all(
      parts.map(async (part) => {
        // Son 30 günün kullanım verilerini al
        const thirtyDaysAgo = new Date();
        thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

        const movements = await this.stockMovementsRepository.find({
          where: {
            partId: part.id,
            movementType: 'out',
            movementDate: Between(thirtyDaysAgo, new Date()),
          },
        });

        const totalUsed = movements.reduce((acc, m) => acc + m.quantity, 0);
        const avgMonthlyUsage = totalUsed;

        // Tahmini tükenme süresi (gün)
        const daysUntilEmpty =
          avgMonthlyUsage > 0 ? (part.stockQuantity / avgMonthlyUsage) * 30 : 999;

        // Önerilen sipariş miktarı:
        // Max stok seviyesine ulaşacak şekilde + 1 aylık ekstra
        const suggestedOrderQty = Math.max(
          part.maxStockLevel - part.stockQuantity + avgMonthlyUsage,
          part.minStockLevel,
        );

        // Aciliyet seviyesi
        let urgency: 'critical' | 'high' | 'medium' | 'low' = 'low';
        if (part.stockQuantity <= part.minStockLevel) {
          urgency = 'critical';
        } else if (daysUntilEmpty <= 7) {
          urgency = 'high';
        } else if (daysUntilEmpty <= 14) {
          urgency = 'medium';
        }

        return {
          partId: part.id,
          partCode: part.partCode,
          partName: part.partName,
          category: part.category,
          supplier: part.supplier,
          currentStock: part.stockQuantity,
          minStockLevel: part.minStockLevel,
          reorderLevel: part.reorderLevel,
          maxStockLevel: part.maxStockLevel,
          avgMonthlyUsage,
          daysUntilEmpty: Math.round(daysUntilEmpty),
          suggestedOrderQty: Math.ceil(suggestedOrderQty),
          estimatedCost: Math.ceil(suggestedOrderQty) * Number(part.unitPrice),
          urgency,
        };
      }),
    );

    // Aciliyete göre sırala
    const urgencyOrder = { critical: 0, high: 1, medium: 2, low: 3 };
    return suggestions.sort(
      (a, b) => urgencyOrder[a.urgency] - urgencyOrder[b.urgency],
    );
  }

  // Stok uyarılarını al
  async getStockAlerts(): Promise<any> {
    const critical = await this.getCriticalStock();
    const low = await this.getLowStock();
    const suggestions = await this.getReorderSuggestions();

    return {
      summary: {
        criticalCount: critical.length,
        lowStockCount: low.length,
        reorderSuggestionsCount: suggestions.length,
        totalAlerts: critical.length + low.length,
      },
      criticalParts: critical.map((p) => ({
        id: p.id,
        partCode: p.partCode,
        partName: p.partName,
        currentStock: p.stockQuantity,
        minStockLevel: p.minStockLevel,
        category: p.category,
      })),
      lowStockParts: low.map((p) => ({
        id: p.id,
        partCode: p.partCode,
        partName: p.partName,
        currentStock: p.stockQuantity,
        reorderLevel: p.reorderLevel,
        category: p.category,
      })),
      reorderSuggestions: suggestions.slice(0, 10), // İlk 10 öneri
    };
  }
}
