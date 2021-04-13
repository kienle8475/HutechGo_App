import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpConfirm extends StatefulWidget {
  static final routeName = "OtpConfirm";
  @override
  _OtpConfirm createState() => _OtpConfirm();
}

class _OtpConfirm extends State<OtpConfirm> {
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 10;
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
    startTimeOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[],
          leading: new Container(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: mQSize.height / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("assets/images/vertification.png"),
              ),
            ),
            SizedBox(
              height: mQSize.height * 0.05,
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
                            "Nhập mã OTP được gửi đến",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
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
                                      "Mã OTP sẽ hết hạn và được cấp lại sau: $timerText",
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
                    height: mQSize.height * 0.055,
                    child: Card(
                      margin: EdgeInsets.only(left: 24, right: 24),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: PinCodeTextField(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    textInputType: TextInputType.number,
                                    length: 4,
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
                                    onChanged: (value) {
                                      setState(() {
                                        // currentText = value;
                                      });
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
