import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hutech_go/utils/constants.dart';

class MessengerConveration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Center(
      child: Column(
        children: [
          SizedBox(
            height: mQSize.height * 0.6,
            width: mQSize.width * 0.6,
            child: Image.asset(
              "assets/images/emptystate_mess.png",
            ),
          ),
          Text(
            "Bạn không có tin nhắn",
            style: TextStyle(
                color: Constants.primary,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: mQSize.width * 0.8,
              child: Text(
                "Bạn và người từng đi cùng có thể nhắn tin trực tiếp để có thể đón nhau trong những lần tiếp theo",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    ));
  }
}
