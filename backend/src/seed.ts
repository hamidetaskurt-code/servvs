import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { UsersService } from './modules/users/users.service';
import { UserRole } from './common/enums/user-role.enum';

async function bootstrap() {
  const app = await NestFactory.createApplicationContext(AppModule);
  const usersService = app.get(UsersService);

  try {
    console.log('🌱 Seeding database...');

    // Create admin user
    const adminExists = await usersService.findByEmail('admin@akinkombi.com');
    if (!adminExists) {
      const admin = await usersService.create({
        firstName: 'Admin',
        lastName: 'User',
        email: 'admin@akinkombi.com',
        phone: '05001234567',
        password: 'Admin123!',
        role: UserRole.ADMIN,
        isActive: true,
      });
      console.log('✅ Admin user created:', admin.email);
    } else {
      console.log('ℹ️  Admin user already exists');
    }

    // Create manager user
    const managerExists = await usersService.findByEmail('manager@akinkombi.com');
    if (!managerExists) {
      const manager = await usersService.create({
        firstName: 'Mehmet',
        lastName: 'Yönetici',
        email: 'manager@akinkombi.com',
        phone: '05001234568',
        password: 'Manager123!',
        role: UserRole.MANAGER,
        isActive: true,
      });
      console.log('✅ Manager user created:', manager.email);
    } else {
      console.log('ℹ️  Manager user already exists');
    }

    // Create technician user
    const technicianExists = await usersService.findByEmail('technician@akinkombi.com');
    if (!technicianExists) {
      const technician = await usersService.create({
        firstName: 'Ali',
        lastName: 'Teknisyen',
        email: 'technician@akinkombi.com',
        phone: '05001234569',
        password: 'Technician123!',
        role: UserRole.TECHNICIAN,
        isActive: true,
      });
      console.log('✅ Technician user created:', technician.email);
    } else {
      console.log('ℹ️  Technician user already exists');
    }

    console.log('\n✅ Seeding completed!');
    console.log('\n📋 Test Users:');
    console.log('-----------------------------------');
    console.log('Admin:      admin@akinkombi.com / Admin123!');
    console.log('Manager:    manager@akinkombi.com / Manager123!');
    console.log('Technician: technician@akinkombi.com / Technician123!');
    console.log('-----------------------------------\n');

  } catch (error) {
    console.error('❌ Seeding failed:', error.message);
  } finally {
    await app.close();
  }
}

bootstrap();
