import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/passenger/booking.dart';
import 'dart:math' as math;

import 'login.dart';

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
                      height: mQSize.height * 0.25,
                      width: mQSize.width * 0.8,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 120),
                            child: Text(
                              "Trần Thị Anh Thư".toUpperCase(),
                              style: TextStyle(
                                  color: Constants.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              FirebaseAuth.instance.currentUser.uid,
                              style: TextStyle(
                                color: Constants.primary,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: new EdgeInsets.symmetric(vertical: 10.0),
                          child: RoundedButtonFill(
                              color: Constants.primary,
                              text: "Tìm xe",
                              height: 50,
                              width: mQSize.width * 0.8,
                              press: () {
                                Navigator.pushNamed(context, Booking.routeName);
                              }),
                        ),
                        Container(
                          child: RoundedButtonFill(
                              color: Constants.danger,
                              text: "Đăng xuất",
                              height: 50,
                              width: mQSize.width * 0.8,
                              press: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Login.routeName, (route) => false);
                                FirebaseAuth.instance.signOut();
                              }),
                        )
                      ],
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
                    child: Transform.rotate(
                        angle: 180 * math.pi / 85,
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "http://103.154.100.159/media/images/students/profiles/1711060326/fc5fbb4b-1399-4051-9e4b-4c30dd2616c0.jpg"),
                        ))),
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
