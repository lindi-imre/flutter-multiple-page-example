import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tester_project/model/show_element.dart';
import 'package:tester_project/service/api_service.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

// The chat is the SHOWS page TODO: refactor
class _ChatState extends State<Chat> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Cool Radio műsorok')),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.2, 0.5, 0.85],
                    colors: [Colors.black12, Colors.black87, Colors.black12])),
            child: FutureBuilder(
                future: client.getShowElements(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ShowElement>> snapshot) {
                  if (snapshot.hasData) {
                    List<ShowElement>? showsList = snapshot.data;
                    return ListView.builder(
                      itemCount: showsList!.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                            showsList[index].name +
                                "\n    " +
                                showsList[index].timeFull,
                            style: TextStyle(height: 2)),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })));
  }
}
