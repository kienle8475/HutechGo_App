import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hutech_go/models/student.dart';
import 'package:hutech_go/views/pages/activity.dart';
import 'package:hutech_go/views/pages/home_driver.dart';
import 'package:hutech_go/views/pages/home_passenger.dart';
import 'package:hutech_go/views/pages/messenger.dart';
import 'package:hutech_go/views/pages/user_setting.dart';
import 'package:line_icons/line_icons.dart';

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
    // Color.fromRGBO(203, 236, 252, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(204, 228, 180, 1),
    Color.fromRGBO(255, 255, 255, 1),
  ];

  final Future<String> getData = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

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
                  List<Widget> child;
                  if (loadSuccess) {
                    List<Widget> children = <Widget>[
                      student.isDriver ? HomeDriver() : HomePassenger(student),
                      Activity(),
                      Messenger(),
                      UserSetting(student)
                    ];
                    child = <Widget>[children[selectedIndex]];
                  } else {
                    child = const <Widget>[
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
                      children: child);
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
                  text: ' Trang chủ',
                  iconColor: Colors.grey,
                  textColor: Colors.lightBlue,
                  iconActiveColor: Colors.lightBlue,
                  backgroundColor: Colors.lightBlue.withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.clipboard,
                  text: ' Hoạt động',
                  iconColor: Colors.grey,
                  textColor: Colors.amber[600],
                  iconActiveColor: Colors.amber[600],
                  backgroundColor: Colors.amber[600].withOpacity(0.2),
                  // leading: selectedIndex == 1
                  //     ? null
                  //     : Badge(
                  //         badgeColor: Colors.amber,
                  //         elevation: 0,
                  //         position: BadgePosition.topEnd(top: -15, end: -15),
                  //         badgeContent: Text(
                  //           "",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //         child: Icon(
                  //           LineIcons.clipboard,
                  //           color: selectedIndex == 1
                  //               ? Colors.amber[600]
                  //               : Colors.grey,
                  //         ),
                  //       ),
                ),
                GButton(
                  icon: LineIcons.sms,
                  text: ' Tin nhắn',
                  iconColor: Colors.grey,
                  textColor: Colors.lightGreen,
                  iconActiveColor: Colors.lightGreen,
                  backgroundColor: Colors.lightGreen.withOpacity(0.2),
                ),
                GButton(
                  icon: LineIcons.user,
                  text: ' Tài khoản',
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
