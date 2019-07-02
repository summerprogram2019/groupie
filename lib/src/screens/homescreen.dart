import 'package:flutter/material.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  final String title;
  static String tag = "homepage";

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _openProfile() {
    Navigator.pushNamed(context, ProfileScreen.tag);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.person_outline),
             tooltip: 'Open Profile',
             onPressed: _openProfile,
           ),
        ]
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Swipey boi coming soon',
            ),
          ],
        ),
      ),
    );
  }
}
