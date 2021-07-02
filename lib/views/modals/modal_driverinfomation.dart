import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/components/custom_message.dart';
import 'package:hutech_go/components/custom_notch.dart';
import 'package:hutech_go/utils/constants.dart';
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
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: 12),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 12, bottom: 12),
                    child: SizedBox(
                      width: mQSize.width * 0.38,
                      child: QrImage(
                        data: "1253646481287381379817977",
                        version: QrVersions.auto,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 6, top: 6, bottom: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text("Tài xế: Trung Kiên",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54)),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text("0966096510",
                              style: TextStyle(
                                  fontSize: 20, color: Constants.primary)),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text("Honda màu xanh",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey)),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text("81B1 - 12345",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey)),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5, right: 20),
                              child: TextNotch(
                                text: "500 m",
                                color: Constants.primary,
                                fontSize: 20,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, right: 20),
                              child: TextNotch(
                                text: "3 phút",
                                color: Constants.primary,
                                fontSize: 20,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(color: Colors.grey[100]),
                padding: EdgeInsets.only(bottom: 12),
                child: SizedBox(
                    width: mQSize.width * 0.91,
                    height: mQSize.height * 0.65,
                    child: ChatMessage(
                      text:
                          "abcakjjakjlkajdkajkdlakdmncnmcnmasnmnm,akjlkajdkajkdlakdmncnmcnmasnmakjlkajdkajkdlakdmncnmcnmasnmn",
                      color: Constants.primary,
                    ))),
            Container(
              padding: EdgeInsets.only(top: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButtonFill(
                      text: "Báo cáo tài xế",
                      color: Colors.red,
                      height: 50,
                      width: mQSize.width * 0.42,
                      press: () {},
                    ),
                    RoundedButtonBorder(
                      text: "Hủy chuyến đi",
                      color: Colors.red,
                      height: 50,
                      width: mQSize.width * 0.42,
                      press: () {},
                    ),
                  ]),
            )
          ],
        ),
      ),
    ));
  }
}
