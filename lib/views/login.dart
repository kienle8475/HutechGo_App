import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:hutech_go/components/custom_appbar.dart';
import 'package:hutech_go/views/otp_confirm.dart';

class Login extends StatefulWidget {
  static final routeName = "login";
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWBack(),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cùng di chuyển với Hutech Go nhé!",
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
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Sử dụng số điện thoại bạn đã đăng ký để đăng nhập",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ))
                        ],
                      )),
                  SizedBox(
                    height: mQSize.height * 0.01,
                  ),
                  Container(
                    height: mQSize.height * 0.065,
                    child: Card(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: CountryCodePicker(
                                onChanged: (e) {},
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'VN',
                                favorite: ['VN'],
                                // optional. Shows only country name and flag
                                showCountryOnly: true,
                                // optional. Shows only country name and flag when popup is closed.
                                showOnlyCountryWhenClosed: false,
                                // optional. aligns the flag and the Text left
                                alignLeft: false,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: TextField(
                                maxLength: 10,
                                autofocus: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Nhập số điện thoại",
                                  hintStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                  counterText: "",
                                ),
                                onSubmitted: (e) {
                                  Navigator.pushNamed(
                                      context, OtpConfirm.routeName);
                                },
                                keyboardType: TextInputType.number,
                              ),
                            )
                          ],
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
            onPressed: () {
              Navigator.pushNamed(context, OtpConfirm.routeName);
            },
            child: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
