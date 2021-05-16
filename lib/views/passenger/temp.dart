import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hutech_go/models/campus.dart';
import 'package:hutech_go/models/student.dart';
import 'package:line_icons/line_icons.dart';
import 'package:hutech_go/services/api_service.dart';

class Home extends StatefulWidget {
  static final routeName = "home";
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Student student;
  Campus campus;
  bool loadSuccess = false;
  int selectedIndex = 0;

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
        backgroundColor: Colors.lightBlue[100],
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
                                new EdgeInsets.only(top: mQSize.height * 0.15),
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
                          Container(
                            child: Card(
                              shadowColor: Colors.white,
                              child: SizedBox(
                                height: mQSize.height * 0.49,
                                width: mQSize.width * 0.9,
                                child: Column(
                                  children: [],
                                ),
                              ),
                            ),
                          ),
                          //Stack
                          // Stack(
                          //   alignment: AlignmentDirectional.bottomCenter,
                          //   children: [
                          //     Column(
                          //       children: [
                          //         Container(
                          //           child: SizedBox(
                          //             height: 20,
                          //           ),
                          //         ),
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Container(
                          //               child: HomeMenuButton(
                          //                   color: Constants.primary,
                          //                   text: "Tìm xe",
                          //                   height: mQSize.width * 0.27,
                          //                   width: mQSize.width * 0.27,
                          //                   icon: Image.asset(
                          //                       'assets/icons/pin.png'),
                          //                   press: () {
                          //                     // Navigator.pushNamed(context, Booking.routeName);
                          //                     Navigator.of(context).push(
                          //                         MaterialPageRoute(
                          //                             builder: (context) =>
                          //                                 Booking(student
                          //                                     .university)));
                          //                   }),
                          //             ),
                          //             Container(
                          //               child: HomeMenuButton(
                          //                   color: Constants.primary,
                          //                   text: "Lịch sử",
                          //                   height: mQSize.width * 0.27,
                          //                   width: mQSize.width * 0.27,
                          //                   icon: Image.asset(
                          //                       'assets/icons/wall-clock.png'),
                          //                   press: () {
                          //                     // Navigator.pushNamed(context, Booking.routeName);
                          //                     Navigator.of(context).push(
                          //                         MaterialPageRoute(
                          //                             builder: (context) =>
                          //                                 Booking(student
                          //                                     .university)));
                          //                   }),
                          //             ),
                          //             Container(
                          //               child: HomeMenuButton(
                          //                   color: Constants.primary,
                          //                   text: "Chế độ tài xế",
                          //                   height: mQSize.width * 0.27,
                          //                   width: mQSize.width * 0.27,
                          //                   icon: Image.asset(
                          //                       'assets/icons/left-and-right-arrows.png'),
                          //                   press: () {
                          //                     // Navigator.pushNamed(context, Booking.routeName);
                          //                     Navigator.of(context).push(
                          //                         MaterialPageRoute(
                          //                             builder: (context) =>
                          //                                 Booking(student
                          //                                     .university)));
                          //                   }),
                          //             ),
                          //           ],
                          //         ),
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Container(
                          //               child: HomeMenuButton(
                          //                   color: Constants.primary,
                          //                   text: "Cài đặt",
                          //                   height: mQSize.width * 0.27,
                          //                   width: mQSize.width * 0.27,
                          //                   icon: Image.asset(
                          //                       'assets/icons/settings.png'),
                          //                   press: () {
                          //                     // Navigator.pushNamed(context, Booking.routeName);
                          //                     Navigator.of(context).push(
                          //                         MaterialPageRoute(
                          //                             builder: (context) =>
                          //                                 Booking(student
                          //                                     .university)));
                          //                   }),
                          //             ),
                          //             Container(
                          //               child: HomeMenuButton(
                          //                   color: Constants.primary,
                          //                   text: "Trợ giúp",
                          //                   height: mQSize.width * 0.27,
                          //                   width: mQSize.width * 0.27,
                          //                   icon: Image.asset(
                          //                       'assets/icons/questions.png'),
                          //                   press: () {
                          //                     // Navigator.pushNamed(context, Booking.routeName);
                          //                     Navigator.of(context).push(
                          //                         MaterialPageRoute(
                          //                             builder: (context) =>
                          //                                 Booking(student
                          //                                     .university)));
                          //                   }),
                          //             ),
                          //             Container(
                          //               child: HomeMenuButton(
                          //                   color: Constants.primary,
                          //                   text: "Đăng xuất",
                          //                   height: mQSize.width * 0.27,
                          //                   width: mQSize.width * 0.27,
                          //                   icon: Image.asset(
                          //                       'assets/icons/log-in.png'),
                          //                   press: () {
                          //                     Navigator.pushNamedAndRemoveUntil(
                          //                         context,
                          //                         WelcomeScreen.routeName,
                          //                         (route) => false);
                          //                     FirebaseAuth.instance.signOut();
                          //                   }),
                          //             ),
                          //           ],
                          //         )
                          //       ],
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                      Positioned(
                        top: mQSize.height * 0.08,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 0,
                                    color: Colors.white,
                                    spreadRadius: 2)
                              ],
                            ),
                            child: Container(
                              height: 140,
                              width: 140,
                              child: Image.network(
                                  HttpsAPI.apiUrl + student.profileImage),
                            ),
                            // child: Transform.rotate(
                            //       angle: 180 * math.pi / 85,
                            //       child: CircleAvatar(
                            //         radius: 75,
                            //         backgroundColor: Colors.white,
                            //         backgroundImage: NetworkImage(
                            //             HttpsAPI.apiUrl + student.profileImage),
                            //       ))
                          ),
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
                  textColor: Colors.pink,
                  iconActiveColor: Colors.pink,
                  backgroundColor: Colors.pink.withOpacity(0.2),
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
