import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hutech_go/utils/constants.dart';

class MessengerNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Center(
      child: Column(
        children: [
          SizedBox(
            height: mQSize.height * 0.58,
            width: mQSize.width * 0.58,
            child: Image.asset(
              "assets/images/emptystate_noti.png",
            ),
          ),
          Text(
            "Bạn không có thông báo nào",
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
                "Các thông báo về ứng dụng và ưu đãi dành cho bạn bạn sẽ xuất hiện ở đây",
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
