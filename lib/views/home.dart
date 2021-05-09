import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/models/student.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/passenger/booking.dart';
import 'package:line_icons/line_icons.dart';
import 'package:hutech_go/services/api_service.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  static final routeName = "home";
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Student student;
  bool loadSuccess = false;
  int selectedIndex = 0;
  Size mQSize;

  final List<Color> scaffoldBackgroundColor = [
    Color.fromRGBO(203, 236, 252, 1),
    Color.fromRGBO(204, 228, 180, 1),
    Color.fromRGBO(252, 244, 204, 1),
    Color.fromRGBO(203, 236, 252, 1)
  ];

  final Future<String> getData = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.blue, Colors.purple],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 70.0));
  final List<Widget> children = [];

  @override
  void initState() {
    super.initState();
    fetchStudentFromFireStore(FirebaseAuth.instance.currentUser.uid);
  }

  Future<void> fetchStudentFromFireStore(String userId) async {
    FirebaseFirestore.instance
        .collection('students')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          loadSuccess = true;
          student = Student.fromJson(documentSnapshot.data());
        });
      } else {
        throw Exception('Document does not exist on the database');
      }
    });
  }

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    mQSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: scaffoldBackgroundColor[selectedIndex],
        body: Container(
            alignment: Alignment.center,
            child: FutureBuilder<void>(
                future: fetchStudentFromFireStore(
                    FirebaseAuth.instance.currentUser.uid),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  List<Widget> children;
                  if (loadSuccess) {
                    children = <Widget>[
                      Column(
                        children: [
                          Container(
                            padding:
                                new EdgeInsets.only(top: mQSize.height * 0.08),
                          ),
                          Container(
                            // padding:
                            //     new EdgeInsets.only(top: mQSize.height * 0.15),
                            child: Card(
                              child: SizedBox(
                                height: mQSize.height * 0.29,
                                width: mQSize.width * 0.9,
                                child: Column(
                                  children: [
                                    Container(
                                      height: mQSize.height * 0.1,
                                      child: Image.network(
                                          "https://www.hutech.edu.vn/imgnews/homepage/stories/hinh34/logo%20CMYK-01.png"),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 160,
                                          width: 160,
                                          child: Image.network(HttpsAPI.apiUrl +
                                              student.profileImage),
                                        ),
                                        Container(
                                          height: 140,
                                          width: mQSize.width - 225,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 0),
                                                        child: Text(
                                                          (student.lastName +
                                                                  " " +
                                                                  student
                                                                      .firstName)
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              // color: Constants.primary,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              foreground: Paint()
                                                                ..shader =
                                                                    linearGradient),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10),
                                                        child: Text(
                                                          (student.birthday)
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              // color: Constants.primary,
                                                              fontSize: 18,
                                                              foreground: Paint()
                                                                ..shader =
                                                                    linearGradient),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10),
                                                        child: Text(
                                                          (student.studentId +
                                                                  " - " +
                                                                  student
                                                                      .schoolClass)
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              // color: Constants.primary,
                                                              fontSize: 18,
                                                              foreground: Paint()
                                                                ..shader =
                                                                    linearGradient),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: BarCodeImage(
                                                            params:
                                                                Code39BarCodeParams(
                                                              student.studentId,
                                                              lineWidth:
                                                                  1.4, // width for a single black/white bar (default: 2.0)
                                                              barHeight:
                                                                  35.0, // height for the entire widget (default: 100.0)
                                                              withText: false,
                                                              // Render with text label or not (default: false)
                                                            ),
                                                            onError: (error) {
                                                              // Error handler
                                                              print(
                                                                  'error = $error');
                                                            },
                                                          )),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              shadowColor: Colors.white,
                              child: SizedBox(
                                height: mQSize.height * 0.50,
                                width: mQSize.width * 0.9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RoundedButtonFill(
                                      text: "TÌM XE",
                                      color: Constants.primary,
                                      height: 50,
                                      width: mQSize.width * 0.8,
                                      press: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Booking(
                                                    student.university)));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ];
                  } else {
                    children = const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 300),
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 366),
                        child: Text('Loading'),
                      )
                    ];
                  }

                  return Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: children);
                })),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))
          ]),
          child: SafeArea(
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 0,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              activeColor: Colors.grey,
              iconSize: 24,
              tabBorderRadius: 0,
              selectedIndex: selectedIndex,
              onTabChange: onTabTapped,
              tabs: [
                GButton(
                  icon: LineIcons.compass,
                  text: 'Trang chủ',
                  iconColor: Colors.grey,
                  textColor: Colors.lightBlue,
                  iconActiveColor: Colors.lightBlue,
                  backgroundColor: Colors.lightBlue.withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.clipboard,
                  text: 'Hoạt động',
                  iconColor: Colors.grey,
                  textColor: Colors.lightGreen,
                  iconActiveColor: Colors.lightGreen,
                  backgroundColor: Colors.lightGreen.withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.sms,
                  text: 'Tin nhắn',
                  iconColor: Colors.grey,
                  textColor: Colors.amber[600],
                  iconActiveColor: Colors.amber[600],
                  backgroundColor: Colors.amber[600].withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Tài khoản',
                  iconColor: Colors.grey,
                  textColor: Colors.lightBlue,
                  iconActiveColor: Colors.lightBlue,
                  backgroundColor: Colors.lightBlue.withOpacity(0.2),
                )
              ],
            ),
          ),
        ));
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
