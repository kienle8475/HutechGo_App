import 'package:flutter/material.dart';
import 'package:hutech_go/views/passenger/booking.dart';
import 'package:hutech_go/views/home.dart';
import 'package:hutech_go/views/login.dart';
import 'package:hutech_go/views/otp_confirm.dart';
import 'package:hutech_go/views/passenger/rating.dart';
import 'package:hutech_go/views/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hutech Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
      routes: {
        Login.routeName: (context) => Login(),
        OtpConfirm.routeName: (context) => OtpConfirm(),
        Home.routeName: (context) => Home(),
        Booking.routeName: (context) => Booking(),
        Rating.routeName: (context) => Rating(),
      },
    );
  }
}
