import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hutech_go/utils/constants.dart';

class ActivityHistory extends StatelessWidget {
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
              "assets/images/emptystate_task.png",
            ),
          ),
          Text(
            "Có vẻ bạn chưa thực hiện chuyến đi nào",
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
                "Hãy cùng đến trường với Uni Go nhé!",
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
