import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
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
                    "Hoạt động của tôi",
                    style: TextStyle(color: Colors.amber, fontSize: 20),
                  ),
                  centerTitle: true,
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelColor: Colors.amber,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.amber,
                    // isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          "Hoạt động hiện tại",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Lịch sử chuyến đi",
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
                          "assets/images/no_activity.png",
                        ),
                      ),
                      Text(
                        "Hiện tại bạn chưa có hoạt động nào",
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
                            "Hoạt động sẽ xuất hiện khi bạn sử dụng các dịch vụ của chúng tôi.",
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
                          "assets/images/no_activity.png",
                        ),
                      ),
                      Text(
                        "Bạn không có lịch sử di chuyển",
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
                            "Có vẻ bạn chưa thực hiện chuyến đi nào.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ))
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
