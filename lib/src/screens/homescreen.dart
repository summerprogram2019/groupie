import 'package:flutter/material.dart';

//have to add in to link to the screen
import 'settings/preferences.dart';
import 'settings/profile.dart';
import 'events/participants.dart';

import 'package:groupie/widgets.dart' show createCard;
import 'package:groupie/model.dart' show HobbyCard;
import 'package:groupie/util.dart' show GroupieColours, getUser, getUserId;

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
  List<Widget> hobbyCards = [];

  _HomePageState() : super() {
    hobbyCards = buildCards();
    getUser().then((user) {
      if (user == null) {
        return;
      }
      setState(() {
        hobbyCards.add(createCard(new HobbyCard(text: user.toJson().toString(), red: 233, green: 10, blue: 12), () {}));
      });
    });
    getUserId().then((id) {
      setState(() {
        hobbyCards.add(createCard(new HobbyCard(text: id.toString(), red: 233, green: 10, blue: 12), () {}));
      });
    });
  }

  List<Widget> buildCards() {
    return <Widget>[
      createCard(new HobbyCard(red: 233, green: 10, blue: 12), () => _removeCard(0)),
      createCard(new HobbyCard(red: 50, green: 12, blue: 11), () => _removeCard(1)),
      createCard(new HobbyCard(red: 10, green: 234, blue: 23), () => _removeCard(2)),
      createCard(new HobbyCard(red: 0, green: 192, blue: 237), () => _removeCard(3)),
    ];
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
    hobbyCards.removeAt(index);
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
      body: new Center(
        child: new Stack(
          alignment: Alignment.center,
          children: hobbyCards
        ),
      ),
      floatingActionButton: new FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed(ParticipantsScreen.tag);
      }),
    );
  }
}
