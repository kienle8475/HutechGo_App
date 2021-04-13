import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Main(),
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
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 35,
            right: 15,
            child: Image.asset(
              "assets/images/logos/hutech.png",
              height: mQSize.width * 0.15,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: mQSize.height * 0.10),
            Image.asset(
              "assets/images/gotouni.png",
              height: mQSize.width * 0.55,
            ),
            SizedBox(height: mQSize.height * 0.02),
            // Text(
            //   "hutech go",
            //   style: TextStyle(
            //       fontFamily: "Tumbly",
            //       fontSize: 40,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.blue),
            // ),
            SizedBox(height: mQSize.height * 0.2),
            RoundedButtonFill(
              text: "ĐĂNG NHẬP",
              color: Constants.primary,
              height: mQSize.height * 0.05,
              width: mQSize.width * 0.8,
              press: () {
                Navigator.pushNamed(context, Login.routeName);
              },
            ),
            RoundedButtonBorder(
              text: "ĐĂNG KÝ",
              color: Constants.primary,
              height: mQSize.height * 0.05,
              width: mQSize.width * 0.8,
              press: () {},
            ),
            SizedBox(
              height: mQSize.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Bằng với việc đăng nhập hoặc đăng ký, bạn đã đồng ý các',
                      style: TextStyle(
                        color: Constants.light,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: ' Điều khoản dịch vụ',
                      style: TextStyle(
                        color: Constants.primary,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: ' và ',
                      style: TextStyle(
                        color: Constants.light,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: 'Chính sách bảo mật',
                      style: TextStyle(
                        color: Constants.primary,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: ' của chúng tôi ',
                      style: TextStyle(
                        color: Constants.light,
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: mQSize.height * 0.01),
          ]),
    ));
  }
}
