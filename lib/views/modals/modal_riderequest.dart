import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RideRquestrModal extends StatelessWidget {
  RideRquestrModal({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return Material(
        child: Container(
      height: mQSize.height,
      width: mQSize.width,
      child: Text("Request"),
    ));
  }
}
