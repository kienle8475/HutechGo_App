import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final double height, width;
  const RoundedButton(
      {Key key, this.text, this.press, this.color, this.height, this.width})
      : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: height,
      width: width,
      child: RaisedButton(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        onPressed: press,
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        textColor: color,
        child: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

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
            borderRadius: BorderRadius.circular(8.0),
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
            borderRadius: BorderRadius.circular(8.0),
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

class RoundedButtonGradient extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final double height, width;
  const RoundedButtonGradient(
      {Key key, this.text, this.press, this.color, this.height, this.width})
      : super(key: key);
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: height,
      width: width,
      child: RaisedGradientButton(
        onPressed: press,
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(242, 42, 255, 1),
            Color.fromRGBO(21, 179, 255, 1)
          ],
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
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
            borderRadius: BorderRadius.circular(8.0),
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

///-------------------------------------------------------------------------///
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
            borderRadius: BorderRadius.circular(8.0),
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

///-------------------------------------------------------------------------///
final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.pink, Colors.blue],
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
          borderRadius: BorderRadius.circular(8.0),
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
                      foreground: Paint()..shader = linearGradient,
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
