import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/models/student.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/pages/passenger/booking.dart';

// ignore: must_be_immutable
class HomePassenger extends StatelessWidget {
  Student student;
  Size mQSize;
  HomePassenger(this.student);
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.blue, Colors.purple],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 70.0));
  @override
  Widget build(BuildContext context) {
    mQSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: new EdgeInsets.only(top: mQSize.height * 0.08),
        ),
        Container(
          // padding:
          //     new EdgeInsets.only(top: mQSize.height * 0.15),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Constants.primary, width: 1),
                borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
              height: mQSize.height * 0.3,
              width: mQSize.width * 0.92,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: mQSize.height * 0.08,
                      child: Image.network(
                          "https://www.hutech.edu.vn/imgnews/homepage/stories/hinh34/logo%20CMYK-01.png"),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        child: Image.network(
                          student.profileImage,
                          height: 14,
                          width: 140,
                        ),
                      ),
                      Container(
                        height: 140,
                        width: mQSize.width - 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: Text(
                                        (student.studentName).toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            // color: Constants.primary,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            foreground: Paint()
                                              ..shader = linearGradient),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        (student.birthday).toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            // color: Constants.primary,
                                            fontSize: 18,
                                            foreground: Paint()
                                              ..shader = linearGradient),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        (student.studentId +
                                                " - " +
                                                student.schoolClass)
                                            .toUpperCase(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            // color: Constants.primary,
                                            fontSize: 18,
                                            foreground: Paint()
                                              ..shader = linearGradient),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: BarCodeImage(
                                          params: Code39BarCodeParams(
                                            student.studentId,
                                            lineWidth:
                                                1.2, // width for a single black/white bar (default: 2.0)
                                            barHeight:
                                                35.0, // height for the entire widget (default: 100.0)
                                            withText: false,
                                            // Render with text label or not (default: false)
                                          ),
                                          onError: (error) {
                                            // Error handler
                                            print('error = $error');
                                          },
                                        )),
                                  ],
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            child: SizedBox(
              height: mQSize.height * 0.40,
              width: mQSize.width * 0.98,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RoundedButtonGradient(
                    text: "TÌM XE",
                    color: Colors.lightBlue,
                    height: 50,
                    width: mQSize.width,
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Booking(student.university)));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
