import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/components/driver_response_card.dart';
import 'package:hutech_go/models/driver_response.dart';
import 'package:hutech_go/views/modals/modal_driverinfomation.dart';

class RideRequestModal extends StatefulWidget {
  RideRequestModal({Key key}) : super(key: key);
  @override
  _RideRequestModal createState() => _RideRequestModal();
}

class _RideRequestModal extends State<RideRequestModal> {
  List<Widget> bodies = [];
  bool status = false;
  bool isLoading = false;
  final Stream<QuerySnapshot> fetchDriver = FirebaseFirestore.instance
      .collection('requests_responses')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('responses')
      .where(
        'status',
        isEqualTo: true,
      )
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: fetchDriver,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(
              color: Colors.white,
              child: Container(
                  height: mQSize.height * 0.9,
                  width: mQSize.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: mQSize.height * 0.85,
                        width: mQSize.width * 0.8,
                        child: Image.asset(
                          "assets/images/map_loading.gif",
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: RoundedButtonFill(
                          text: "Hủy đặt xe",
                          color: Colors.red,
                          height: 50,
                          width: mQSize.width * 0.9,
                          press: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop("Discard");
                          },
                        ),
                      )
                    ],
                  )));
        }
        return Material(
            color: Colors.white,
            child: Container(
                height: mQSize.height * 0.9,
                width: mQSize.width,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[100], width: 2))),
                        child: ConstrainedBox(
                            constraints: BoxConstraints.expand(
                              height: mQSize.height * 0.82,
                            ),
                            child: ListView(
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot document) {
                                log(snapshot.data.size.toString());
                                Map<String, dynamic> response = document.data();
                                if (snapshot.data.size != 0) {
                                  return new DriverResponseCard(
                                    isVisible: true,
                                    timeleft: 20000,
                                    driverResponse: DriverResponse(
                                        studentName: response['student_name'],
                                        price: response['price'],
                                        timeArrival: response['time_arrival'],
                                        distance: response['distance'],
                                        universityName:
                                            response['university_name'],
                                        reponseId: document.id),
                                    press: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop("Discard");
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          barrierColor: Colors.transparent,
                                          isScrollControlled: true,
                                          isDismissible: false,
                                          enableDrag: true,
                                          context: context,
                                          builder: (context) {
                                            return DraggableScrollableSheet(
                                                initialChildSize:
                                                    0.75, //set this as you want
                                                maxChildSize:
                                                    0.75, //set this as you want
                                                minChildSize:
                                                    0.75, //set this as you want
                                                expand: true,
                                                builder: (context,
                                                    scrollController) {
                                                  return DriverInfomationModal(); //whatever you're returning, does not have to be a Container
                                                });
                                          });
                                    },
                                  );
                                } else {
                                  return Container(
                                    child: SizedBox(
                                      height: mQSize.height * 0.85,
                                      width: mQSize.width * 0.8,
                                      child: Image.asset(
                                        "assets/images/map_loading.gif",
                                      ),
                                    ),
                                  );
                                }
                              }).toList(),
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: RoundedButtonGradient(
                          text: "Hủy đặt xe",
                          color: Colors.red,
                          height: 50,
                          width: mQSize.width * 0.9,
                          press: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop("Discard");
                          },
                        ),
                      )
                    ],
                  ),
                )));
      },
    );
  }
}
