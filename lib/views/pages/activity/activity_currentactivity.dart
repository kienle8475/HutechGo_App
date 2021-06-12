import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ActivityCurrent extends StatelessWidget {
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
            "Hiện tại bạn chưa có hoạt động nào",
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: mQSize.width * 0.8,
              child: Text(
                "Hoạt động sẽ xuất hiện khi bạn sử dụng dịch vụ của chúng tôi",
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
