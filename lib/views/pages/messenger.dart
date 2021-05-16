import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messenger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size mQSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Tin nhắn",
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                  centerTitle: true,
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.green,
                    // isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          "Trò chuyện",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Thông báo",
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              children: [
                Scaffold(
                  body: Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: mQSize.height * 0.6,
                        width: mQSize.width * 0.6,
                        child: Image.asset(
                          "assets/images/no_messenger.png",
                        ),
                      ),
                      Text(
                        "Bạn không có tin nhắn",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: mQSize.width * 0.8,
                          child: Text(
                            "Bạn và người từng đi cùng có thể nhắn tin trực tiếp để đón nhau trong những lần tiếp theo.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  )),
                ),
                Scaffold(
                  body: Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: mQSize.height * 0.6,
                        width: mQSize.width * 0.6,
                        child: Image.asset(
                          "assets/images/no_notification.png",
                        ),
                      ),
                      Text(
                        "Bạn không có thông báo",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: mQSize.width * 0.8,
                        child: Text(
                          "Các thông báo về ứng dụng và ưu đãi dành cho bạn bạn sẽ xuất hiện ở đây.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
