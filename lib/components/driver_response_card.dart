import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:hutech_go/models/driver_response.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'custom_button.dart';

// ignore: must_be_immutable
class DriverResponseCard extends StatefulWidget {
  DriverResponse driverResponse;

  DriverResponseCard({
    Key key,
    this.driverResponse,
  }) : super(key: key);

  @override
  _DriverResponseCardState createState() => _DriverResponseCardState();
}

class _DriverResponseCardState extends State<DriverResponseCard> {
  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return Container(
      width: mQSize.width,
      margin: new EdgeInsets.only(
          left: mQSize.height * 0.02,
          right: mQSize.height * 0.02,
          top: mQSize.height * 0.01),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.grey[200],
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
                  animationDuration: 30000,
                  lineHeight: 8.0,
                  percent: 1,
                  progressColor: Colors.blue,
                  backgroundColor: Color(0xFFB8C7CB),
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
                          child: RatingBar.builder(
                            initialRating: 5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            ignoreGestures: true,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
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
                      children: [
                        Container(
                          child: Text(
                            "Trung Kiên",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          // Name
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "0.8 km - 5 phút",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ), // km - time
                              Text(
                                "đ 8,000",
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ), // price
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 240.0,
                          child: Text(
                            "Trường Đại học Công nghệ thành phố Hồ Chí Minh",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                            child: Row(
                          children: [
                            RoundedButtonBorder(
                              text: "Từ chối",
                              color: Colors.green,
                              height: 40,
                              width: mQSize.width * 0.25,
                              press: () {},
                            ),
                            RoundedButtonBorder(
                              text: "Đồng ý",
                              color: Colors.red,
                              height: 40,
                              width: mQSize.width * 0.25,
                              press: () {},
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
    );
  }
}
