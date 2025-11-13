import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import axios from 'axios';

export interface Coordinate {
  lat: number;
  lng: number;
}

export interface DistanceMatrixResult {
  origins: string[];
  destinations: string[];
  rows: {
    elements: {
      distance: { text: string; value: number }; // value in meters
      duration: { text: string; value: number }; // value in seconds
      duration_in_traffic?: { text: string; value: number };
      status: string;
    }[];
  }[];
}

export interface DirectionsResult {
  routes: {
    legs: {
      distance: { text: string; value: number };
      duration: { text: string; value: number };
      duration_in_traffic?: { text: string; value: number };
      start_address: string;
      end_address: string;
      start_location: Coordinate;
      end_location: Coordinate;
      steps: any[];
    }[];
    overview_polyline: { points: string };
    summary: string;
    warnings: string[];
    waypoint_order: number[];
  }[];
}

export interface GeocodedLocation {
  lat: number;
  lng: number;
  formatted_address: string;
  place_id: string;
}

/**
 * Google Maps API Service
 * Distance Matrix, Directions, Geocoding vb.
 */
@Injectable()
export class GoogleMapsService {
  private readonly logger = new Logger(GoogleMapsService.name);
  private readonly apiKey: string;
  private readonly baseUrl = 'https://maps.googleapis.com/maps/api';

  constructor(private configService: ConfigService) {
    this.apiKey = this.configService.get<string>('GOOGLE_MAPS_API_KEY') || '';
    if (!this.apiKey) {
      this.logger.warn('GOOGLE_MAPS_API_KEY not configured!');
    }
  }

  /**
   * Distance Matrix API
   * Birden fazla origin ve destination arasındaki mesafe ve süre
   */
  async calculateDistanceMatrix(
    origins: Coordinate[],
    destinations: Coordinate[],
    options?: {
      mode?: 'driving' | 'walking' | 'bicycling' | 'transit';
      departureTime?: Date;
      trafficModel?: 'best_guess' | 'optimistic' | 'pessimistic';
    },
  ): Promise<DistanceMatrixResult> {
    try {
      const originsStr = origins.map((o) => `${o.lat},${o.lng}`).join('|');
      const destinationsStr = destinations
        .map((d) => `${d.lat},${d.lng}`)
        .join('|');

      const params: any = {
        origins: originsStr,
        destinations: destinationsStr,
        key: this.apiKey,
        mode: options?.mode || 'driving',
        language: 'tr',
        units: 'metric',
      };

      // Trafik bilgisi için departure_time ekle
      if (options?.departureTime) {
        params.departure_time = Math.floor(
          options.departureTime.getTime() / 1000,
        );
        params.traffic_model = options?.trafficModel || 'best_guess';
      }

      const response = await axios.get(
        `${this.baseUrl}/distancematrix/json`,
        {
          params,
          timeout: 10000,
        },
      );

      if (response.data.status !== 'OK') {
        throw new Error(`Google Maps API Error: ${response.data.status}`);
      }

      return response.data;
    } catch (error) {
      this.logger.error('Distance Matrix API Error:', error.message);
      throw error;
    }
  }

  /**
   * Directions API
   * Belirli bir origin'den destination'a en iyi rota
   */
  async getDirections(
    origin: Coordinate,
    destination: Coordinate,
    waypoints?: Coordinate[],
    options?: {
      optimize?: boolean;
      alternatives?: boolean;
      departureTime?: Date;
      avoidTolls?: boolean;
      avoidHighways?: boolean;
    },
  ): Promise<DirectionsResult> {
    try {
      const params: any = {
        origin: `${origin.lat},${origin.lng}`,
        destination: `${destination.lat},${destination.lng}`,
        key: this.apiKey,
        mode: 'driving',
        language: 'tr',
        units: 'metric',
        alternatives: options?.alternatives || false,
      };

      // Waypoints ekle
      if (waypoints && waypoints.length > 0) {
        const waypointsStr = waypoints
          .map((w) => `${w.lat},${w.lng}`)
          .join('|');
        params.waypoints = options?.optimize
          ? `optimize:true|${waypointsStr}`
          : waypointsStr;
      }

      // Trafik bilgisi
      if (options?.departureTime) {
        params.departure_time = Math.floor(
          options.departureTime.getTime() / 1000,
        );
      }

      // Avoid options
      const avoid: string[] = [];
      if (options?.avoidTolls) avoid.push('tolls');
      if (options?.avoidHighways) avoid.push('highways');
      if (avoid.length > 0) {
        params.avoid = avoid.join('|');
      }

      const response = await axios.get(`${this.baseUrl}/directions/json`, {
        params,
        timeout: 10000,
      });

      if (response.data.status !== 'OK') {
        throw new Error(`Google Maps API Error: ${response.data.status}`);
      }

      return response.data;
    } catch (error) {
      this.logger.error('Directions API Error:', error.message);
      throw error;
    }
  }

  /**
   * Geocoding API
   * Adres -> Koordinat
   */
  async geocodeAddress(address: string): Promise<GeocodedLocation> {
    try {
      const response = await axios.get(`${this.baseUrl}/geocode/json`, {
        params: {
          address,
          key: this.apiKey,
          language: 'tr',
        },
        timeout: 5000,
      });

      if (
        response.data.status !== 'OK' ||
        response.data.results.length === 0
      ) {
        throw new Error(`Geocoding Error: ${response.data.status}`);
      }

      const result = response.data.results[0];
      return {
        lat: result.geometry.location.lat,
        lng: result.geometry.location.lng,
        formatted_address: result.formatted_address,
        place_id: result.place_id,
      };
    } catch (error) {
      this.logger.error('Geocoding API Error:', error.message);
      throw error;
    }
  }

  /**
   * Reverse Geocoding
   * Koordinat -> Adres
   */
  async reverseGeocode(
    lat: number,
    lng: number,
  ): Promise<{ formatted_address: string }> {
    try {
      const response = await axios.get(`${this.baseUrl}/geocode/json`, {
        params: {
          latlng: `${lat},${lng}`,
          key: this.apiKey,
          language: 'tr',
        },
        timeout: 5000,
      });

      if (
        response.data.status !== 'OK' ||
        response.data.results.length === 0
      ) {
        throw new Error(`Reverse Geocoding Error: ${response.data.status}`);
      }

      return {
        formatted_address: response.data.results[0].formatted_address,
      };
    } catch (error) {
      this.logger.error('Reverse Geocoding API Error:', error.message);
      throw error;
    }
  }

  /**
   * Places Autocomplete
   * Adres önerisi
   */
  async autocompleteAddress(
    input: string,
    options?: {
      types?: string[];
      components?: string; // country:tr
    },
  ): Promise<
    Array<{
      description: string;
      place_id: string;
    }>
  > {
    try {
      const params: any = {
        input,
        key: this.apiKey,
        language: 'tr',
      };

      if (options?.types) {
        params.types = options.types.join('|');
      }

      if (options?.components) {
        params.components = options.components;
      }

      const response = await axios.get(
        `${this.baseUrl}/place/autocomplete/json`,
        {
          params,
          timeout: 5000,
        },
      );

      if (response.data.status !== 'OK') {
        return [];
      }

      return response.data.predictions.map((p: any) => ({
        description: p.description,
        place_id: p.place_id,
      }));
    } catch (error) {
      this.logger.error('Autocomplete API Error:', error.message);
      return [];
    }
  }

  /**
   * Place Details
   * Place ID'den detaylı bilgi
   */
  async getPlaceDetails(placeId: string): Promise<any> {
    try {
      const response = await axios.get(`${this.baseUrl}/place/details/json`, {
        params: {
          place_id: placeId,
          key: this.apiKey,
          language: 'tr',
        },
        timeout: 5000,
      });

      if (response.data.status !== 'OK') {
        throw new Error(`Place Details Error: ${response.data.status}`);
      }

      return response.data.result;
    } catch (error) {
      this.logger.error('Place Details API Error:', error.message);
      throw error;
    }
  }

  /**
   * API anahtarı kontrolü
   */
  isConfigured(): boolean {
    return !!this.apiKey;
  }
}
