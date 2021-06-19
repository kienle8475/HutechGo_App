import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hutech_go/models/driver_response.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'custom_button.dart';

// ignore: must_be_immutable
class DriverResponseCard extends StatefulWidget {
  DriverResponse driverResponse;
  bool isVisible;
  int timeleft;
  Function press;
  DriverResponseCard(
      {Key key, this.timeleft, this.driverResponse, this.press, this.isVisible})
      : super(key: key);

  @override
  _DriverResponseCardState createState() => _DriverResponseCardState();
}

class _DriverResponseCardState extends State<DriverResponseCard> {
  CollectionReference reponseReferance = FirebaseFirestore.instance
      .collection('requests_responses')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('responses');
  Future<void> updateResponseStatus() {
    return reponseReferance
        .doc(widget.driverResponse.reponseId)
        .update({'status': false});
  }

  final formatCurrency = new NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return Visibility(
        maintainState: true,
        maintainAnimation: true,
        visible: widget.isVisible,
        child: Container(
          width: mQSize.width,
          margin: new EdgeInsets.only(
              left: mQSize.height * 0.02,
              right: mQSize.height * 0.02,
              top: mQSize.height * 0.01),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.grey[100],
              ),
            ],
          ),
          child: Card(
            child: SizedBox(
              height: mQSize.height * 0.2,
              width: mQSize.width * 0.8,
              child: Container(
                  child: Column(
                children: [
                  Container(
                    margin: new EdgeInsets.all(12),
                    child: LinearPercentIndicator(
                      width: mQSize.width * 0.85,
                      animation: true,
                      animationDuration: widget.timeleft,
                      lineHeight: 6.0,
                      percent: 1,
                      progressColor: Color.fromRGBO(21, 179, 255, 1),
                      backgroundColor: Color(0xFFB8C7CB),
                      onAnimationEnd: () {
                        setState(() {
                          widget.isVisible = false;
                          // updateResponseStatus();
                        });
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: new EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: mQSize.width * 0.25,
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
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  // backgroundImage: AssetImage("assets/images/avatar.jpg"),
                                )
                                // Profile
                                ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: RatingBar.builder(
                                initialRating: 5,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20,
                                ignoreGestures: true,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              // Rating
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(widget.driverResponse.studentName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.grey[700])),
                              // Name
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "${widget.driverResponse.distance.toStringAsFixed(0)} km - ${widget.driverResponse.timeArrival.toStringAsFixed(0)} phút",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 25),
                                    child: Text(
                                      " đ ${formatCurrency.format(widget.driverResponse.price)}",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Color.fromRGBO(21, 179, 255, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ), // price
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 260.0,
                                child: Text(
                                  "${widget.driverResponse.universityName}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                child: Row(
                              children: [
                                RoundedButtonBorder(
                                  text: "Từ chối",
                                  color: Colors.grey,
                                  height: 40,
                                  width: mQSize.width * 0.25,
                                  press: () {
                                    setState(() {
                                      updateResponseStatus();
                                      widget.isVisible = false;
                                      log("Update ${widget.driverResponse.reponseId}");
                                    });
                                  },
                                ),
                                RoundedButtonBorder(
                                  text: "Đồng ý",
                                  color: Color.fromRGBO(21, 179, 255, 1),
                                  height: 40,
                                  width: mQSize.width * 0.25,
                                  press: widget.press,
                                )
                              ],
                            ))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )),
            ),
          ),
        ));
  }
}
