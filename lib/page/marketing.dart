import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tester_project/model/merchant_element.dart';
import 'package:tester_project/service/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Marketing extends StatefulWidget {
  @override
  _MarketingState createState() => _MarketingState();
}

class _MarketingState extends State<Marketing> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Marketing')),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.2, 0.5, 0.85],
                    colors: [Colors.black12, Colors.black87, Colors.black12])),
            child: (FutureBuilder(
                future: client.getMerchantElements(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<MerchantElement>> snapshot) {
                  if (snapshot.hasData) {
                    List<MerchantElement>? merchantList = snapshot.data;
                    return ListView.builder(
                      itemCount: merchantList!.length,
                      itemBuilder: (context, index) => Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05),
                          child: Column(
                            children: [
                              InkWell(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl: merchantList[index].imgUrl,
                                        placeholder: (context, url) => new LinearProgressIndicator(),
                                        errorWidget: (context, url, error) => new Icon(Icons.error),
                                        width: MediaQuery.of(context).size.width * 0.8,
                                      )
                                  ),
                                  onTap: () {
                                    _launchURL(merchantList[index].url);
                                  }),
                              Container(
                                  child: Text(merchantList[index].title),
                                  margin: index < merchantList.length - 1
                                      ? EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.001)
                                      : EdgeInsets.fromLTRB(
                                          0,
                                          0,
                                          0,
                                          MediaQuery.of(context).size.height *
                                              0.05))
                            ],
                          )),
                      //     ListTile(
                      //   title: Text(
                      //       merchantList[index].title +
                      //           "\n    " + merchantList[index].url,
                      //       style: TextStyle(height: 2)),
                      // ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }))));
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
  throw "Could not launch $url";
}
}
