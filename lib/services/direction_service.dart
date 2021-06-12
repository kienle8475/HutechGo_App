import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hutech_go/models/directions.dart';

import 'googlemap_service.dart';

class DirectionService {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  final Dio _dio;
  DirectionService({Dio dio}) : _dio = dio ?? Dio();

  Future<Direction> getDirections(
      {@required LatLng origin, @required LatLng destination}) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude}, ${origin.longitude}',
      'destination': '${destination.latitude}, ${destination.longitude}',
      'key': GoogleMapService.MAP_API_KEY
    });
    if (response.statusCode == 200) {
      return Direction.fromMap(response.data);
    }
    return null;
  }
}
