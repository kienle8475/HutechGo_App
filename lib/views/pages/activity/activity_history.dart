import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hutech_go/utils/constants.dart';

class ActivityHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: ListView(
          children: [
            Form(
              child: Container(
                width: mQSize.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: mQSize.height * 0.01),
                      Image.asset(
                        "assets/images/history.jpg",
                      ),
                    ]),
              ),
            )
          ],
        ),
      )),
    ));
  }
}
