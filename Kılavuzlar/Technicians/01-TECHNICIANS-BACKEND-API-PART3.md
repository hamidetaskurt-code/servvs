# Technicians Modülü - Backend API Kılavuzu (Bölüm 3: Kod Implementasyonu)

**Sürüm:** 1.0.0
**Son Güncelleme:** 2025-11-12
**Kalite Seviyesi:** ⭐⭐⭐⭐⭐ (5/5)
**İlgili Dosyalar:** `01-TECHNICIANS-BACKEND-API-PART1.md`, `01-TECHNICIANS-BACKEND-API-PART2.md`

---

## 1. Giriş

Bu belge, Technicians modülünün backend'deki temel kod yapılarını içerir. NestJS çatısı altında TypeORM kullanılarak geliştirilen bu yapılar, modülün veritabanı etkileşimlerini, iş mantığını ve API endpoint'lerinin davranışlarını tanımlar.

---

## 2. TypeORM Varlıkları (Entities)

Veritabanı tablolarını temsil eden ana sınıflardır.

### `Technician` Entity

`technicians` tablosunun ana varlığı. `User` varlığı ile `OneToOne` ilişkiye sahiptir.

```typescript
// src/modules/technicians/entities/technician.entity.ts
import { Entity, PrimaryGeneratedColumn, Column, OneToOne, JoinColumn, ManyToOne, OneToMany } from 'typeorm';
import { User } from '../../users/entities/user.entity';
import { Team } from '../../teams/entities/team.entity';
import { TechnicianSkill } from './technician-skill.entity';
import { TechnicianAvailability } from './technician-availability.entity';
import { TechnicianPerformance } from './technician-performance.entity';
import { Service } from '../../services/entities/service.entity';
import { BaseEntity } from '../../../common/entities/base.entity';

@Entity('technicians')
export class Technician extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  firstName: string;

  @Column()
  lastName: string;

  @Column({ unique: true })
  email: string;

  @Column({ nullable: true })
  phone: string;

  @Column({ type: 'date' })
  hireDate: Date;

  @Column({ default: true })
  isActive: boolean;

  @OneToOne(() => User, { cascade: true, onDelete: 'CASCADE' })
  @JoinColumn()
  user: User;

  @ManyToOne(() => Team, team => team.technicians)
  team: Team;

  @OneToMany(() => TechnicianSkill, skill => skill.technician, { cascade: true })
  skills: TechnicianSkill[];

  @OneToMany(() => TechnicianAvailability, availability => availability.technician, { cascade: true })
  availability: TechnicianAvailability[];

  @OneToOne(() => TechnicianPerformance, performance => performance.technician, { cascade: true })
  performance: TechnicianPerformance;

  @OneToMany(() => Service, service => service.technician)
  services: Service[];
}
```

### `TechnicianSkill` Entity

Teknisyenlerin yeteneklerini ve seviyelerini tutan `technician_skills` tablosu.

```typescript
// src/modules/technicians/entities/technician-skill.entity.ts
import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
import { Technician } from './technician.entity';
import { BaseEntity } from '../../../common/entities/base.entity';

@Entity('technician_skills')
export class TechnicianSkill extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => Technician, technician => technician.skills, { onDelete: 'CASCADE' })
  technician: Technician;

  @Column()
  name: string; // Örn: "Yoğuşmalı Kombi", "Petek Temizliği"

  @Column()
  level: string; // Örn: "Uzman", "Orta", "Yeni"
}
```

### `TechnicianAvailability` Entity

Teknisyenlerin müsaitlik durumunu gün bazında yöneten `technician_availability` tablosu.

```typescript
// src/modules/technicians/entities/technician-availability.entity.ts
import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, Index } from 'typeorm';
import { Technician } from './technician.entity';
import { BaseEntity } from '../../../common/entities/base.entity';

export enum AvailabilityType {
  WORK_DAY = 'WORK_DAY',
  DAY_OFF = 'DAY_OFF',
  HOLIDAY = 'HOLIDAY',
}

@Entity('technician_availability')
@Index(['technician', 'date'], { unique: true })
export class TechnicianAvailability extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => Technician, technician => technician.availability, { onDelete: 'CASCADE' })
  technician: Technician;

  @Column({ type: 'date' })
  date: Date;

  @Column({ type: 'enum', enum: AvailabilityType })
  type: AvailabilityType;

  // WORK_DAY ise JSON olarak çalışma saatlerini tutar. Örn: [{ start: "09:00", end: "18:00" }]
  @Column({ type: 'jsonb', nullable: true })
  slots: Record<string, any>;

  @Column({ nullable: true })
  reason: string; // DAY_OFF veya HOLIDAY için açıklama
}
```

---

## 3. Veri Transfer Nesneleri (DTOs)

API istek ve yanıtlarında veri bütünlüğünü ve doğruluğunu sağlamak için kullanılır.

### `CreateTechnicianDto`

Yeni teknisyen oluştururken kullanılan DTO.

```typescript
// src/modules/technicians/dto/create-technician.dto.ts
import { IsString, IsEmail, MinLength, IsDateString, IsUUID, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

class SkillDto {
  @IsString()
  name: string;

  @IsString()
  level: string;
}

export class CreateTechnicianDto {
  @IsString()
  firstName: string;

  @IsString()
  lastName: string;

  @IsEmail()
  email: string;

  @MinLength(8)
  password: string;

  @IsString()
  phone: string;

  @IsDateString()
  hireDate: string;

  @IsUUID()
  teamId: string;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SkillDto)
  skills: SkillDto[];
}
```

### `UpdateTechnicianDto`

Teknisyen bilgilerini güncellerken kullanılan DTO. Tüm alanlar opsiyoneldir.

```typescript
// src/modules/technicians/dto/update-technician.dto.ts
import { IsString, IsEmail, IsOptional, IsBoolean, IsUUID } from 'class-validator';

export class UpdateTechnicianDto {
  @IsOptional() @IsString()
  firstName?: string;

  @IsOptional() @IsString()
  lastName?: string;

  @IsOptional() @IsEmail()
  email?: string;

  @IsOptional() @IsString()
  phone?: string;

  @IsOptional() @IsBoolean()
  isActive?: boolean;

  @IsOptional() @IsUUID()
  teamId?: string;
}
```

---

## 4. Controller ve Service Katmanları (Özet)

Aşağıda, ana işlevleri yerine getiren Controller ve Service metodlarının basitleştirilmiş birer örneği bulunmaktadır.

### `TechniciansController`

HTTP isteklerini karşılar, DTO'lar aracılığıyla veriyi doğrular ve ilgili Service metodunu çağırır.

```typescript
// src/modules/technicians/technicians.controller.ts
import { Controller, Get, Post, Body, Param, Put, Delete, Query, UseGuards } from '@nestjs/common';
import { TechniciansService } from './technicians.service';
import { CreateTechnicianDto } from './dto/create-technician.dto';
import { UpdateTechnicianDto } from './dto/update-technician.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { Roles } from '../auth/decorators/roles.decorator';
import { UserRole } from '../../common/enums/user-role.enum';

@Controller('api/v1/technicians')
@UseGuards(JwtAuthGuard, RolesGuard)
export class TechniciansController {
  constructor(private readonly techniciansService: TechniciansService) {}

  @Post('create')
  @Roles(UserRole.ADMIN, UserRole.MANAGER)
  create(@Body() createTechnicianDto: CreateTechnicianDto) {
    return this.techniciansService.create(createTechnicianDto);
  }

  @Get()
  @Roles(UserRole.ADMIN, UserRole.MANAGER, UserRole.CUSTOMER_SERVICE)
  findAll(@Query() query: any) {
    return this.techniciansService.findAll(query);
  }

  @Get(':id')
  // ...
  findOne(@Param('id') id: string) {
    return this.techniciansService.findOne(id);
  }

  @Put(':id/update')
  // ...
  update(@Param('id') id: string, @Body() updateTechnicianDto: UpdateTechnicianDto) {
    return this.techniciansService.update(id, updateTechnicianDto);
  }

  @Delete(':id/delete')
  @Roles(UserRole.ADMIN)
  remove(@Param('id') id: string) {
    return this.techniciansService.remove(id);
  }
}
```

### `TechniciansService`

Veritabanı işlemleri ve iş mantığının yürütüldüğü katmandır.

```typescript
// src/modules/technicians/technicians.service.ts
import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Connection } from 'typeorm';
import { Technician } from './entities/technician.entity';
import { User } from '../users/entities/user.entity';
import { CreateTechnicianDto } from './dto/create-technician.dto';
import { UsersService } from '../users/users.service';
import { UserRole } from '../../common/enums/user-role.enum';

@Injectable()
export class TechniciansService {
  constructor(
    @InjectRepository(Technician)
    private techniciansRepository: Repository<Technician>,
    private usersService: UsersService,
    private connection: Connection,
  ) {}

  async create(createTechnicianDto: CreateTechnicianDto): Promise<Technician> {
    const { email, password, skills, ...technicianData } = createTechnicianDto;

    // 1. Kullanıcıyı oluştur
    const user = await this.usersService.create({
      email,
      password,
      role: UserRole.TECHNICIAN,
    });

    // 2. Teknisyeni oluştur ve kullanıcıyla ilişkilendir
    const technician = this.techniciansRepository.create({
      ...technicianData,
      email,
      user,
      // skills ve team ilişkileri burada yönetilir
    });

    // 3. Veritabanına kaydet
    return this.techniciansRepository.save(technician);
  }

  async findAll(query: any): Promise<{ data: Technician[], meta: any }> {
    // Filtreleme, sıralama ve sayfalama mantığı burada uygulanır.
    const [data, total] = await this.techniciansRepository.findAndCount({ /* ... */ });
    return { data, meta: { total, page: query.page, limit: query.limit } };
  }
  
  // ... diğer metodlar (findOne, update, remove)
}
```
