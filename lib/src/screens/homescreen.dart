import 'package:flutter/material.dart';

//have to add in to link to the screen
import 'settings/preferences.dart';
import 'settings/profile.dart';
import 'events/participants.dart';

import 'package:groupie/widgets.dart' show EventCard, LoadableScreen;
import 'package:groupie/model.dart' show Event;
import 'package:groupie/util.dart' show GroupieColours, getEvents;

class HomePage extends StatefulWidget {
  final String title;
  static String tag = "homepage🐢";

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() {

    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Map<int, Widget> cards = {};

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    getEvents().then((events) {
      setState(() {
        cards = buildCards(events);
        _loading = false;
      });
    });
  }

  Map<int, Widget> buildCards(List<Event> events) {
    Map<int, Widget> eventWidgets = {};

    for (Event event in events) {
      eventWidgets[event.id] = EventCard(event,
        remove: () {
          setState(() {
            eventWidgets.remove(event.id);
          });
        },
      );
    }

    return eventWidgets;
  }

  //navigator functions to change the screen
  void _openProfile() {
    Navigator.pushNamed(context, ProfileScreen.tag);
  }
  void _openPreferences() {
    Navigator.pushNamed(context, PreferencesScreen.tag);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title, style: new TextStyle(
            color: GroupieColours.grey69)),
        backgroundColor: GroupieColours.white69,
        actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.person_outline),
             tooltip: 'Open Profile',
             onPressed: _openProfile,
           ),
          new IconButton(
              icon: new Icon(Icons.brightness_low),
              tooltip: 'Open Preferences',
              onPressed: _openPreferences,
          )
        ],
        iconTheme: new IconThemeData(color: GroupieColours.grey69),
        automaticallyImplyLeading: false,
      ),
      body: new LoadableScreen(
        visible: !_loading,
        child: new Stack(
          children: [
            new Center(
              child: new Stack(
                alignment: Alignment.center,
                children: cards.values.toList()
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: DragTarget(
                    builder: (a, b, c) => Container(width: 150),
                    onAccept: (data) {
                      print(data);
                      print("FUCK NO");
                    },
                  )
                ),
                Spacer(),
                Flexible(
                  child: DragTarget(
                    builder: (a, b, c) => Container(width: 150),
                    onAccept: (data) {
                      print(data);
                      print("FUCK YES");
                    },
                  )
                ),
              ],
            )
          ]
        )
      ),
      floatingActionButton: new FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed(ParticipantsScreen.tag);
      }),
    );
  }
}
