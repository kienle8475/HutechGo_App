import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/views/passenger/booking.dart';
import 'package:hutech_go/views/home.dart';
import 'package:hutech_go/views/login.dart';
import 'package:hutech_go/views/passenger/rating.dart';
import 'package:hutech_go/views/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: (FirebaseAuth.instance.currentUser == null)
          ? WelcomeScreen()
          : Home(),
      routes: {
        Login.routeName: (context) => Login(),
        Home.routeName: (context) => Home(),
        Booking.routeName: (context) => Booking(),
        Rating.routeName: (context) => Rating(),
      },
    );
  }
}
