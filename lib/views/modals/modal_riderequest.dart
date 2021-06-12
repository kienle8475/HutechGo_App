import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/components/driver_response_card.dart';

class RideRequestModal extends StatelessWidget {
  RideRequestModal({Key key}) : super(key: key);
  List<Widget> bodies = [];
  String requestId = "sampleRequest";
  bool status = false;
  bool isLoading = false;
  fetchDriver() async {
    var isValidDriver = false;
    await FirebaseFirestore.instance
        .collection('driverresponse')
        .where('requestId', isEqualTo: requestId)
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        isValidDriver = true;
      }
    });
    if (isValidDriver) {
      isLoading = false;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return Material(
        color: Colors.white,
        child: Container(
          height: mQSize.height * 0.95,
          width: mQSize.width,
          child: (this.isLoading)
              ? Column(
                  children: [
                    SizedBox(
                      height: mQSize.height * 0.8,
                      width: mQSize.width * 0.8,
                      child: Image.asset(
                        "assets/images/map_loading.gif",
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(height: mQSize.height * 0.01),
                    DriverResponseCard()
                  ],
                ),
        ));
  }
}
