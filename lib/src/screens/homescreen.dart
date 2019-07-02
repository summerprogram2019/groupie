import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:groupie/widgets.dart' show createCard;
import 'package:groupie/model.dart' show HobbyCard;

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
        child: new Stack(
          alignment: Alignment.center,
          children: <Widget>[
            createCard(new HobbyCard(red: 233, green: 10, blue: 12)),
            createCard(new HobbyCard(red: 50, green: 12, blue: 11)),
            createCard(new HobbyCard(red: 10, green: 234, blue: 23)),
            createCard(new HobbyCard(red: 0, green: 192, blue: 237)),
          ],
        ),
      ),
    );
  }
}
