import 'package:flutter/material.dart';
import 'package:hutech_go/utils/constants.dart';

class AppBarWBack extends StatelessWidget implements PreferredSizeWidget {
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: null,
      child: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[],
        leading: new Container(
          child: new IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: new Icon(Icons.arrow_back),
            color: Constants.primary,
            onPressed: () => Navigator.of(context).pop(null),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(30);
}
