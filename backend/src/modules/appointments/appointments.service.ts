import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Between, LessThan, MoreThan } from 'typeorm';
import { Service } from '../services/entities/service.entity';
import { User } from '../users/entities/user.entity';
import { ServiceStatus } from '../../common/enums/service-status.enum';
import { CommunicationsService } from '../communications/communications.service';

@Injectable()
export class AppointmentsService {
  constructor(
    @InjectRepository(Service)
    private servicesRepository: Repository<Service>,
    @InjectRepository(User)
    private usersRepository: Repository<User>,
    private communicationsService: CommunicationsService,
  ) {}

  async getCalendarData(year: number, month: number) {
    const startDate = new Date(year, month - 1, 1);
    const endDate = new Date(year, month, 0, 23, 59, 59);

    const appointments = await this.servicesRepository.find({
      where: {
        scheduledDate: Between(startDate, endDate),
      },
      relations: ['customer', 'assignedTechnician', 'device'],
      order: { scheduledDate: 'ASC' },
    });

    // Günlere göre grupla
    const calendar = {};
    appointments.forEach((appointment) => {
      const day = appointment.scheduledDate.getDate();
      if (!calendar[day]) {
        calendar[day] = [];
      }
      calendar[day].push({
        id: appointment.id,
        serviceNumber: appointment.serviceNumber,
        customer: appointment.customer?.fullName,
        technician: appointment.assignedTechnician?.fullName,
        time: appointment.scheduledDate.toLocaleTimeString('tr-TR', {
          hour: '2-digit',
          minute: '2-digit',
        }),
        status: appointment.status,
        priority: appointment.priority,
        serviceType: appointment.serviceType,
      });
    });

    return {
      year,
      month,
      appointments: calendar,
      total: appointments.length,
    };
  }

  async getDailyAppointments(date: Date) {
    const startOfDay = new Date(date);
    startOfDay.setHours(0, 0, 0, 0);
    const endOfDay = new Date(date);
    endOfDay.setHours(23, 59, 59, 999);

    const appointments = await this.servicesRepository.find({
      where: {
        scheduledDate: Between(startOfDay, endOfDay),
      },
      relations: ['customer', 'assignedTechnician', 'device'],
      order: { scheduledDate: 'ASC' },
    });

    return appointments.map((apt) => ({
      id: apt.id,
      serviceNumber: apt.serviceNumber,
      customer: {
        id: apt.customer?.id,
        name: apt.customer?.fullName,
        phone: apt.customer?.phone,
        address: apt.customer?.address,
      },
      technician: {
        id: apt.assignedTechnician?.id,
        name: apt.assignedTechnician?.fullName,
      },
      scheduledDate: apt.scheduledDate,
      estimatedDuration: apt.estimatedDuration,
      status: apt.status,
      priority: apt.priority,
      serviceType: apt.serviceType,
    }));
  }

  async getWeeklyAppointments(startDate: Date) {
    const endDate = new Date(startDate);
    endDate.setDate(endDate.getDate() + 7);

    const appointments = await this.servicesRepository.find({
      where: {
        scheduledDate: Between(startDate, endDate),
      },
      relations: ['customer', 'assignedTechnician'],
      order: { scheduledDate: 'ASC' },
    });

    // Günlere göre grupla
    const weekData = {};
    for (let i = 0; i < 7; i++) {
      const day = new Date(startDate);
      day.setDate(day.getDate() + i);
      const dayKey = day.toISOString().split('T')[0];
      weekData[dayKey] = [];
    }

    appointments.forEach((apt) => {
      const dayKey = apt.scheduledDate.toISOString().split('T')[0];
      if (weekData[dayKey]) {
        weekData[dayKey].push({
          id: apt.id,
          serviceNumber: apt.serviceNumber,
          customer: apt.customer?.fullName,
          technician: apt.assignedTechnician?.fullName,
          time: apt.scheduledDate.toLocaleTimeString('tr-TR', {
            hour: '2-digit',
            minute: '2-digit',
          }),
          status: apt.status,
          priority: apt.priority,
        });
      }
    });

    return weekData;
  }

  async getTechnicianAppointments(technicianId: string, date: Date) {
    const startOfDay = new Date(date);
    startOfDay.setHours(0, 0, 0, 0);
    const endOfDay = new Date(date);
    endOfDay.setHours(23, 59, 59, 999);

    return await this.servicesRepository.find({
      where: {
        technicianId,
        scheduledDate: Between(startOfDay, endOfDay),
      },
      relations: ['customer', 'device'],
      order: { scheduledDate: 'ASC' },
    });
  }

  async getAvailableSlots(date: Date, technicianId?: string) {
    const startOfDay = new Date(date);
    startOfDay.setHours(8, 0, 0, 0); // İş günü 08:00'de başlar
    const endOfDay = new Date(date);
    endOfDay.setHours(18, 0, 0, 0); // İş günü 18:00'de biter

    // Mevcut randevuları al
    const where: any = {
      scheduledDate: Between(startOfDay, endOfDay),
      status: Between(ServiceStatus.PLANNED, ServiceStatus.IN_PROGRESS),
    };

    if (technicianId) {
      where.technicianId = technicianId;
    }

    const bookedSlots = await this.servicesRepository.find({
      where,
      select: ['scheduledDate', 'estimatedDuration'],
    });

    // 30 dakikalık slotlar oluştur
    const slots = [];
    const slotDuration = 30; // dakika
    let currentTime = new Date(startOfDay);

    while (currentTime < endOfDay) {
      const slotEnd = new Date(currentTime);
      slotEnd.setMinutes(slotEnd.getMinutes() + slotDuration);

      // Bu slot dolu mu kontrol et
      const isBooked = bookedSlots.some((booking) => {
        const bookingEnd = new Date(booking.scheduledDate);
        bookingEnd.setMinutes(
          bookingEnd.getMinutes() + (booking.estimatedDuration || 60),
        );
        return (
          (currentTime >= booking.scheduledDate && currentTime < bookingEnd) ||
          (slotEnd > booking.scheduledDate && slotEnd <= bookingEnd)
        );
      });

      slots.push({
        time: currentTime.toLocaleTimeString('tr-TR', {
          hour: '2-digit',
          minute: '2-digit',
        }),
        available: !isBooked,
      });

      currentTime = slotEnd;
    }

    return slots;
  }

  async rescheduleAppointment(serviceId: string, newDate: Date) {
    const service = await this.servicesRepository.findOne({
      where: { id: serviceId },
    });

    if (!service) {
      throw new Error('Service not found');
    }

    service.scheduledDate = newDate;
    return await this.servicesRepository.save(service);
  }

  async checkConflicts(
    technicianId: string,
    date: Date,
    duration: number,
  ): Promise<boolean> {
    const endTime = new Date(date);
    endTime.setMinutes(endTime.getMinutes() + duration);

    const conflicts = await this.servicesRepository
      .createQueryBuilder('service')
      .where('service.technicianId = :technicianId', { technicianId })
      .andWhere('service.scheduledDate < :endTime', { endTime })
      .andWhere(
        'DATE_ADD(service.scheduledDate, INTERVAL service.estimatedDuration MINUTE) > :date',
        { date },
      )
      .andWhere('service.status IN (:...statuses)', {
        statuses: [ServiceStatus.PLANNED, ServiceStatus.IN_PROGRESS],
      })
      .getCount();

    return conflicts > 0;
  }

  // Hatırlatma sistemi
  async sendReminder(serviceId: string, type: 'sms' | 'email' | 'both') {
    const service = await this.servicesRepository.findOne({
      where: { id: serviceId },
      relations: ['customer', 'assignedTechnician'],
    });

    if (!service || !service.customer) {
      throw new Error('Service or customer not found');
    }

    const customer = service.customer;
    const technician = service.assignedTechnician;

    // Mesaj içeriği
    const message = `Sayın ${customer.fullName},\n\n${
      service.scheduledDate.toLocaleDateString('tr-TR')
    } tarihinde saat ${service.scheduledDate.toLocaleTimeString('tr-TR', {
      hour: '2-digit',
      minute: '2-digit',
    })} için randevunuz bulunmaktadır.\n\nServis Tipi: ${
      service.serviceType
    }\nTeknisyen: ${technician?.fullName || 'Atanmadı'}\n\nTeşekkür ederiz,\nAkın Kombi`;

    const results = {
      sms: false,
      email: false,
    };

    try {
      if (type === 'sms' || type === 'both') {
        await this.communicationsService.sendSMS(customer.phone, message);
        results.sms = true;
      }

      if (type === 'email' || type === 'both') {
        await this.communicationsService.sendEmail(
          customer.email,
          'Randevu Hatırlatma',
          message,
        );
        results.email = true;
      }

      return {
        success: true,
        message: 'Reminder sent successfully',
        results,
      };
    } catch (error) {
      throw new Error(`Failed to send reminder: ${error.message}`);
    }
  }

  async sendBulkReminders(
    reminderType: 'sms' | 'email' | 'both',
    hoursAhead: number = 24,
  ) {
    const now = new Date();
    const startTime = new Date(now.getTime() + hoursAhead * 60 * 60 * 1000);
    const endTime = new Date(
      startTime.getTime() + 60 * 60 * 1000,
    ); // 1 saatlik pencere

    // Gelecek randevuları al
    const appointments = await this.servicesRepository.find({
      where: {
        scheduledDate: Between(startTime, endTime),
        status: ServiceStatus.PLANNED,
      },
      relations: ['customer', 'assignedTechnician'],
    });

    const results = {
      total: appointments.length,
      sent: 0,
      failed: 0,
      errors: [],
    };

    for (const appointment of appointments) {
      try {
        await this.sendReminder(appointment.id, reminderType);
        results.sent++;
      } catch (error) {
        results.failed++;
        results.errors.push({
          serviceId: appointment.id,
          error: error.message,
        });
      }
    }

    return results;
  }

  async getUpcomingAppointments(hoursAhead: number = 24) {
    const now = new Date();
    const endTime = new Date(now.getTime() + hoursAhead * 60 * 60 * 1000);

    return await this.servicesRepository.find({
      where: {
        scheduledDate: Between(now, endTime),
        status: ServiceStatus.PLANNED,
      },
      relations: ['customer', 'assignedTechnician'],
      order: { scheduledDate: 'ASC' },
    });
  }
}
