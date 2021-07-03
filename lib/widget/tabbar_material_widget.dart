import 'package:flutter/material.dart';

class TabBarMaterialWidget extends StatefulWidget {
  @override
  _TabBarMaterialWidgetState createState() => _TabBarMaterialWidgetState();
}

class _TabBarMaterialWidgetState extends State<TabBarMaterialWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Row(
          children: [
            buildTabItem(
                index: 0,
                icon: Icon(Icons.search)
            ),
            buildTabItem(
                index: 1,
                icon: Icon(Icons.mail_outline)
            ),
            buildTabItem(
                index: 2,
                icon: Icon(Icons.account_circle)
            ),
            buildTabItem(
                index: 3,
                icon: Icon(Icons.settings)
            ),
          ],
        )
    );
  }

  Widget buildTabItem({
    required int index,
    required Icon icon,
  }) {
    return IconButton(
        icon: icon,
        onPressed: () {});
  }
}