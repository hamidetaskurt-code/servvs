import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Between } from 'typeorm';
import { Communication } from '../customers/entities/communication.entity';
import { MessageTemplate } from './entities/message-template.entity';
import { Campaign } from './entities/campaign.entity';
import { Customer } from '../customers/entities/customer.entity';

@Injectable()
export class CommunicationsService {
  constructor(
    @InjectRepository(Communication)
    private communicationsRepository: Repository<Communication>,
    @InjectRepository(MessageTemplate)
    private templatesRepository: Repository<MessageTemplate>,
    @InjectRepository(Campaign)
    private campaignsRepository: Repository<Campaign>,
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
    const campaign = this.campaignsRepository.create(campaignData);
    return await this.campaignsRepository.save(campaign);
  }

  async getCampaigns(status?: string) {
    const where: any = {};
    if (status) {
      where.status = status;
    }

    return await this.campaignsRepository.find({
      where,
      order: { createdAt: 'DESC' },
    });
  }

  async getCampaign(id: string) {
    return await this.campaignsRepository.findOne({ where: { id } });
  }

  async updateCampaign(id: string, updateData: any) {
    await this.campaignsRepository.update(id, updateData);
    return await this.getCampaign(id);
  }

  async deleteCampaign(id: string) {
    await this.campaignsRepository.softDelete(id);
    return { success: true, message: 'Campaign deleted' };
  }

  async getCampaignStats(id: string) {
    const campaign = await this.getCampaign(id);

    if (!campaign) {
      return null;
    }

    const deliveryRate =
      campaign.sentCount > 0
        ? (campaign.deliveredCount / campaign.sentCount) * 100
        : 0;

    return {
      campaign: {
        id: campaign.id,
        name: campaign.name,
        type: campaign.type,
        status: campaign.status,
      },
      stats: {
        recipients: campaign.recipientCount,
        sent: campaign.sentCount,
        delivered: campaign.deliveredCount,
        failed: campaign.failedCount,
        deliveryRate: parseFloat(deliveryRate.toFixed(2)),
      },
    };
  }

  async sendCampaign(id: string) {
    const campaign = await this.getCampaign(id);

    if (!campaign) {
      throw new Error('Campaign not found');
    }

    if (campaign.status === 'SENT') {
      throw new Error('Campaign already sent');
    }

    // Hedef müşterileri al
    let customers: Customer[];

    if (campaign.targetSegment) {
      // Segment bazlı filtreleme (örnek: VIP müşteriler, belirli bir şehirdeki müşteriler, vb.)
      const query = this.customersRepository.createQueryBuilder('customer');

      if (campaign.targetSegment.type) {
        query.andWhere('customer.type = :type', {
          type: campaign.targetSegment.type,
        });
      }

      if (campaign.targetSegment.city) {
        query.andWhere('customer.city = :city', {
          city: campaign.targetSegment.city,
        });
      }

      if (campaign.targetSegment.minSpent) {
        query.andWhere('customer.totalSpent >= :minSpent', {
          minSpent: campaign.targetSegment.minSpent,
        });
      }

      customers = await query.getMany();
    } else {
      // Tüm aktif müşteriler
      customers = await this.customersRepository.find();
    }

    campaign.recipientCount = customers.length;

    // Kampanyayı gönder
    let sentCount = 0;
    let deliveredCount = 0;
    let failedCount = 0;

    for (const customer of customers) {
      try {
        if (campaign.type === 'SMS') {
          await this.sendSMS(customer.phone, campaign.content);
        } else if (campaign.type === 'EMAIL') {
          await this.sendEmail(
            customer.email,
            campaign.subject || 'Bilgilendirme',
            campaign.content,
          );
        } else if (campaign.type === 'WHATSAPP') {
          await this.sendWhatsApp(customer.phone, campaign.content);
        }

        sentCount++;
        deliveredCount++; // Gerçek entegrasyonda delivery notification ile güncellenecek
      } catch (error) {
        failedCount++;
      }
    }

    // Campaign istatistiklerini güncelle
    campaign.sentCount = sentCount;
    campaign.deliveredCount = deliveredCount;
    campaign.failedCount = failedCount;
    campaign.status = 'SENT';
    campaign.sentAt = new Date();

    await this.campaignsRepository.save(campaign);

    return {
      success: true,
      message: 'Campaign sent successfully',
      stats: {
        sent: sentCount,
        delivered: deliveredCount,
        failed: failedCount,
      },
    };
  }
}
