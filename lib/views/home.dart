import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/models/campus.dart';
import 'package:hutech_go/models/student.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/passenger/booking.dart';
import 'package:hutech_go/views/welcome.dart';
import 'package:hutech_go/services/api_service.dart';

import 'dart:math' as math;

class Home extends StatefulWidget {
  static final routeName = "home";
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Student student;
  Campus campus;

  Future<Student> fetchStudentFromFireStore(String userId) async {
    FirebaseFirestore.instance
        .collection('students')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        student = Student.fromJson(documentSnapshot.data());
        print(student.lastName + " " + student.firstName);
      } else {
        throw Exception('Document does not exist on the database');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStudentFromFireStore(FirebaseAuth.instance.currentUser.uid);
  }

  final Future<String> getData = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.blue, Colors.purple],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 70.0));
  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Background(
            child: FutureBuilder<String>(
                future: getData,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Column(
                        children: [
                          Container(
                            padding:
                                new EdgeInsets.only(top: mQSize.height * 0.35),
                            child: Card(
                              child: SizedBox(
                                height: mQSize.height * 0.25,
                                width: mQSize.width * 0.9,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 120),
                                      child: Text(
                                        (student.lastName +
                                                " " +
                                                student.firstName)
                                            .toUpperCase(),
                                        style: TextStyle(
                                            // color: Constants.primary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            foreground: Paint()
                                              ..shader = linearGradient),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        student.studentId,
                                        style: TextStyle(
                                            // color: Constants.primary,
                                            fontSize: 18,
                                            foreground: Paint()
                                              ..shader = linearGradient),
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
                                    child: SizedBox(
                                      height: 20,
                                    ),
                                  ),
                                  // Container(
                                  //   margin: new EdgeInsets.symmetric(
                                  //       vertical: 10.0),
                                  //   child: RoundedButtonFill(
                                  //       color: Constants.primary,
                                  //       text: "Tìm xe",
                                  //       height: 50,
                                  //       width: mQSize.width * 0.9,
                                  //       press: () {
                                  //         // Navigator.pushNamed(context, Booking.routeName);
                                  //         Navigator.of(context).push(
                                  //             MaterialPageRoute(
                                  //                 builder: (context) =>
                                  //                     Booking(campus)));
                                  //       }),
                                  // ),
                                  // Container(
                                  //   child: RoundedButtonFill(
                                  //       color: Constants.danger,
                                  //       text: "Đăng xuất",
                                  //       height: 50,
                                  //       width: mQSize.width * 0.9,
                                  //       press: () {
                                  //         Navigator.pushNamedAndRemoveUntil(
                                  //             context,
                                  //             WelcomeScreen.routeName,
                                  //             (route) => false);
                                  //         FirebaseAuth.instance.signOut();
                                  //       }),
                                  // )
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: HomeMenuButton(
                                            color: Constants.primary,
                                            text: "Tìm xe",
                                            height: mQSize.width * 0.27,
                                            width: mQSize.width * 0.27,
                                            // icon: Image.asset(
                                            //     'assets/icons/location-pin.png'),
                                            press: () {
                                              // Navigator.pushNamed(context, Booking.routeName);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Booking(campus)));
                                            }),
                                      ),
                                      Container(
                                        child: HomeMenuButton(
                                            color: Constants.primary,
                                            text: "Chế độ tài xế",
                                            height: mQSize.width * 0.27,
                                            width: mQSize.width * 0.27,
                                            press: () {
                                              // Navigator.pushNamed(context, Booking.routeName);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Booking(campus)));
                                            }),
                                      ),
                                      Container(
                                        child: HomeMenuButton(
                                            color: Constants.primary,
                                            text: "Lịch sử",
                                            height: mQSize.width * 0.27,
                                            width: mQSize.width * 0.27,
                                            press: () {
                                              // Navigator.pushNamed(context, Booking.routeName);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Booking(campus)));
                                            }),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: HomeMenuButton(
                                            color: Constants.primary,
                                            text: "Cài đặt",
                                            height: mQSize.width * 0.27,
                                            width: mQSize.width * 0.27,
                                            press: () {
                                              // Navigator.pushNamed(context, Booking.routeName);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Booking(campus)));
                                            }),
                                      ),
                                      Container(
                                        child: HomeMenuButton(
                                            color: Constants.primary,
                                            text: "Trợ giúp",
                                            height: mQSize.width * 0.27,
                                            width: mQSize.width * 0.27,
                                            press: () {
                                              // Navigator.pushNamed(context, Booking.routeName);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Booking(campus)));
                                            }),
                                      ),
                                      Container(
                                        child: HomeMenuButton(
                                            color: Constants.primary,
                                            text: "Đăng xuất",
                                            height: mQSize.width * 0.27,
                                            width: mQSize.width * 0.27,
                                            press: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  WelcomeScreen.routeName,
                                                  (route) => false);
                                              FirebaseAuth.instance.signOut();
                                            }),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        top: mQSize.height * 0.28,
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
                                        HttpsAPI.apiUrl + student.profileImage),
                                  ))),
                        ),
                      ),
                    ];
                  } else {
                    children = const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 450),
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 496),
                        child: Text('Loading'),
                      )
                    ];
                  }

                  return Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: children);
                })));
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
                "assets/images/profile_wallpaper_3.png",
              ),
            ),
            child
          ],
        ));
  }
}
