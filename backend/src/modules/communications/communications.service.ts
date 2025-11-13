import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Between } from 'typeorm';
import { Communication } from '../customers/entities/communication.entity';
import { MessageTemplate } from './entities/message-template.entity';
import { Customer } from '../customers/entities/customer.entity';

@Injectable()
export class CommunicationsService {
  constructor(
    @InjectRepository(Communication)
    private communicationsRepository: Repository<Communication>,
    @InjectRepository(MessageTemplate)
    private templatesRepository: Repository<MessageTemplate>,
    @InjectRepository(Customer)
    private customersRepository: Repository<Customer>,
  ) {}

  async getStats(startDate?: Date, endDate?: Date) {
    if (!startDate) {
      startDate = new Date();
      startDate.setDate(1);
    }
    if (!endDate) {
      endDate = new Date();
    }

    const smsCount = await this.communicationsRepository.count({
      where: {
        communicationType: 'sms',
        createdAt: Between(startDate, endDate),
      },
    });

    const emailCount = await this.communicationsRepository.count({
      where: {
        communicationType: 'email',
        createdAt: Between(startDate, endDate),
      },
    });

    const whatsappCount = await this.communicationsRepository.count({
      where: {
        communicationType: 'whatsapp',
        createdAt: Between(startDate, endDate),
      },
    });

    const callCount = await this.communicationsRepository.count({
      where: {
        communicationType: 'phone',
        createdAt: Between(startDate, endDate),
      },
    });

    return {
      period: { startDate, endDate },
      sms: smsCount,
      email: emailCount,
      whatsapp: whatsappCount,
      calls: callCount,
      total: smsCount + emailCount + whatsappCount + callCount,
    };
  }

  async sendSMS(to: string, message: string) {
    // SMS provider entegrasyonu burada yapılacak
    // Şimdilik sadece kayıt edelim
    const communication = this.communicationsRepository.create({
      communicationType: 'sms',
      direction: 'outbound',
      content: message,
      status: 'sent',
      communicationDate: new Date(),
    });

    await this.communicationsRepository.save(communication);

    return {
      success: true,
      messageId: communication.id,
      message: 'SMS sent successfully',
    };
  }

  async sendBulkSMS(recipients: string[], message: string) {
    const results = await Promise.all(
      recipients.map((recipient) => this.sendSMS(recipient, message)),
    );

    return {
      success: true,
      sent: results.length,
      failed: 0,
    };
  }

  async sendEmail(to: string, subject: string, body: string) {
    // Email provider entegrasyonu burada yapılacak
    const communication = this.communicationsRepository.create({
      communicationType: 'email',
      direction: 'outbound',
      subject,
      content: body,
      status: 'sent',
      communicationDate: new Date(),
    });

    await this.communicationsRepository.save(communication);

    return {
      success: true,
      messageId: communication.id,
      message: 'Email sent successfully',
    };
  }

  async sendBulkEmail(recipients: string[], subject: string, body: string) {
    const results = await Promise.all(
      recipients.map((recipient) => this.sendEmail(recipient, subject, body)),
    );

    return {
      success: true,
      sent: results.length,
      failed: 0,
    };
  }

  async sendWhatsApp(to: string, message: string) {
    // WhatsApp Business API entegrasyonu burada yapılacak
    const communication = this.communicationsRepository.create({
      communicationType: 'whatsapp',
      direction: 'outbound',
      content: message,
      status: 'sent',
      communicationDate: new Date(),
    });

    await this.communicationsRepository.save(communication);

    return {
      success: true,
      messageId: communication.id,
      message: 'WhatsApp message sent successfully',
    };
  }

  async getTemplates(type?: string) {
    const where: any = { isActive: true };
    if (type) {
      where.type = type;
    }

    return await this.templatesRepository.find({
      where,
      order: { name: 'ASC' },
    });
  }

  async createTemplate(templateData: any) {
    const template = this.templatesRepository.create(templateData);
    return await this.templatesRepository.save(template);
  }

  async getHistory(customerId?: string, type?: string, limit: number = 50) {
    const where: any = {};
    if (customerId) {
      where.customerId = customerId;
    }
    if (type) {
      where.communicationType = type;
    }

    return await this.communicationsRepository.find({
      where,
      relations: ['customer'],
      order: { createdAt: 'DESC' },
      take: limit,
    });
  }

  async createCampaign(campaignData: any) {
    // Campaign functionality will be implemented later
    return {
      success: true,
      message: 'Campaign created',
      data: campaignData,
    };
  }

  async getCampaigns() {
    // Campaign functionality will be implemented later
    return [];
  }

  async getCampaignStats(id: string) {
    // Campaign functionality will be implemented later
    return {
      campaign: { id },
      stats: {
        sent: 0,
        delivered: 0,
        failed: 0,
        deliveryRate: 0,
      },
    };
  }
}
