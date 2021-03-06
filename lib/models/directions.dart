import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Direction {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoint;
  final String totalDistance;
  final String totalDuration;
  final double distanceValue;

  const Direction(
      {@required this.bounds,
      @required this.polylinePoint,
      @required this.totalDistance,
      @required this.totalDuration,
      @required this.distanceValue});
  factory Direction.fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) return null;
    final data = Map<String, dynamic>.from(map['routes'][0]);
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
        southwest: LatLng(southwest['lat'], southwest['lng']),
        northeast: LatLng(northeast['lat'], northeast['lng']));
    String distance;
    String duration;
    double distanceValue;
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
      distanceValue = leg['distance']['value'] / 1000;
    }

    return Direction(
        bounds: bounds,
        polylinePoint: PolylinePoints()
            .decodePolyline(data['overview_polyline']['points']),
        totalDistance: distance,
        totalDuration: duration,
        distanceValue: distanceValue);
  }
}
