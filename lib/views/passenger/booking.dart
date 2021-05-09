import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hutech_go/components/custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:hutech_go/components/custom_radio_grouped_button/CustomButtons/CustomRadioCampusButton.dart';
import 'package:hutech_go/models/campus.dart';
import 'package:hutech_go/services/cost_calculation.dart';
import 'package:hutech_go/services/current_location.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/home.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
// import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

class Booking extends StatefulWidget {
  static final routeName = "Booking";
  String uniID;
  Booking(this.uniID);
  @override
  _Booking createState() => _Booking();
}

class _Booking extends State<Booking> {
  bool multiple = true;
  List<Campus> campuses = [];
  // Location _location = new Location();
  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;

  String _campusName = "Vui lòng chọn điểm đến của bạn";
  String _yourLocation = "Vị trí của bạn";
  double _price = 0;
  GoogleMapController _mapController;
  LatLng _initialCameraPosition = LatLng(10.8, 106.6);
  final formatCurrency = new NumberFormat("#,###");
  // void _onMapCreated(GoogleMapController controller) {
  //   _mapController = controller;
  //   _location.onLocationChanged.listen((LocationData currentLocation) {
  //     _mapController.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //             target:
  //                 LatLng(currentLocation.latitude, currentLocation.longitude),
  //             zoom: 15)));
  //   });
  // }

  @override
  void initState() {
    super.initState();
    CurrentLocation().initState();
    getCurrentLocation();
    fetchCampusFromFireStore(widget.uniID);
  }

  getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 15)));
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> fetchCampusFromFireStore(String uniID) async {
    FirebaseFirestore.instance
        .collection('universities')
        .doc(uniID)
        .collection('campuses')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          querySnapshot.docs.forEach((doc) {
            campuses.add(new Campus(
                doc.id, doc['campus_name'], doc['address'], doc['location']));
          });
        });
      } else {
        throw Exception('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: mQSize.height * 0.35),
                    height: mQSize.height,
                    child: GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      initialCameraPosition:
                          CameraPosition(target: _initialCameraPosition),
                    ),
                  ),
                  Positioned(
                      top: 40.0,
                      left: 20.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.grey[350],
                                spreadRadius: 2)
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Constants.primary,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, Home.routeName);
                              }),
                        ),
                      )),
                  Container(
                    height: mQSize.height * 0.35,
                    width: mQSize.width,
                    decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.9),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3))
                        ],
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(0.0),
                            topRight: const Radius.circular(0.0))),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomRadioCampusButton(
                          elevation: 0,
                          width: 80,
                          height: 40,
                          absoluteZeroSpacing: false,
                          defaultSelected: null,
                          selectedColor: Theme.of(context).accentColor,
                          unSelectedColor: Theme.of(context).canvasColor,
                          campuses: campuses,
                          buttonTextStyle: ButtonTextStyle(
                              selectedColor: Colors.white,
                              unSelectedColor: Constants.primary,
                              textStyle: TextStyle(fontSize: 14)),
                          checkBoxButtonValues: (value) {
                            if (value != null) {
                              setState(() {
                                _campusName = campuses[value].campusName;
                                _price = costCalculation(value.toDouble() + 1);
                              });
                              print(_campusName);
                            } else {
                              setState(() {
                                _campusName = "Vui lòng chọn điểm đến của bạn";
                                _price = 0;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                  right: 15,
                                  left: 15,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.adjust,
                                            color: Constants.primary,
                                            size: 24.0,
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Container(
                                                child: Text(
                                                  _yourLocation,
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 18),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.adjust,
                                            color: Constants.danger,
                                            size: 24.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Text(
                                              _campusName,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      child: Row(
                                        children: [
                                          Icon(
                                            LineIcons.moneyBill,
                                            color: Constants.secondary,
                                            size: 24.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Text(
                                              formatCurrency.format(_price) +
                                                  " VNĐ (Giá tiền ước tính)",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      child: Row(
                                        children: [],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
