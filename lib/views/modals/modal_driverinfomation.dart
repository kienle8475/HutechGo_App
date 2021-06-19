import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DriverInfomationModal extends StatefulWidget {
  DriverInfomationModal({Key key}) : super(key: key);
  @override
  _DriverInfomationModal createState() => _DriverInfomationModal();
}

class _DriverInfomationModal extends State<DriverInfomationModal> {
  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;
    return Material(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: mQSize.height * 0.22,
              width: mQSize.width,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey[100], width: 2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(),
                  Container(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      "Họ tên: Trung Kiên",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      "Số điện thoại: 0966096510",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      "Số xe: ABC-012345",
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text("Đang trên đường đến đón bạn ~ 3 phút",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400))),
                  TextButton(
                      onPressed: () {},
                      child: Text("Nhấn để xem lộ trình",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400))),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Hãy đưa tài xế quét mã để xác nhận bạn nhé!",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: QrImage(
                      data: "1234567890",
                      version: QrVersions.auto,
                      size: mQSize.width * 0.6,
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButtonFill(
                      text: "Báo cáo tài xế",
                      color: Colors.red,
                      height: 50,
                      width: mQSize.width * 0.40,
                      press: () {},
                    ),
                    RoundedButtonBorder(
                      text: "Hủy chuyến đi",
                      color: Colors.red,
                      height: 50,
                      width: mQSize.width * 0.40,
                      press: () {},
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
