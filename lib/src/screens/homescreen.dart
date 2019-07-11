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
  List<Widget> cards = [];

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

  List<Widget> buildCards(List<Event> events) {
    List<Widget> eventWidgets = [];

    for (Event event in events) {
      eventWidgets.add(EventCard(event));
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

  void _removeCard(int index) {
    print("removing card at index: " + '$index');
    cards.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0), // here the desired height
        child: new AppBar(
  //            title: new Text(widget.title, style: new TextStyle(
  //            color: GroupieColours.grey69)),
          backgroundColor: GroupieColours.logoColor,
          centerTitle: true,
          actions: <Widget>[
            new Center(
              child:
                new Row(
                  children: [
                    new Column(
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(Icons.brightness_low),
                          iconSize: 50.0,
                          tooltip: 'Open Preferences',
                          onPressed: _openPreferences,
                        ),
                      ]
                    ),
                    // TODO Update link to events page once the screen has been created
                    new Column(
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(Icons.calendar_today),
                          iconSize: 50.0,
                          tooltip: 'Open Preferences',
                          onPressed: _openPreferences,
                        ),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(Icons.person_outline),
                          iconSize: 49.0,
                          tooltip: 'Open Profile',
                          onPressed: _openProfile,
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ],
          iconTheme: new IconThemeData(color: GroupieColours.grey69),
          automaticallyImplyLeading: false,
        ),
      ),
      body: new LoadableScreen(
        visible: !_loading,
        child: new Center(
          child: new Stack(
            alignment: Alignment.center,
            children: cards
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed(ParticipantsScreen.tag);
      }),
    );
  }
}
