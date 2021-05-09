import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/views/home.dart';
import 'package:hutech_go/views/login.dart';
import 'package:hutech_go/views/passenger/rating.dart';
import 'package:hutech_go/views/welcome.dart';

import 'models/student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  checkNetwork();
  runApp(MyApp());
}

Future<void> checkNetwork() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print("true");
    }
  } on SocketException catch (_) {
    print("false");
  }
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
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        Login.routeName: (context) => Login(),
        Home.routeName: (context) => Home(),
        Rating.routeName: (context) => Rating(),
      },
    );
  }
}
