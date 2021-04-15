import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hutech_go/components/custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:hutech_go/components/custom_radio_grouped_button/CustomButtons/CustomRadioButton2.dart';
import 'package:hutech_go/services/current_location.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/home.dart';
import 'package:location/location.dart';

class Booking extends StatefulWidget {
  static final routeName = "Booking";
  @override
  _Booking createState() => _Booking();
}

class _Booking extends State<Booking> {
  AnimationController animationController;
  bool multiple = true;
  GoogleMapController mapController;
  LocationData currLatLng = CurrentLocation().getLocation();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    CurrentLocation().initState();
    currLatLng = CurrentLocation().getLocation();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;
    final LatLng _center = LatLng(10.8409001, 106.7736572);
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: mQSize.height * 0.45),
                height: mQSize.height,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15,
                  ),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
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
                height: mQSize.height * 0.45,
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
                    Text("Chọn nhanh khu học"),
                    SizedBox(
                      height: 10,
                    ),
                    CustomRadioButton2(
                      elevation: 0,
                      width: 80,
                      absoluteZeroSpacing: false,
                      defaultSelected: null,
                      selectedColor: Theme.of(context).accentColor,
                      unSelectedColor: Theme.of(context).canvasColor,
                      buttonLables: ['A ', 'B ', 'D ', 'E ', 'U ', 'R '],
                      buttonValuesList: ['A', 'B', 'D', 'E', 'U', 'R'],
                      buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Colors.black,
                          textStyle: TextStyle(fontSize: 14)),
                      checkBoxButtonValues: (value) {
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: 10,
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
