import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final double height, width;
  final double fontSize;
  const ChatMessage(
      {Key key,
      this.text,
      this.press,
      this.color,
      this.height,
      this.width,
      this.fontSize})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      height: height,
      width: width,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
    );
  }
}
