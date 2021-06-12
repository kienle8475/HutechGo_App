import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hutech_go/views/general/home.dart';
import 'package:hutech_go/views/general/login.dart';
import 'package:hutech_go/views/general/welcome.dart';
import 'package:hutech_go/views/pages/passenger/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
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
      debugShowCheckedModeBanner: false,
      title: 'Hutech Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: (FirebaseAuth.instance.currentUser == null) ? Welcome() : Home(),
      routes: {
        Welcome.routeName: (context) => Welcome(),
        Login.routeName: (context) => Login(),
        Home.routeName: (context) => Home(),
        Rating.routeName: (context) => Rating(),
      },
    );
  }
}
