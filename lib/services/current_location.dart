import 'package:location/location.dart';
import 'dart:developer';

class CurrentLocation {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Future<void> initState() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  LocationData getLocation() {
    LocationData locationData;
    location.onLocationChanged.listen((LocationData currentLocation) async {
      locationData = await location.getLocation();
      // log('locationData: $locationData');
    });
    return locationData;
  }
}
