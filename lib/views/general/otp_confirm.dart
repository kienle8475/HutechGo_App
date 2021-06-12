import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_appbar.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/general/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpConfirm extends StatefulWidget {
  final String verificationCode;
  final String phoneNumber;
  OtpConfirm(this.verificationCode, this.phoneNumber);

  @override
  _OtpConfirm createState() => _OtpConfirm();
}

class _OtpConfirm extends State<OtpConfirm> {
  final TextEditingController _controllerPinCode = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 60;
  int currentSecond = 0;
  bool btnVisible = false;
  String get timerText =>
      '${((timerMaxSeconds - currentSecond) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSecond) % 60).toString().padLeft(2, '0')} ';
  startTimeOut([int milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSecond = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          timer.cancel();
          btnVisible = !btnVisible;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimeOut();
  }

  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBarWBack(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: mQSize.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logos/text_logo.png",
                    width: mQSize.width * 0.8,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nhập mã OTP được gửi đến ${widget.phoneNumber}",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: mQSize.height * 0.01),
                          Container(
                            height: 50,
                            width: mQSize.width * 0.8,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Mã OTP sẽ được cấp lại sau: $timerText",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Visibility(
                                        visible: btnVisible,
                                        child: OtpRequest(
                                          text: "Gửi lại",
                                          height: 30,
                                          width: 60,
                                          color: Constants.success,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: mQSize.height * 0.01,
                  ),
                  Container(
                    height: mQSize.height * 0.065,
                    child: Card(
                      margin: EdgeInsets.only(left: 24, right: 24),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: PinCodeTextField(
                                    controller: _controllerPinCode,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    textInputType: TextInputType.number,
                                    length: 6,
                                    obsecureText: false,
                                    inactiveColor: Colors.black,
                                    animationType: AnimationType.fade,
                                    shape: PinCodeFieldShape.underline,
                                    animationDuration:
                                        Duration(milliseconds: 300),
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 30,
                                    fieldWidth: 25,
                                    autoFocus: true,
                                    onChanged: (String value) {},
                                    onCompleted: (value) async {
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithCredential(
                                                PhoneAuthProvider.credential(
                                                    verificationId:
                                                        widget.verificationCode,
                                                    smsCode: value))
                                            .then((value) async {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              Home.routeName,
                                              (route) => false);
                                        });
                                      } catch (e) {
                                        print(e);
                                        FocusScope.of(context).unfocus();
                                        _scaffoldkey.currentState.showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Mã OTP không hợp lệ')));
                                      }
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mQSize.height * 0.1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
