import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/components/custom_notch.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/pages/passenger/rating.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverInfomationModal extends StatefulWidget {
  DriverInfomationModal({Key key}) : super(key: key);
  @override
  _DriverInfomationModal createState() => _DriverInfomationModal();
}

class _DriverInfomationModal extends State<DriverInfomationModal> {
  void _launchMapsUrl(String originPlaceId, String destinationPlaceId) async {
    String mapOptions = [
      'origin=$originPlaceId',
      'origin_place_id=$originPlaceId',
      'destination=$destinationPlaceId',
      'destination_place_id=$destinationPlaceId',
      'dir_action=navigate'
    ].join('&');
    final url2 =
        'https://www.google.com/maps/dir/?api=1&origin_place_id=ChIJK5jimggndTER3n7AnHkZSpY&destination=QVB&destination_place_id=ChIJq0PLWaQodTERfiq1cNMpPWw&travelmode=driving';
    final url = 'https://www.google.com/maps/dir/api=1&$mapOptions';
    if (await canLaunch(url2)) {
      await launch(url2);
    } else {
      throw 'Could not launch $url2';
    }
  }

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
                      width: mQSize.width * 0.39,
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
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text("Tài xế: Trung Kiên",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54)),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text("0966096510",
                              style: TextStyle(
                                  fontSize: 18, color: Constants.primary)),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text("Honda màu xanh",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey)),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text("81B1 - 12345",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey)),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: TextNotch(
                                text: "500 m",
                                color: Constants.primary,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: TextNotch(
                                text: "3 phút",
                                color: Constants.primary,
                                fontSize: 18,
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
                  height: mQSize.height * 0.55,
                  // child: ChatMessage(
                  //   text: "Hello!",
                  //   height: 10,
                  //   color: Constants.primary,)
                  child: Image.asset("assets/images/chat_conver.png"),
                )),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButtonFill(
                      text: "Báo cáo tài xế",
                      color: Colors.red,
                      height: 48,
                      width: mQSize.width * 0.42,
                      press: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop("Discard");
                        Navigator.pushNamed(context, Rating.routeName);
                        _launchMapsUrl("originPlaceId", "destinationPlaceId");
                      },
                    ),
                    RoundedButtonBorder(
                      text: "Hủy chuyến đi",
                      color: Colors.red,
                      height: 48,
                      width: mQSize.width * 0.42,
                      press: () {
                        Navigator.pushNamed(context, Rating.routeName);
                      },
                    ),
                  ]),
            )
          ],
        ),
      ),
    ));
  }
}
