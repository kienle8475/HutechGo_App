import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/passenger/booking.dart';
import 'package:hutech_go/views/passenger/rating.dart';

class Home extends StatefulWidget {
  static final routeName = "home";
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              children: [
                Container(
                  padding: new EdgeInsets.only(top: mQSize.height * 0.15),
                  child: Card(
                    child: SizedBox(
                      height: mQSize.height * 0.2,
                      width: mQSize.width * 0.8,
                    ),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      margin: new EdgeInsets.symmetric(vertical: 20.0),
                      child: RoundedButtonFill(
                          color: Constants.primary,
                          text: "Tìm xe",
                          height: 50,
                          width: mQSize.width * 0.8,
                          press: () {
                            Navigator.pushNamed(context, Rating.routeName);
                          }),
                    )
                  ],
                )
              ],
            ),
            Positioned(
              top: mQSize.height * 0.1,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return Container(
        height: mQSize.height,
        width: mQSize.width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/images/profile_wallpaper_2.jpg",
              ),
            ),
            child
          ],
        ));
  }
}
