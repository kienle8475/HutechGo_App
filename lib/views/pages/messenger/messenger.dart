import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_segmented_control.dart';
import 'package:hutech_go/views/pages/messenger/messenger_converation.dart';
import 'package:hutech_go/views/pages/messenger/messenger_notification.dart';

class Messenger extends StatefulWidget {
  static Widget giveCenter(String yourText) {
    return Center(
      child: Text(
        "Text: $yourText",
        style: TextStyle(color: Colors.blue, fontSize: 20.0),
      ),
    );
  }

  @override
  _Messenger createState() => _Messenger();
}

class _Messenger extends State<Messenger> {
  int tabIndex = 0;

  List<Widget> bodies = [MessengerConveration(), MessengerNotification()];

  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: bodies[tabIndex],
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, 50.0),
              child: Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
                child: SegmentedControl(
                  initialPosition: 0,
                  selectedColor: Colors.blue[600],
                  unSelectedColor: Colors.white,
                  borderColor: Colors.blue[600],
                  height: 45,
                  width: mQSize.width * 0.45,
                  values: ['Trò chuyện', 'Thông báo'],
                  onSelected: (index) {
                    tabIndex = index;
                  },
                ),
              )),
        ),
      ),
    ));
  }
}
