import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/components/setting_ui_component/settings_ui.dart';
import 'package:hutech_go/models/student.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/general/welcome.dart';
import 'package:material_dialogs/material_dialogs.dart';

// ignore: must_be_immutable
class UserSetting extends StatelessWidget {
  Student student;
  UserSetting(this.student);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Header(
      student: student,
      child: null,
    ));
  }
}

// ignore: must_be_immutable
class Header extends StatelessWidget {
  Student student;
  final Widget child;
  CollectionReference fbstudent =
      FirebaseFirestore.instance.collection('students');
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Constants.primary, Colors.purple],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 70.0));

  Header({Key key, @required this.child, @required this.student})
      : super(key: key);

  Future<void> changeMode() {
    return fbstudent
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'is_driver': !student.isDriver})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
          height: mQSize.height,
          width: mQSize.width,
          child: Column(
            // alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                height: mQSize.height * 0.15,
                width: mQSize.width,
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Transform.rotate(
                          angle: 180 * math.pi / 85,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(student.profileImage),
                          )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 5),
                          child: Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              (student.studentName).toUpperCase(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  // color: Constants.primary,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()..shader = linearGradient),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            child: Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    child: Row(
                                      children: [
                                        Text("Thay đổi thông tin  ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              // color: Constants.primary,
                                              fontSize: 16,
                                              color: Colors.grey,
                                            )),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Colors.grey,
                                        )
                                      ],
                                    )),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      SettingsList(
                        shrinkWrap: true,
                        backgroundColor: Colors.white,
                        contentPadding: EdgeInsets.only(left: 10, right: 10),
                        sections: [
                          SettingsSection(
                            title: "Cài đặt",
                            titleTextStyle: TextStyle(fontSize: 15),
                            titlePadding: EdgeInsets.only(left: 15),
                            tiles: [
                              SettingsTile(
                                title: "Thông báo",
                                titleTextStyle: TextStyle(fontSize: 14),
                                leading: Icon(Icons.notifications,
                                    color: Colors.yellow[600]),
                                onPressed: (BuildContext context) {},
                              ),
                              SettingsTile(
                                title: "Ngôn ngữ",
                                titleTextStyle: TextStyle(fontSize: 14),
                                leading:
                                    Icon(Icons.language, color: Colors.red),
                                onPressed: (BuildContext context) {},
                              ),
                            ],
                          ),
                          SettingsSection(
                            title: "Thông tin chung",
                            titleTextStyle: TextStyle(fontSize: 15),
                            titlePadding: EdgeInsets.only(top: 5, left: 15),
                            tiles: [
                              SettingsTile(
                                title: "Chính sách",
                                titleTextStyle: TextStyle(fontSize: 14),
                                leading: Icon(Icons.security,
                                    color: Constants.primary),
                                onPressed: (BuildContext context) {},
                              ),
                              SettingsTile(
                                title: "Điều khoản dịch vụ",
                                titleTextStyle: TextStyle(fontSize: 14),
                                leading: Icon(Icons.library_books,
                                    color: Constants.primary),
                                onPressed: (BuildContext context) {},
                              ),
                              SettingsTile(
                                title: "Trợ giúp",
                                titleTextStyle: TextStyle(fontSize: 14),
                                leading:
                                    Icon(Icons.info, color: Constants.primary),
                                onPressed: (BuildContext context) {},
                              ),
                              SettingsTile(
                                title: "Giới thiệu bạn bè",
                                titleTextStyle: TextStyle(fontSize: 14),
                                leading: Icon(Icons.person_add,
                                    color: Constants.primary),
                                onPressed: (BuildContext context) {},
                              ),
                              SettingsTile(
                                title: "Đánh giá ứng dụng",
                                titleTextStyle: TextStyle(fontSize: 14),
                                subtitle: "v1.0.0",
                                subtitleTextStyle: TextStyle(fontSize: 12),
                                leading:
                                    Icon(Icons.star, color: Colors.yellow[600]),
                                onPressed: (BuildContext context) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    RoundedButtonBorder(
                      text: student.isDriver == false
                          ? "Chuyển chế độ tài xế"
                          : "Chuyển chế độ hành khách",
                      color: Constants.primary,
                      height: 45,
                      width: mQSize.width * 0.9,
                      press: () {
                        changeMode();
                      },
                    ),
                    RoundedButtonBorder(
                      text: "Đăng xuất",
                      color: Colors.red,
                      height: 45,
                      width: mQSize.width * 0.9,
                      press: () {
                        Dialogs.materialDialog(
                            msg: "Bạn có chắc chắn đăng xuất?",
                            // title: "Đăng xuất",
                            msgStyle: TextStyle(
                                fontSize: 18, color: Constants.primary),
                            titleStyle: TextStyle(fontSize: 18),
                            context: context,
                            actions: [
                              RoundedButton(
                                text: "Hủy",
                                color: Colors.grey,
                                height: 40,
                                press: () {},
                              ),
                              RoundedButton(
                                text: "Đăng xuất",
                                color: Colors.red,
                                height: 40,
                                press: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Welcome.routeName, (route) => false);
                                  FirebaseAuth.instance.signOut();
                                },
                              )
                            ]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
