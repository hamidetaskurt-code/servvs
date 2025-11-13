import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Setting } from './entities/setting.entity';

@Injectable()
export class SettingsService {
  constructor(
    @InjectRepository(Setting)
    private settingsRepository: Repository<Setting>,
  ) {}

  async findAll() {
    return await this.settingsRepository.find({
      order: { category: 'ASC', key: 'ASC' },
    });
  }

  async findOne(key: string) {
    const setting = await this.settingsRepository.findOne({
      where: { key },
    });

    if (!setting) {
      throw new NotFoundException(`Setting with key ${key} not found`);
    }

    return setting;
  }

  async create(settingData: any) {
    const setting = this.settingsRepository.create(settingData);
    return await this.settingsRepository.save(setting);
  }

  async update(key: string, value: any) {
    const setting = await this.findOne(key);
    setting.value = value;
    setting.updatedAt = new Date();
    return await this.settingsRepository.save(setting);
  }

  async getCompanyInfo() {
    const settings = await this.settingsRepository.find({
      where: { category: 'company' },
    });

    const companyInfo = {};
    settings.forEach((setting) => {
      companyInfo[setting.key] = setting.value;
    });

    return companyInfo;
  }

  async updateCompanyInfo(companyData: any) {
    const updates = [];

    for (const [key, value] of Object.entries(companyData)) {
      const fullKey = `company.${key}`;
      let setting = await this.settingsRepository.findOne({
        where: { key: fullKey },
      });

      if (setting) {
        setting.value = value;
      } else {
        setting = this.settingsRepository.create({
          key: fullKey,
          value,
          category: 'company',
        });
      }

      updates.push(this.settingsRepository.save(setting));
    }

    await Promise.all(updates);

    return { success: true, message: 'Company info updated' };
  }

  async getValue(key: string, defaultValue?: any) {
    try {
      const setting = await this.findOne(key);
      return setting.value;
    } catch (error) {
      return defaultValue;
    }
  }

  async setValue(key: string, value: any, category: string = 'general') {
    let setting = await this.settingsRepository.findOne({
      where: { key },
    });

    if (setting) {
      setting.value = value;
    } else {
      setting = this.settingsRepository.create({
        key,
        value,
        category,
      });
    }

    return await this.settingsRepository.save(setting);
  }
}
