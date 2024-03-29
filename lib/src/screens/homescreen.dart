import 'package:flutter/material.dart';

//have to add in to link to the screen
import 'settings/preferences.dart';
import 'settings/profile.dart';

import 'events/participants.dart';
import 'events/upcomingEvents.dart';

import 'package:groupie/widgets.dart' show EventCard, LoadableScreen, CircleButton;
import 'package:groupie/model.dart' show Event;
import 'package:groupie/screens.dart' show CreateNewEventMajorPage;
import 'package:groupie/util.dart' show GroupieColours, getEvents, acceptEvent, getEventImageById;

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
        _cardScreen = new CardsScreen(events, () {
          setState(() {
            _loading = false;
          });
        });
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
  void _openAddEvent() {
    Navigator.pushNamed(context, CreateNewEventMajorPage.tag);
  }
  void _openPreferences() {
    Navigator.pushNamed(context, PreferencesScreen.tag);
  }
  void _openUpcomingEvents(){
    Navigator.pushNamed(context, UpcomingEvents.tag);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            //a widget which has the same height as the app bar
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    CircleButton((){_openPreferences();},Icons.brightness_low, 'Open Preferences'),

                    CircleButton((){_openUpcomingEvents();},Icons.calendar_today, 'Open Upcoming Events'),

                    CircleButton((){_openAddEvent();},Icons.add, 'Create Event'),

                  ],
                ),
                //to add some spacing from between the links and the bottom of the appbar
                Container(
                  height: 10,
                )
              ],
            ),


            backgroundColor: GroupieColours.white69,
            iconTheme: new IconThemeData(color: GroupieColours.grey69),
            automaticallyImplyLeading: false,

          ),
          //sets the height of the appbar
          preferredSize: Size.fromHeight(80)
      ),

      body: new LoadableScreen(
        visible: !_loading,
        child: _cardScreen
      ),
    );
  }
}


class CardsScreen extends StatefulWidget {
  final List<Event> events;
  final Function callback;

  CardsScreen(this.events, this.callback) : super();

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
    Map<int, Widget> eventWidgets = {};

    for (Event event in events) {
      getEventImageById(event).then((image) {
        setState(() {
          this.widget.callback();
          eventWidgets[-1] = new Center(child: new Text("Nothing to display"));
          eventWidgets[event.id] = EventCard(event, image,
            remove: () {
              setState(() {
                eventWidgets.remove(event.id);
              });
            },
          );
        });
      });
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
                  child: DragTarget<Event>(
                    builder: (a, b, c) => Container(width: 150),
                    onWillAccept: (data) => true,
                    onAccept: (data) {
                      Scaffold.of(context).showSnackBar(rejectSnack);
                    },
                  )
              ),
              Spacer(),
              Flexible(
                  child: DragTarget<Event>(
                    builder: (a, b, c) => Container(width: 150),
                    onWillAccept: (data) => true,
                    onAccept: (data) {
                      acceptEvent(data);
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
