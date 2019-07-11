import 'package:flutter/material.dart';

//have to add in to link to the screen
import 'settings/preferences.dart';
import 'settings/profile.dart';

import 'package:groupie/widgets.dart' show EventCard, LoadableScreen;
import 'package:groupie/model.dart' show Event;
import 'package:groupie/screens.dart' show CreateNewEventMajorPage;
import 'package:groupie/util.dart' show GroupieColours, getEvents;

class HomePage extends StatefulWidget {
  final String title;
  static String tag = "homepage??";

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() {

    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Widget _cardScreen = new Container();

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    getEvents().then((events) {
      setState(() {
        _cardScreen = new CardsScreen(events);
        _loading = false;
      });
    }).catchError((error) {
      setState(() {
        _cardScreen = new Center(
          child: Text("Error loading events"),
        );
        _loading = false;
      });
    });
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
//            title: new Text(widget.title, style: new TextStyle(
//            color: GroupieColours.grey69)),
        backgroundColor: GroupieColours.logoColor,
        centerTitle: true,
        actions: <Widget>[
          Center(
            child:
              new Row(
                children: [
                  new IconButton(
                    icon: new Icon(Icons.brightness_low),
                    iconSize: 45.0,
                    tooltip: 'Open Preferences',
                    onPressed: _openPreferences,
                  ),
                  new IconButton(
                    icon: new Icon(Icons.calendar_today),
                    iconSize: 43.0,
                    tooltip: 'Open Preferences',
                    onPressed: _openPreferences,
                  ),
                   new IconButton(
                     icon: new Icon(Icons.person_outline),
                     iconSize: 49.0,
                     tooltip: 'Open Profile',
                     onPressed: _openProfile,
                   ),
                ],
              ),
          ),
        ],
        iconTheme: new IconThemeData(color: GroupieColours.grey69),
        automaticallyImplyLeading: false,
      ),
      body: new LoadableScreen(
        visible: !_loading,
        child: _cardScreen
      ),
      floatingActionButton: new FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed(CreateNewEventMajorPage.tag);
      }),
    );
  }
}


class CardsScreen extends StatefulWidget {
  final List<Event> events;

  CardsScreen(this.events) : super();

  @override
  _CardsScreenState createState() {
    return new _CardsScreenState(events);
  }
}

class _CardsScreenState extends State<CardsScreen> {
  Map<int, Widget> _cards;

  final acceptSnack = SnackBar(content: Text('Event accepted!'));
  final rejectSnack = SnackBar(content: Text('Event rejected!'));

  _CardsScreenState(List<Event> events) : super() {
    Map<int, Widget> eventWidgets = {
      -1: new Center(child: new Text("Nothing to display"))
    };

    for (Event event in events) {
      eventWidgets[event.id] = EventCard(event,
        remove: () {
          setState(() {
            eventWidgets.remove(event.id);
          });
        },
      );
    }

    _cards = eventWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
        children: [
          new Center(
            child: new Stack(
                alignment: Alignment.center,
                children: _cards.values.toList()
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
                      Scaffold.of(context).showSnackBar(rejectSnack);
                    },
                  )
              ),
              Spacer(),
              Flexible(
                  child: DragTarget(
                    builder: (a, b, c) => Container(width: 150),
                    onAccept: (data) {
                      Scaffold.of(context).showSnackBar(acceptSnack);
                    },
                  )
              ),
            ],
          )
        ]
    );
  }
}
