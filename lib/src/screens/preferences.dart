import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:groupie/widgets.dart' show createCard;
import 'package:groupie/model.dart' show HobbyCard;
import 'package:groupie/util.dart' show GroupieColours;

class Preferences extends StatefulWidget {
  final String title;
  static String tag = "preferences";

  Preferences({Key key, this.title}) : super(key: key);

  @override
  _PreferencesState createState() {

    return new _PreferencesState();
  }
}

class _PreferencesState extends State<Preferences> {
  List<Widget> hobbyCards = [];

  _PreferencesState() : super() {
    hobbyCards = buildCards();
  }

  List<Widget> buildCards() {
    return <Widget>[
      createCard(new HobbyCard(red: 233, green: 10, blue: 12), () => _removeCard(0)),
      createCard(new HobbyCard(red: 50, green: 12, blue: 11), () => _removeCard(1)),
      createCard(new HobbyCard(red: 10, green: 234, blue: 23), () => _removeCard(2)),
      createCard(new HobbyCard(red: 0, green: 192, blue: 237), () => _removeCard(3)),
    ];
  }

  void _openProfile() {
    Navigator.pushNamed(context, ProfileScreen.tag);
  }

  void _removeCard(int index) {
    print("removing card at index: " + '$index');
    hobbyCards.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        child: new Stack(
          alignment: Alignment.center,
          children: hobbyCards
        ),
      ),
    );
  }
}
