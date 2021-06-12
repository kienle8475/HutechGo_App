import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hutech_go/models/student.dart';

class DriverResponse {
  String reponseId;
  String image;
  bool status;
  double distance;
  double time;
  double price;
  String university;
  String studentName;
  String imageProfile;
  DriverResponse({
    this.reponseId,
    this.image,
    this.status,
    this.distance,
    this.time,
    this.price,
    this.university,
    this.studentName,
    this.imageProfile,
  });
  DriverResponse.fromJson(Map<String, dynamic> json) {
    reponseId = json[''];
    image = json[''];
    status = json[''];
    distance = json[''];
    time = json[''];
    price = json[''];
    university = json[''];
    studentName = json[''];
    imageProfile = json[''];
  }
  DriverResponse copyWith({
    String reponseId,
    String image,
    bool status,
    double distance,
    double time,
    double price,
    String university,
    String studentName,
    String imageProfile,
  }) {
    return DriverResponse(
      reponseId: reponseId ?? this.reponseId,
      image: image ?? this.image,
      status: status ?? this.status,
      distance: distance ?? this.distance,
      time: time ?? this.time,
      price: price ?? this.price,
      university: university ?? this.university,
      studentName: studentName ?? this.studentName,
      imageProfile: imageProfile ?? this.imageProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reponseId': reponseId,
      'image': image,
      'status': status,
      'distance': distance,
      'time': time,
      'price': price,
      'university': university,
      'studentName': studentName,
      'imageProfile': imageProfile,
    };
  }

  factory DriverResponse.fromMap(Map<String, dynamic> map) {
    return DriverResponse(
      reponseId: map['reponseId'],
      image: map['image'],
      status: map['status'],
      distance: map['distance'],
      time: map['time'],
      price: map['price'],
      university: map['university'],
      studentName: map['studentName'],
      imageProfile: map['imageProfile'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory DriverResponse.fromJson(String source) =>
  //     DriverResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DriverResponse(reponseId: $reponseId, image: $image, status: $status, distance: $distance, time: $time, price: $price, university: $university, studentName: $studentName, imageProfile: $imageProfile)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DriverResponse &&
        other.reponseId == reponseId &&
        other.image == image &&
        other.status == status &&
        other.distance == distance &&
        other.time == time &&
        other.price == price &&
        other.university == university &&
        other.studentName == studentName &&
        other.imageProfile == imageProfile;
  }

  @override
  int get hashCode {
    return reponseId.hashCode ^
        image.hashCode ^
        status.hashCode ^
        distance.hashCode ^
        time.hashCode ^
        price.hashCode ^
        university.hashCode ^
        studentName.hashCode ^
        imageProfile.hashCode;
  }
}
