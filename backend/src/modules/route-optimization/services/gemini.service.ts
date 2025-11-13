import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { GoogleGenerativeAI } from '@google/generative-ai';

export interface RouteAnalysisResult {
  score: number;
  pros: string[];
  cons: string[];
  risks: RiskAssessment[];
  recommendations: string[];
}

export interface RiskAssessment {
  level: 'low' | 'medium' | 'high';
  type: string;
  description: string;
  suggestion: string;
}

export interface DailyReport {
  date: string;
  overallScore: number;
  successMetrics: {
    totalServices: number;
    completedServices: number;
    appointmentAccuracy: number;
    customerSatisfaction: number;
    fuelSavings: number;
  };
  improvements: string[];
  trends: {
    metric: string;
    trend: 'up' | 'down' | 'stable';
    value: string;
  }[];
  tomorrowSuggestions: string[];
}

/**
 * Gemini AI Service
 * Rota analizi, risk tespiti, rapor oluşturma, doğal dil işleme
 */
@Injectable()
export class GeminiService {
  private readonly logger = new Logger(GeminiService.name);
  private genAI: GoogleGenerativeAI | null = null;
  private model: any = null;

  constructor(private configService: ConfigService) {
    const apiKey = this.configService.get<string>('GEMINI_API_KEY');
    if (apiKey) {
      this.genAI = new GoogleGenerativeAI(apiKey);
      this.model = this.genAI.getGenerativeModel({ model: 'gemini-pro' });
      this.logger.log('Gemini AI initialized successfully');
    } else {
      this.logger.warn('GEMINI_API_KEY not configured!');
    }
  }

  /**
   * Rota Alternatiflerini Analiz Et ve Skorla
   */
  async analyzeRoutes(
    routes: any[],
    context: {
      technicians?: any[];
      services?: any[];
      weather?: any;
      traffic?: any;
      historicalData?: any[];
    },
  ): Promise<RouteAnalysisResult[]> {
    if (!this.model) {
      throw new Error('Gemini AI is not configured');
    }

    try {
      const prompt = this.buildRouteAnalysisPrompt(routes, context);
      const result = await this.model.generateContent(prompt);
      const response = await result.response;
      const text = response.text();

      return this.parseRouteAnalysisResponse(text);
    } catch (error) {
      this.logger.error('Gemini Route Analysis Error:', error.message);
      throw error;
    }
  }

  /**
   * Risk Tespiti
   */
  async identifyRouteRisks(
    route: any,
    context: any,
  ): Promise<RiskAssessment[]> {
    if (!this.model) {
      throw new Error('Gemini AI is not configured');
    }

    try {
      const prompt = `
Aşağıdaki rota planı için potansiyel riskleri analiz et:

ROTA BİLGİLERİ:
${JSON.stringify(route, null, 2)}

BAĞLAM:
${JSON.stringify(context, null, 2)}

Lütfen aşağıdaki formatta riskler döndür (JSON):
{
  "risks": [
    {
      "level": "high|medium|low",
      "type": "trafik|teknisyen|müşteri|stok|hava|diğer",
      "description": "Risk açıklaması",
      "suggestion": "Çözüm önerisi"
    }
  ]
}
`;

      const result = await this.model.generateContent(prompt);
      const response = await result.response;
      const text = response.text();

      return this.parseRiskAssessmentResponse(text);
    } catch (error) {
      this.logger.error('Gemini Risk Assessment Error:', error.message);
      return [];
    }
  }

  /**
   * Günlük Rapor Oluştur
   */
  async generateDailyReport(
    plannedRoutes: any[],
    actualRoutes: any[],
    feedback: any[],
  ): Promise<DailyReport> {
    if (!this.model) {
      throw new Error('Gemini AI is not configured');
    }

    try {
      const prompt = `
Günlük rota performans raporu oluştur:

PLANLANAN ROTALAR:
${JSON.stringify(plannedRoutes, null, 2)}

GERÇEKLEŞEN ROTALAR:
${JSON.stringify(actualRoutes, null, 2)}

GERİ BİLDİRİMLER:
${JSON.stringify(feedback, null, 2)}

Lütfen aşağıdaki formatta detaylı bir rapor oluştur (JSON):
{
  "date": "2025-11-10",
  "overallScore": 87,
  "successMetrics": {
    "totalServices": 18,
    "completedServices": 18,
    "appointmentAccuracy": 94,
    "customerSatisfaction": 4.7,
    "fuelSavings": 6
  },
  "improvements": [
    "Mehmet'in 3. servisi 45 dk gecikti - Trafik tahmini tutmadı",
    "Ali'nin 5. servisi iptal edildi - Müşteri evde değilmiş"
  ],
  "trends": [
    { "metric": "Randevu uyumu", "trend": "up", "value": "%91 → %94" },
    { "metric": "Servis süresi", "trend": "down", "value": "1.8h → 1.7h" }
  ],
  "tomorrowSuggestions": [
    "Cuma trafiği daha yoğun, buffer'ı 20 dk'ya çıkar",
    "VIP müşteri yarın randevu isteyecek pattern'i var"
  ]
}
`;

      const result = await this.model.generateContent(prompt);
      const response = await result.response;
      const text = response.text();

      return this.parseDailyReportResponse(text);
    } catch (error) {
      this.logger.error('Gemini Daily Report Error:', error.message);
      throw error;
    }
  }

  /**
   * Doğal Dil Komutu İşle
   * Örnek: "Yarın için Kadıköy bölgesindeki tüm servisleri Ali'ye ata"
   */
  async processNaturalLanguageCommand(
    command: string,
    context: any,
  ): Promise<any> {
    if (!this.model) {
      throw new Error('Gemini AI is not configured');
    }

    try {
      const prompt = `
Kullanıcının doğal dil komutunu analiz et ve yapılandırılmış bir komuta çevir:

KOMUT: "${command}"

BAĞLAM:
${JSON.stringify(context, null, 2)}

Lütfen aşağıdaki formatta yanıt ver (JSON):
{
  "action": "assign_services|create_route|update_schedule|...",
  "parameters": {
    "date": "2025-11-10",
    "technician": "Ali",
    "region": "Kadıköy",
    "filters": {...}
  },
  "confidence": 0.95,
  "clarificationNeeded": false
}
`;

      const result = await this.model.generateContent(prompt);
      const response = await result.response;
      const text = response.text();

      return this.parseNaturalLanguageResponse(text);
    } catch (error) {
      this.logger.error('Gemini NL Processing Error:', error.message);
      throw error;
    }
  }

  /**
   * Performans Tahmini
   */
  async predictPerformance(
    plannedRoute: any,
    historicalData: any[],
  ): Promise<any> {
    if (!this.model) {
      throw new Error('Gemini AI is not configured');
    }

    try {
      const prompt = `
Planlanan rota için performans tahmini yap:

PLANLANAN ROTA:
${JSON.stringify(plannedRoute, null, 2)}

GEÇMİŞ VERİLER:
${JSON.stringify(historicalData, null, 2)}

Aşağıdaki metrikleri tahmin et (JSON):
{
  "estimatedDuration": 4.5,
  "estimatedDistance": 47,
  "probabilityOfDelay": 0.15,
  "expectedCustomerSatisfaction": 4.6,
  "confidenceLevel": 0.85
}
`;

      const result = await this.model.generateContent(prompt);
      const response = await result.response;
      const text = response.text();

      return this.parsePerformancePrediction(text);
    } catch (error) {
      this.logger.error('Gemini Performance Prediction Error:', error.message);
      throw error;
    }
  }

  /**
   * Helper: Route Analysis Prompt Builder
   */
  private buildRouteAnalysisPrompt(routes: any[], context: any): string {
    return `
Aşağıdaki rota alternatiflerini analiz et ve her biri için skor, artılar, eksiler ve öneriler sun:

ROTA ALTERNATİFLERİ:
${JSON.stringify(routes, null, 2)}

BAĞLAM:
${JSON.stringify(context, null, 2)}

Her rota için aşağıdaki formatta analiz yap (JSON Array):
[
  {
    "routeId": 1,
    "score": 85,
    "pros": ["En kısa mesafe", "Mantıklı sıralama"],
    "cons": ["VIP müşteri riski", "Trafikte gecikme olasılığı"],
    "risks": [
      {
        "level": "medium",
        "type": "trafik",
        "description": "15:00 sonrası Kadıköy yoğun olabilir",
        "suggestion": "Servisi 1 saat erkene al"
      }
    ],
    "recommendations": [
      "VIP müşteri için buffer ekle",
      "Teknisyen deneyimli olmalı"
    ]
  }
]
`;
  }

  /**
   * Helper: Parse Route Analysis Response
   */
  private parseRouteAnalysisResponse(text: string): RouteAnalysisResult[] {
    try {
      // JSON çıkar
      const jsonMatch = text.match(/\[[\s\S]*\]/);
      if (jsonMatch) {
        return JSON.parse(jsonMatch[0]);
      }
      return [];
    } catch (error) {
      this.logger.error('Failed to parse route analysis response');
      return [];
    }
  }

  /**
   * Helper: Parse Risk Assessment Response
   */
  private parseRiskAssessmentResponse(text: string): RiskAssessment[] {
    try {
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        const parsed = JSON.parse(jsonMatch[0]);
        return parsed.risks || [];
      }
      return [];
    } catch (error) {
      this.logger.error('Failed to parse risk assessment response');
      return [];
    }
  }

  /**
   * Helper: Parse Daily Report Response
   */
  private parseDailyReportResponse(text: string): DailyReport {
    try {
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        return JSON.parse(jsonMatch[0]);
      }
      throw new Error('No valid JSON found in response');
    } catch (error) {
      this.logger.error('Failed to parse daily report response');
      throw error;
    }
  }

  /**
   * Helper: Parse Natural Language Response
   */
  private parseNaturalLanguageResponse(text: string): any {
    try {
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        return JSON.parse(jsonMatch[0]);
      }
      throw new Error('No valid JSON found in response');
    } catch (error) {
      this.logger.error('Failed to parse NL response');
      throw error;
    }
  }

  /**
   * Helper: Parse Performance Prediction
   */
  private parsePerformancePrediction(text: string): any {
    try {
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        return JSON.parse(jsonMatch[0]);
      }
      throw new Error('No valid JSON found in response');
    } catch (error) {
      this.logger.error('Failed to parse performance prediction');
      throw error;
    }
  }

  /**
   * API anahtarı kontrolü
   */
  isConfigured(): boolean {
    return !!this.genAI;
  }
}
