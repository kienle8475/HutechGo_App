import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/components/custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:hutech_go/components/custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:line_icons/line_icons.dart';

class Rating extends StatefulWidget {
  static final routeName = "Rating";
  @override
  _Rating createState() => _Rating();
}

class _Rating extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;
    final formatCurrency = new NumberFormat("#,###");
    print(mQSize.height);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 40,
              width: mQSize.width,
            ),
            Column(
              children: [
                Container(
                  width: mQSize.width,
                  margin: new EdgeInsets.only(
                      left: mQSize.height * 0.02,
                      right: mQSize.height * 0.02,
                      top: mQSize.height * 0.08),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey[350],
                      ),
                    ],
                  ),
                  child: Card(
                    child: SizedBox(
                      height: mQSize.height * 0.58,
                      width: mQSize.width * 0.8,
                      child: Container(
                        margin: new EdgeInsets.only(
                            left: mQSize.height * 0.02,
                            right: mQSize.height * 0.02,
                            top: mQSize.height * 0.12),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16, bottom: 8),
                              child: Text(
                                "Đánh giá chuyến đi của bạn",
                                style: TextStyle(
                                  color: Constants.primary,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 12),
                              child: Text(
                                "Nhật Lâm".toUpperCase(),
                                style: TextStyle(
                                    color: Constants.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(
                              height: mQSize.height * 0.01,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomCheckBoxGroup(
                                    padding: mQSize.height * 0.017,
                                    elevation: 0,
                                    width: 160,
                                    height: 50,
                                    horizontal: true,
                                    absoluteZeroSpacing: false,
                                    defaultSelected: null,
                                    selectedColor: Constants.secondary,
                                    unSelectedColor: Colors.white,
                                    enableShape: true,
                                    space: 0.2,
                                    customShape: RoundedRectangleBorder(
                                      side:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                    buttonLables: [
                                      'Thân thiện ',
                                      'Chuyên nghiệp',
                                    ],
                                    buttonValuesList: [
                                      '1',
                                      '2',
                                    ],
                                    buttonTextStyle: ButtonTextStyle(
                                        selectedColor: Colors.white,
                                        unSelectedColor: Constants.secondary,
                                        textStyle: TextStyle(fontSize: 16)),
                                    checkBoxButtonValues: (value) {
                                      print(value);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: CustomCheckBoxGroup(
                                    padding: mQSize.height * 0.017,
                                    elevation: 0,
                                    width: 160,
                                    height: 50,
                                    horizontal: true,
                                    absoluteZeroSpacing: false,
                                    defaultSelected: null,
                                    selectedColor: Constants.secondary,
                                    unSelectedColor: Colors.white,
                                    enableShape: true,
                                    space: 0.2,
                                    customShape: RoundedRectangleBorder(
                                      side:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                    buttonLables: [
                                      'Tận tình ',
                                      'Đúng giờ ',
                                    ],
                                    buttonValuesList: [
                                      '3',
                                      '4',
                                    ],
                                    buttonTextStyle: ButtonTextStyle(
                                        selectedColor: Colors.white,
                                        unSelectedColor: Constants.secondary,
                                        textStyle: TextStyle(fontSize: 16)),
                                    checkBoxButtonValues: (value) {
                                      print(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 15, left: 15),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Chia sẻ cảm nhận của bạn nhé...",
                                  hintStyle: TextStyle(color: Constants.light),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                          color: Constants.secondary)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: mQSize.width,
                  margin: new EdgeInsets.only(
                      left: mQSize.height * 0.02,
                      right: mQSize.height * 0.02,
                      top: mQSize.height * 0.01),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey[350],
                      ),
                    ],
                  ),
                  child: Card(
                    child: SizedBox(
                      height: mQSize.height * 0.15,
                      width: mQSize.width * 0.8,
                      child: Container(
                        margin: new EdgeInsets.only(
                            left: mQSize.height * 0.02,
                            right: mQSize.height * 0.02,
                            top: mQSize.height * 0.02),
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                  right: 15,
                                  left: 15,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.adjust,
                                            color: Constants.primary,
                                            size: 24.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Text(
                                              "26/5 Phan Chu Trinh, Quận 9, HCMC",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 0, bottom: 0),
                                      child: Row(
                                        children: [
                                          Transform.rotate(
                                            angle: 180 * math.pi / 360,
                                            child: Icon(
                                              Icons.horizontal_rule,
                                              color: Colors.grey,
                                              size: 23.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.adjust,
                                            color: Constants.danger,
                                            size: 23.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Text(
                                              "Hutech A Campus - 475A Điện Biên Phủ",
                                              style: TextStyle(
                                                  color: Colors.grey[700]),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 0),
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
                                              formatCurrency.format(5000) +
                                                  " VNĐ ",
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
                      ),
                    ),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                        margin: new EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButtonFill(
                                color: Constants.primary,
                                text: "Cần trợ giúp",
                                height: 50,
                                width: mQSize.width * 0.43,
                                press: () {
                                  Navigator.pushNamed(
                                      context, Rating.routeName);
                                }),
                            RoundedButtonFill(
                                color: Constants.primary,
                                text: "Gửi đánh giá",
                                height: 50,
                                width: mQSize.width * 0.43,
                                press: () {
                                  Navigator.pushNamed(
                                      context, Rating.routeName);
                                }),
                          ],
                        ))
                  ],
                )
              ],
            ),
            Positioned(
                top: mQSize.height * 0.02,
                child: Align(
                  alignment: Alignment.center,
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
                        radius: 75,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/images/avatar.jpg"),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
