import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/components/custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:hutech_go/components/custom_radio_grouped_button/CustomButtons/CustomRadioCampusButton.dart';
import 'package:hutech_go/models/campus.dart';
import 'package:hutech_go/models/directions.dart';
import 'package:hutech_go/services/cost_calculation.dart';
import 'package:hutech_go/services/current_location.dart';
import 'package:hutech_go/services/direction_resository.dart';
import 'package:hutech_go/services/googlemap_service.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/home.dart';
import 'package:hutech_go/views/modals/modal_riderequest.dart';

import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
  final Geolocator _geolocator = Geolocator();
  //
  String _startAddress = "Vị trí của bạn";
  Position _currentPosition;
  String _currentAddress = "";
  //
  String _destinationAddress = "";
  Position _destinationPosition;
  String _campusName = "Vui lòng chọn điểm đến của bạn";
  //
  Set<Marker> markers = {};
  //
  PolylinePoints _polylinePoints;
  List<LatLng> _polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  //
  Directions _directinfo;
  //
  double _price = 0;
  GoogleMapController _mapController;
  LatLng _initialCameraPosition = LatLng(10.8, 106.6);
  final formatCurrency = new NumberFormat("#,###");

  @override
  void initState() {
    super.initState();
    CurrentLocation().initState();
    getCurrentLocation();
    fetchCampusFromFireStore(widget.uniID);
  }

  // @override
  // void dispose() {
  //   _mapController.dispose();
  //   super.dispose();
  // }

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
        getAddress();
      });
    }).catchError((e) {
      print("ERROR - " + e);
    });
  }

  getAddress() async {
    try {
      List<Placemark> placemarks = await _geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.name}, ${place.thoroughfare}, ${place.subAdministrativeArea}";
        _startAddress = _currentAddress;
        print(_currentAddress);
      });
    } catch (e) {
      print("ERROR - " + e);
    }
  }

  createPolylines(Position start, Position destination) async {
    _polylinePoints = PolylinePoints();
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
        GMService.API_KEY,
        PointLatLng(start.latitude, start.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);
    print(result.errorMessage);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId polylineId = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: polylineId,
        color: Colors.blue,
        points: _polylineCoordinates,
        width: 5);
    polylines[polylineId] = polyline;
    print(polylines.length);
  }

  Future<bool> addMarker() async {
    try {
      Position startCoordinate = _currentPosition;
      Position destinationCoordinate = _destinationPosition;
      Marker startMarker = Marker(
          markerId: MarkerId('$startCoordinate'),
          position: LatLng(startCoordinate.latitude, startCoordinate.longitude),
          infoWindow: InfoWindow(title: "Start", snippet: _startAddress),
          icon: BitmapDescriptor.defaultMarker);
      Marker destinationMarker = Marker(
          markerId: MarkerId('$destinationCoordinate'),
          position: LatLng(
              destinationCoordinate.latitude, destinationCoordinate.longitude),
          infoWindow:
              InfoWindow(title: "Destination", snippet: _destinationAddress),
          icon: BitmapDescriptor.defaultMarker);
      markers.add(startMarker);
      markers.add(destinationMarker);
      print('START COORDINATE: $startCoordinate');
      print('DESTINATION COORDINATE: $destinationCoordinate');

      Position _northeastCoordinate;
      Position _southwestCoordinate;

      double miny = (startCoordinate.latitude <= destinationCoordinate.latitude)
          ? startCoordinate.latitude
          : destinationCoordinate.latitude;
      double minx =
          (startCoordinate.longitude <= destinationCoordinate.longitude)
              ? startCoordinate.longitude
              : destinationCoordinate.longitude;
      double maxy = (startCoordinate.latitude <= destinationCoordinate.latitude)
          ? destinationCoordinate.latitude
          : startCoordinate.latitude;
      double maxx =
          (startCoordinate.longitude <= destinationCoordinate.longitude)
              ? destinationCoordinate.longitude
              : startCoordinate.longitude;

      _southwestCoordinate = Position(latitude: miny, longitude: minx);
      _northeastCoordinate = Position(latitude: maxy, longitude: maxx);
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(_southwestCoordinate.latitude,
                  _southwestCoordinate.longitude),
              northeast: LatLng(_northeastCoordinate.latitude,
                  _northeastCoordinate.longitude)),
          100.0));

      return true;
    } catch (e) {
      print("ERROR - " + e.toString());
    }
    return false;
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
                      initialCameraPosition:
                          CameraPosition(target: _initialCameraPosition),
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                      markers:
                          markers != null ? Set<Marker>.from(markers) : null,
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      // polylines: Set<Polyline>.of(polylines.values),
                      polylines: {
                        if (_directinfo != null)
                          Polyline(
                              polylineId: PolylineId('overview_polyline'),
                              color: Colors.blue,
                              width: 4,
                              points: _directinfo.polylinePoint
                                  .map((e) => LatLng(e.latitude, e.longitude))
                                  .toList()),
                      },
                    ),
                  ),
                  if (_directinfo != null)
                    Positioned(
                      bottom: 400,
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0)
                            ]),
                        child: Text(
                            '${_directinfo.totalDistance}, thời gian di chuyển ước tính: ${_directinfo.totalDuration}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            )),
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
                              setState(() async {
                                _campusName = campuses[value].campusName;

                                _destinationPosition = Position(
                                    latitude: campuses[value].location.latitude,
                                    longitude:
                                        campuses[value].location.longitude);
                                if (markers.isNotEmpty) markers.clear();
                                if (polylines.isNotEmpty) polylines.clear();
                                if (_polylineCoordinates.isNotEmpty)
                                  _polylineCoordinates.clear();
                                addMarker();
                                final _directions = await DirectionRepository()
                                    .getDirections(
                                        origin: LatLng(
                                            _currentPosition.latitude,
                                            _currentPosition.longitude),
                                        destination: LatLng(
                                            _destinationPosition.latitude,
                                            _destinationPosition.longitude));
                                setState(() {
                                  _directinfo = _directions;
                                  _price = costCalculation(
                                      _directinfo.distanceValue);
                                });
                              });
                              print(_campusName);
                            } else {
                              setState(() {
                                _campusName = "Vui lòng chọn điểm đến của bạn";
                                markers.clear();
                                polylines.clear();
                                _polylineCoordinates.clear();
                                _price = 0;
                                _directinfo = null;
                                getCurrentLocation();
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
                                          EdgeInsets.only(top: 12, bottom: 12),
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
                                                  _startAddress,
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
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
                                          EdgeInsets.only(top: 12, bottom: 12),
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
                                          EdgeInsets.only(top: 12, bottom: 12),
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
                                              _price != 0
                                                  ? formatCurrency
                                                          .format(_price) +
                                                      " VNĐ (Giá tiền ước tính)"
                                                  : "",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedButtonBorder(
                              text: "Hẹn giờ",
                              color: Constants.primary,
                              height: 50,
                              width: mQSize.width * 0.25,
                              press: () {},
                            ),
                            RoundedButtonFill(
                              text: "Yêu cầu chuyến đi",
                              color: Constants.secondary,
                              height: 50,
                              width: mQSize.width * 0.58,
                              press: () {
                                showBarModalBottomSheet(
                                    // enableDrag: false,
                                    expand: true,
                                    // isDismissible: false,
                                    context: context,
                                    builder: (context) => RideRquestrModal());
                              },
                            ),
                          ],
                        )
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
