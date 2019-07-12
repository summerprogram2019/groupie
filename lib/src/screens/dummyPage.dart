import 'package:flutter/material.dart';

//have to add in to link to the screen
import 'settings/preferences.dart';
import 'settings/profile.dart';

import 'events/participants.dart';
import 'events/upcomingEvents.dart';

import 'package:groupie/widgets.dart' show EventCard, LoadableScreen, CircleButton;
import 'package:groupie/model.dart' show Event;
import 'package:groupie/screens.dart' show CreateNewEventMajorPage;
import 'package:groupie/util.dart' show GroupieColours, getEvents;

class DummyPage extends StatefulWidget {
  final String title;
  static String tag = "homepage??";

  DummyPage({Key key, this.title}) : super(key: key);

  @override
  _DummyPageState createState() {

    return new _DummyPageState();
  }
}

class _DummyPageState extends State<DummyPage> {
  @override
  _DummyPageState();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      ),
      body: new Center(
        child: new Column(
        children: [
          Text(widget.title),
          RaisedButton(
            child: Text("Go back"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]
      )
    ));
  }
}
