import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Cool Radio NYC'),
        actions: [
          PopupMenuButton<String>(
            onSelected: null,
            color: Colors.black87,
            itemBuilder: (BuildContext context) {
              return {'High quality', 'Low quality', 'Facebook'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.2, 0.5, 0.85],
                    colors: [Colors.black12, Colors.black87, Colors.black12])),
            child: Center(
              child: Text('PlayerScreen', style: TextStyle(fontSize: 40)),
            )));
  }
}
