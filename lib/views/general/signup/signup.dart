import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/views/general/otp_confirm.dart';

class Signup extends StatefulWidget {
  static final routeName = "login";
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  bool _isLoading = false;
  String _countrycode;
  TextEditingController _controllerPhoneNumber = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;
    verifyPhoneNumber() async {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: _countrycode + _controllerPhoneNumber.text,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {});
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e);
          },
          codeSent: (String verificationID, int resendToken) {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OtpConfirm(verificationID,
                      _countrycode + _controllerPhoneNumber.text, false)));
            });
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            setState(() {});
          });
    }

    login() async {
      var isValidUser = false;
      await FirebaseFirestore.instance
          .collection('students')
          .where('phone_number',
              isEqualTo: _countrycode + _controllerPhoneNumber.text)
          .get()
          .then((value) {
        if (value.docs.length > 0) {
          isValidUser = true;
        }
      });
      if (isValidUser) {
        await verifyPhoneNumber();
        _isLoading = false;
      } else {
        FocusScope.of(context).unfocus();
        _scaffoldkey.currentState.showSnackBar(SnackBar(
          content: Text('Số điện thoại chưa được đăng ký'),
          action: SnackBarAction(),
        ));
        _isLoading = false;
      }
    }

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: ListView(
          children: <Widget>[
            Container(
              height: mQSize.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logos/hutechgo_logo.png",
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
                          borderRadius: BorderRadius.circular(0)),
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: CountryCodePicker(
                                onChanged: (e) {
                                  _countrycode = e.dialCode;
                                },
                                onInit: (e) {
                                  _countrycode = e.dialCode;
                                },
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
                                  controller: _controllerPhoneNumber,
                                  maxLength: 9,
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
                                    login();
                                    _isLoading = true;
                                  },
                                  keyboardType: TextInputType.number),
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
      )),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          onPressed: () {
            login();
            setState(() {
              _isLoading = true;
            });
          },
          // child: ,
          child: (_isLoading)
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
