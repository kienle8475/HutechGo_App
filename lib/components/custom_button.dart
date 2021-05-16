import 'package:flutter/material.dart';
import 'package:hutech_go/views/welcome.dart';

class RoundedButtonFill extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final double height, width;
  const RoundedButtonFill(
      {Key key, this.text, this.press, this.color, this.height, this.width})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: height,
      width: width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(color: color)),
        onPressed: press,
        padding: EdgeInsets.all(10.0),
        color: color,
        textColor: Colors.white,
        child: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class RoundedButtonBorder extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final double height, width;
  const RoundedButtonBorder(
      {Key key, this.text, this.press, this.color, this.height, this.width})
      : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: height,
      width: width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(color: color)),
        onPressed: press,
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        textColor: color,
        child: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class OtpRequest extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final double height, width;
  const OtpRequest(
      {Key key, this.text, this.press, this.color, this.height, this.width})
      : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
      height: height,
      width: width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(color: color)),
        onPressed: () {},
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        textColor: color,
        child: Text(text, style: TextStyle(fontSize: 12)),
      ),
    );
  }
}

class CampusButtonBorder extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final double height, width;
  const CampusButtonBorder(
      {Key key, this.text, this.press, this.color, this.height, this.width})
      : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: height,
      width: width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(color: color)),
        onPressed: () {},
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        textColor: color,
        child: Text(text, style: TextStyle(fontSize: 15)),
      ),
    );
  }
}

class RequestRideButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final double height, width;
  final Icon icon;
  const RequestRideButton(
      {Key key,
      this.text,
      this.icon,
      this.press,
      this.color,
      this.height,
      this.width})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: height,
      width: width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(color: color)),
        onPressed: press,
        padding: EdgeInsets.all(10.0),
        color: color,
        textColor: Colors.white,
        child: Row(
          children: [Text(text, style: TextStyle(fontSize: 15))],
        ),
      ),
    );
  }
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.grey, Colors.grey],
).createShader(Rect.fromLTWH(0.0, 0.0, 350.0, 70.0));

class HomeMenuButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final double height, width;
  final Image icon;
  const HomeMenuButton({
    Key key,
    this.text,
    this.icon,
    this.press,
    this.color,
    this.height,
    this.width,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: height,
      width: width,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          // side: BorderSide(color: Colors.purple)
        ),
        onPressed: press,
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              child: icon,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      // foreground: Paint()..shader = linearGradient)
                      color: Colors.grey,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
