import 'package:flutter/material.dart';

class AppBarWBack extends StatelessWidget implements PreferredSizeWidget {
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: null,
      child: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[],
        leading: new Container(),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(35);
}
