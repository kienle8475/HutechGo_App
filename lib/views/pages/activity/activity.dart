import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_segmented_control.dart';
import 'package:hutech_go/views/pages/activity/activity_currentactivity.dart';

import 'activity_history.dart';

class Activity extends StatefulWidget {
  static Widget giveCenter(String yourText) {
    return Center(
      child: Text(
        "Text: $yourText",
        style: TextStyle(color: Colors.blue, fontSize: 20.0),
      ),
    );
  }

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  int tabIndex = 0;

  List<Widget> bodies = [
    ActivityCurrent(),
    ActivityHistory(),
  ];

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
          backgroundColor: Colors.blue[600],
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, 50.0),
              child: Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
                child: SegmentedControl(
                  initialPosition: 0,
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.blue[600],
                  borderColor: Colors.white,
                  height: 45,
                  width: mQSize.width * 0.45,
                  values: ['Hoạt động hiện tại', 'Lịch sử chuyến đi'],
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
