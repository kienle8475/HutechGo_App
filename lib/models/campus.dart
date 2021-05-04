import 'dart:convert';

import 'package:http/http.dart' as http;

class Campus {
  String campusID;
  String campusName;
  String address;
  double latitude;
  double longitude;

  Campus(this.campusID, this.campusName, this.address, this.latitude,
      this.longitude);

  get getCampusID => this.campusID;

  set setCampusID(campusID) => this.campusID = campusID;

  get getCampusName => this.campusName;

  set setCampusName(campusName) => this.campusName = campusName;

  get getAddress => this.address;

  set setAddress(address) => this.address = address;

  get getLatitude => this.latitude;

  set setLatitude(latitude) => this.latitude = latitude;

  get getLongitude => this.longitude;

  set setLongitude(longitude) => this.longitude = longitude;

  Campus.fromJson(Map<String, dynamic> json) {
    campusID = json['campus_id'];
    campusName = json['campus_name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}

Future<Campus> fetchCampus() async {
  Campus campus;
  final response = await http.get(Uri.http("103.154.100.159", "/api/campus/a"));
  if (response.statusCode == 200) {
    campus = Campus.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception("Faile to load resource");
  }
  return campus;
}
