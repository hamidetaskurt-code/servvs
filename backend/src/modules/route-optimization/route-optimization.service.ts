import { Injectable } from '@nestjs/common';

// Define the structure of a location point
interface Point {
  id: number | string; // 'start' or service ID
  lat: number;
  lon: number;
}

@Injectable()
export class RouteOptimizationService {
  
  /**
   * Calculates the distance between two points on Earth using the Haversine formula.
   * @param lat1 Latitude of the first point
   * @param lon1 Longitude of the first point
   * @param lat2 Latitude of the second point
   * @param lon2 Longitude of the second point
   * @returns The distance in kilometers.
   */
  private getDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
    const R = 6371; // Radius of the Earth in km
    const dLat = this.deg2rad(lat2 - lat1);
    const dLon = this.deg2rad(lon2 - lon1);
    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(this.deg2rad(lat1)) * Math.cos(this.deg2rad(lat2)) *
      Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c; // Distance in km
  }

  private deg2rad(deg: number): number {
    return deg * (Math.PI / 180);
  }

  /**
   * Finds the nearest unvisited point from a given point.
   * @param currentPoint The starting point.
   * @param unvisitedPoints An array of points to search through.
   * @returns The nearest point and its distance.
   */
  private findNearest(currentPoint: Point, unvisitedPoints: Point[]): { nearest: Point, distance: number } {
    let nearest: Point | null = null;
    let minDistance = Infinity;

    for (const point of unvisitedPoints) {
      const distance = this.getDistance(currentPoint.lat, currentPoint.lon, point.lat, point.lon);
      if (distance < minDistance) {
        minDistance = distance;
        nearest = point;
      }
    }
    return { nearest, distance: minDistance };
  }

  /**
   * Optimizes a route using the Nearest Neighbor heuristic.
   * @param payload The optimization request data.
   * @returns An object containing the optimized route, total distance, and total time.
   */
  public optimizeRoute(payload: { technician: { startLat: number, startLon: number }, services: Point[] }) {
    const { technician, services } = payload;
    
    if (!services || services.length === 0) {
      return { optimizedRoute: [], totalDistance: 0, totalTime: 0, message: "No services to optimize." };
    }

    const startPoint: Point = { id: 'start', lat: technician.startLat, lon: technician.startLon };
    let unvisited = [...services];
    let currentPoint = startPoint;
    const optimizedRoute: { service: Point, distanceFromPrevious: number }[] = [];
    let totalDistance = 0;

    while (unvisited.length > 0) {
      const { nearest, distance } = this.findNearest(currentPoint, unvisited);
      
      if (nearest) {
        totalDistance += distance;
        optimizedRoute.push({ service: nearest, distanceFromPrevious: distance });
        currentPoint = nearest;
        unvisited = unvisited.filter(p => p.id !== nearest.id);
      } else {
        // Should not happen if unvisited is not empty
        break;
      }
    }

    // Assuming an average speed of 40 km/h and 30 minutes per service
    const averageSpeedKmh = 40;
    const serviceDurationMinutes = 30;
    const travelTimeHours = totalDistance / averageSpeedKmh;
    const totalServiceTimeMinutes = optimizedRoute.length * serviceDurationMinutes;
    const totalTimeMinutes = (travelTimeHours * 60) + totalServiceTimeMinutes;

    return {
      optimizedRoute: optimizedRoute.map((item, index) => ({
        order: index + 1,
        serviceId: item.service.id,
        lat: item.service.lat,
        lon: item.service.lon,
        distanceKm: item.distanceFromPrevious.toFixed(2),
      })),
      totalDistance: totalDistance.toFixed(2),
      totalTimeMinutes: totalTimeMinutes.toFixed(0),
      summary: `Optimized route for ${optimizedRoute.length} services. Total distance: ${totalDistance.toFixed(2)} km. Estimated total time: ${totalTimeMinutes.toFixed(0)} minutes.`
    };
  }
}
