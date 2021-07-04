import 'package:flutter/material.dart';

class Marketing extends StatefulWidget {
  @override
  _MarketingState createState() => _MarketingState();
}

class _MarketingState extends State<Marketing> {
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
            child: Center(
              child: Text('MarketingScreen', style: TextStyle(fontSize: 40)),
            )));
  }
}
