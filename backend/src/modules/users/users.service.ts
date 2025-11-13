import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './entities/user.entity';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { UserRole } from '../../common/enums/user-role.enum';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) {}

  async create(createUserDto: CreateUserDto): Promise<User> {
    // Email ve telefon kontrolü
    const existingUser = await this.usersRepository.findOne({
      where: [
        { email: createUserDto.email },
        { phone: createUserDto.phone },
      ],
    });

    if (existingUser) {
      throw new ConflictException('User with this email or phone already exists');
    }

    // Şifreyi hashle
    const hashedPassword = await bcrypt.hash(createUserDto.password, 10);

    const user = this.usersRepository.create({
      ...createUserDto,
      password: hashedPassword,
    });

    return await this.usersRepository.save(user);
  }

  async findAll(filters?: any): Promise<User[]> {
    const where: any = {};

    if (filters?.role) {
      where.role = filters.role;
    }

    if (filters?.isActive !== undefined) {
      where.isActive = filters.isActive;
    }

    return await this.usersRepository.find({
      where,
      order: { createdAt: 'DESC' },
      select: [
        'id',
        'firstName',
        'lastName',
        'email',
        'phone',
        'role',
        'isActive',
        'profilePicture',
        'city',
        'district',
        'lastLoginAt',
      ],
    });
  }

  async findOne(id: string): Promise<User> {
    const user = await this.usersRepository.findOne({
      where: { id },
      relations: ['assignedServices'],
      select: [
        'id',
        'firstName',
        'lastName',
        'email',
        'phone',
        'role',
        'isActive',
        'profilePicture',
        'address',
        'city',
        'district',
        'twoFactorEnabled',
        'lastLoginAt',
        'createdAt',
      ],
    });

    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    return user;
  }

  async findByEmail(email: string): Promise<User | null> {
    return await this.usersRepository.findOne({ where: { email } });
  }

  async findByPhone(phone: string): Promise<User | null> {
    return await this.usersRepository.findOne({ where: { phone } });
  }

  async update(id: string, updateUserDto: UpdateUserDto): Promise<User> {
    const user = await this.findOne(id);

    // Şifre güncelleniyorsa hashle
    if (updateUserDto.password) {
      updateUserDto.password = await bcrypt.hash(updateUserDto.password, 10);
    }

    Object.assign(user, updateUserDto);
    return await this.usersRepository.save(user);
  }

  async remove(id: string): Promise<void> {
    const user = await this.findOne(id);
    await this.usersRepository.softDelete(id);
  }

  // Teknisyenler (UserRole.TECHNICIAN)
  async findTechnicians(): Promise<User[]> {
    return await this.usersRepository.find({
      where: { role: UserRole.TECHNICIAN, isActive: true },
      select: [
        'id',
        'firstName',
        'lastName',
        'phone',
        'email',
        'profilePicture',
      ],
    });
  }

  // Teknisyen performans
  async getTechnicianPerformance(technicianId: string, startDate?: Date, endDate?: Date): Promise<any> {
    const user = await this.findOne(technicianId);

    const query = this.usersRepository
      .createQueryBuilder('user')
      .leftJoinAndSelect('user.assignedServices', 'service')
      .where('user.id = :technicianId', { technicianId })
      .andWhere('service.status = :status', { status: 'completed' });

    if (startDate && endDate) {
      query.andWhere('service.completedAt BETWEEN :startDate AND :endDate', {
        startDate,
        endDate,
      });
    }

    const result = await query.getOne();

    const completedServices = result?.assignedServices || [];
    const totalServices = completedServices.length;

    // Ortalama tamamlama süresi
    const avgDuration =
      totalServices > 0
        ? completedServices.reduce(
            (acc, s) => acc + (s.actualDuration || 0),
            0,
          ) / totalServices
        : 0;

    // Ortalama müşteri puanı
    const ratedServices = completedServices.filter((s) => s.customerRating);
    const avgRating =
      ratedServices.length > 0
        ? ratedServices.reduce((acc, s) => acc + (s.customerRating || 0), 0) /
          ratedServices.length
        : 0;

    // Toplam gelir katkısı
    const totalRevenue = completedServices.reduce(
      (acc, s) => acc + Number(s.totalCost),
      0,
    );

    return {
      technician: {
        id: user.id,
        name: user.fullName,
        role: user.role,
      },
      performance: {
        totalServices,
        avgDuration: Math.round(avgDuration),
        avgRating: Number(avgRating.toFixed(2)),
        totalRevenue,
        completionRate: '100%', // Sadece completed servisleri çektik
      },
    };
  }

  // Aktif teknisyenler (bugün servisi olanlar)
  async getActiveTechnicians(): Promise<any[]> {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    const technicians = await this.usersRepository
      .createQueryBuilder('user')
      .leftJoinAndSelect('user.assignedServices', 'service')
      .where('user.role = :role', { role: 'technician' })
      .andWhere('user.isActive = true')
      .andWhere('service.scheduledDate >= :today', { today })
      .andWhere('service.scheduledDate < :tomorrow', { tomorrow })
      .getMany();

    return technicians.map((tech) => ({
      id: tech.id,
      name: tech.fullName,
      phone: tech.phone,
      todayServices: tech.assignedServices.length,
      status: tech.assignedServices.some((s) => s.status === 'in_progress')
        ? 'in_field'
        : 'available',
    }));
  }

  // Son giriş zamanı güncelle
  async updateLastLogin(id: string): Promise<void> {
    await this.usersRepository.update(id, { lastLoginAt: new Date() });
  }

  // 2FA etkinleştir/devre dışı bırak
  async toggle2FA(id: string, enabled: boolean): Promise<User> {
    const user = await this.findOne(id);
    user.twoFactorEnabled = enabled;
    return await this.usersRepository.save(user);
  }
}
