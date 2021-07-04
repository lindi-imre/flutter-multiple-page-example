import 'package:flutter/material.dart';
import 'package:tester_project/page/chat.dart';
import 'package:tester_project/page/marketing.dart';
import 'package:tester_project/page/player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [Player(), Chat(), Marketing()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Player();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData.dark(),
        home: Scaffold(
          body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.2, 0.5, 0.85],
                      colors: [Colors.black12, Colors.black87, Colors.black12
                  ])),
              child: PageStorage(
                child: currentScreen,
                bucket: bucket,
              )),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey,
            child: Icon(Icons.play_arrow),
            onPressed: () {},
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            shape: CircularNotchedRectangle(),
            notchMargin: 6,
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Player();
                            currentTab = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wifi_tethering,
                                color:
                                    currentTab == 0 ? Colors.blue : Colors.grey)
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Chat();
                            currentTab = 1;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today_rounded,
                                color:
                                    currentTab == 1 ? Colors.blue : Colors.grey)
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Marketing();
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart_rounded,
                                color:
                                    currentTab == 2 ? Colors.blue : Colors.grey)
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = Marketing();
                            currentTab = 3;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.facebook,
                                color: currentTab == 3
                                    ? Colors.blue
                                    : Colors.grey),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
