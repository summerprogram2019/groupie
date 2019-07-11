//This page shows a list of all of the events a user has
// added to their list of events. (Events are added by swiping right on the main page)
import 'package:flutter/material.dart';
import 'package:groupie/model.dart' show User;
import 'package:groupie/widgets.dart' show GroupieProfile, LoadableScreen;
import 'package:groupie/screens.dart' show ProfileScreen, ScreenArguments;
import 'package:groupie/util.dart'
    show
    GroupieColours,
    getApprovedParticipants,
    getPendingParticipants,
    getImageUrl;

class UpcomingEvents extends StatefulWidget {
  final String title;

  static String tag = "upcomingEvents";

  UpcomingEvents({Key key, this.title}) : super(key: key);

  @override
  _UpcomingEventsState createState() => new _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  List<User> approved = [];
  List<User> pending = [];

  List<Widget> approvedWidgets = [];
  List<Widget> pendingWidgets = [];

  bool _approvedLoaded = false;
  bool _pendingLoaded = false;

  _UpcomingEventsState() : super() {
    getApprovedParticipants(2).then((participants) {
      buildUserList(participants).then((widgets) {
        setState(() {
          approvedWidgets = widgets;
          _approvedLoaded = true;
        });
      });
    });
    getPendingParticipants(2).then((participants) {
      buildUserList(participants).then((widgets) {
        setState(() {
          pendingWidgets = widgets;
          _pendingLoaded = true;
        });
      });
    });
  }

  Future<List<Widget>> buildUserList(List<User> users) async {
    List<Widget> cards = [];

    for (User user in users) {
      ImageProvider image = NetworkImage(await getImageUrl(int.parse(user.pictureId)));
      cards.add(GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(ProfileScreen.tag, arguments: ScreenArguments(user)),
          child: Card(
              child: new Row(
                children: <Widget>[
                  GroupieProfile(image),
                  Expanded(
                    child: Center(
                        child: Column(
                            children: [
                              Text(user.givenName + " " + user.familyName,
                                  style: new TextStyle(
                                    color: GroupieColours.grey69,
                                    fontSize: 12.0,
                                  )
                              ),
                              Text(user.city + ", " + user.country),
                            ]
                        )
                    ),
                  )
                ],
              )
          )
      )
      );
    }

    return cards;
  }

  Widget buildPending(BuildContext context, int index) {
    return Text(pending[index].givenName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Upcoming Events",
            style: new TextStyle(
              color: GroupieColours.grey69,
              fontSize: 20.0,
            )),
        backgroundColor: GroupieColours.white69,
        iconTheme: new IconThemeData(color: GroupieColours.grey69),
      ),
      backgroundColor: GroupieColours.white69,
      body: Column(children: [
        SizedBox(height: 20),
        Text("Approved",
            style: new TextStyle(
                color: GroupieColours.grey69,
                fontSize: 16.0,
                fontWeight: FontWeight.w500
            )),
        LoadableScreen(
            visible: _approvedLoaded,
            child: ListView(
              children: approvedWidgets,
              shrinkWrap: true,
            )
        ),
        Text("Pending",
            style: new TextStyle(
                color: GroupieColours.grey69,
                fontSize: 16.0,
                fontWeight: FontWeight.w500
            )),
        LoadableScreen(
            visible: _pendingLoaded,
            child: ListView(
              children: pendingWidgets,
              shrinkWrap: true,
            )
        ),
      ]),
    );
  }
}
