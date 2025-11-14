import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  // Geçici test kullanıcıları (veritabanı sorunları nedeniyle)
  private testUsers = [
    {
      id: '1',
      email: 'admin@test.com',
      password: 'admin123',
      firstName: 'Admin',
      lastName: 'Kullanıcı',
      role: 'admin',
    },
    {
      id: '2',
      email: 'teknisyen@test.com',
      password: 'tekni123',
      firstName: 'Ahmet',
      lastName: 'Teknisyen',
      role: 'technician',
    },
    {
      id: '3',
      email: 'ofis@test.com',
      password: 'ofis123',
      firstName: 'Ayşe',
      lastName: 'Ofis',
      role: 'customer_service',
    },
  ];

  constructor(
    private jwtService: JwtService,
  ) {}

  async login(email: string, password: string) {
    // Veritabanı sorunları nedeniyle test kullanıcılarla giriş yap
    const testUser = this.testUsers.find(
      (u) => u.email === email && u.password === password,
    );

    if (!testUser) {
      throw new UnauthorizedException('Email veya şifre yanlış');
    }

    // JWT token oluştur
    const token = this.jwtService.sign({
      sub: testUser.id,
      email: testUser.email,
      role: testUser.role,
    });

    return {
      access_token: token,
      user: {
        id: testUser.id,
        firstName: testUser.firstName,
        lastName: testUser.lastName,
        email: testUser.email,
        role: testUser.role,
        fullName: `${testUser.firstName} ${testUser.lastName}`,
      },
    };
  }

  async validateUser(id: string) {
    const user = this.testUsers.find((u) => u.id === id);
    if (!user) {
      throw new UnauthorizedException('Kullanıcı bulunamadı');
    }
    return user;
  }

  getTestUsers() {
    return this.testUsers;
  }
}
