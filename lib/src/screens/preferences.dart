import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:groupie/util.dart' show GroupieColours;

class PreferencesScreen extends StatefulWidget {
  final String title;
  static String tag = "preferences";

  PreferencesScreen({Key key, this.title}) : super(key: key);

  @override
  _PreferencesScreenState createState() {

    return new _PreferencesScreenState();
  }
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  _PreferencesScreenState() : super() {

  }


  void _openProfile() {
    Navigator.pushNamed(context, ProfileScreen.tag);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //the universal background colour
      //backgroundColor: Color.fromARGB(255, 112, 112, 112),

      //the universal background colour
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: GroupieColours.white69,
        actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.person_outline),
             tooltip: 'Open Profile',
             onPressed: _openProfile,
           ),
        ]
      ),
      body: new Center(
        child: new ListView(
          children: <Widget>[
            Image.asset('laura.jpg'),
            Image.asset('laura.jpg')
          ],
        ),
      ),
    );
  }
}
