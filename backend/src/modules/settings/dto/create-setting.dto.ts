import { IsNotEmpty, IsString, IsOptional, IsBoolean, IsEnum } from 'class-validator';

export enum SettingCategory {
  GENERAL = 'general',
  COMPANY = 'company',
  NOTIFICATION = 'notification',
  INTEGRATION = 'integration',
  SECURITY = 'security',
  BILLING = 'billing',
  APPEARANCE = 'appearance',
}

export class CreateSettingDto {
  @IsNotEmpty()
  @IsString()
  key: string;

  @IsNotEmpty()
  @IsString()
  value: string;

  @IsOptional()
  @IsEnum(SettingCategory)
  category?: SettingCategory;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsBoolean()
  isPublic?: boolean; // Kullanıcılara gösterilsin mi?

  @IsOptional()
  @IsBoolean()
  isEncrypted?: boolean; // Şifreli saklanacak mı?
}
