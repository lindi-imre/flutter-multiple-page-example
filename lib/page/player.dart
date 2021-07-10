import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_volume_slider/flutter_volume_slider.dart';
import 'package:tester_project/service/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  String imgUrl = "";
  Timer? timer;
  String artist = "Stay Cool";
  String title = "and tap play! ;)";
  ApiService client = ApiService();
  static const currentUrl =
      'https://public.radio.co/api/v2/s0ec7c069a/track/current';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    loadMusicData();
    Timer.periodic(Duration(seconds: 15), (timer) {
      loadMusicData();
    });
  }

  loadMusicData() async {
    var result = await client.fetchJsonData(currentUrl);
    setState(() {
      imgUrl = result['data']['artwork_urls']['large'];
      int idx = result['data']['title'].indexOf("-");
      List parts = [
        result['data']['title'].substring(0, idx).trim(),
        result['data']['title'].substring(idx + 1).trim()
      ];
      artist = parts.first;
      title = parts.last;
    });
    log("################fetched");
    log(imgUrl);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('Cool Radio NYC'),
          actions: [
            PopupMenuButton<String>(
              onSelected: null,
              color: Colors.black87,
              itemBuilder: (BuildContext context) {
                return {'High quality', 'Low quality'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.2, 0.5, 0.85],
                    colors: [Colors.black12, Colors.black87, Colors.black12])),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: screenHeight > 700 ? screenHeight * 0.06 : screenHeight * 0.02),
                    width: screenWidth * 0.7,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(10.3))),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: (imgUrl == null || imgUrl == "")
                            ? Image(
                                image: AssetImage('images/mobile_friendly.png'),
                                height: screenHeight > 700 ? screenWidth * 0.7 : screenWidth * 0.65)
                            : Image.network(imgUrl, height: screenHeight > 700 ? screenWidth * 0.7 : screenWidth * 0.65)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Text(
                      artist,
                      style: TextStyle(
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight * 0.02),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight > 700 ? screenHeight * 0.05 : screenHeight * 0.03),
                    child: FlutterVolumeSlider(
                      display: Display.HORIZONTAL,
                      sliderActiveColor: Colors.red,
                      sliderInActiveColor: Colors.white,
                      soundIconsColor: Colors.red,
                    ),
                  ),
                  InkWell(
                      child: Container(
                          margin: EdgeInsets.only(
                              top: screenHeight *
                                  (screenHeight > 700 ? 0.07 : 0.04)),
                          child: Text(
                            "STUDIO: +1 292 271 8880",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          )),
                      onTap: () {
                        _makePhoneCall("tel:+12922718880");
                        Fluttertoast.showToast(
                            msg: "Telefon app megnyitása",
                            toastLength: Toast.LENGTH_SHORT);
                      }),
                ],
              )
            ])));
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
