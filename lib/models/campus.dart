import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class Campus {
  String campusID;
  String campusName;
  String address;
  GeoPoint location;

  Campus(this.campusID, this.campusName, this.address, this.location);

  get getCampusID => this.campusID;

  set setCampusID(campusID) => this.campusID = campusID;

  get getCampusName => this.campusName;

  set setCampusName(campusName) => this.campusName = campusName;

  get getAddress => this.address;

  set setAddress(address) => this.address = address;

  get getGeoPoint => this.location;

  set setGeoPoint(location) => this.location = location;

  Campus.fromJson(Map<String, dynamic> json) {
    campusID = json['campus_id'];
    campusName = json['campus_name'];
    address = json['address'];
    location = json['location'];
  }
}
