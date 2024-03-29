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

class ParticipantsScreenArguments {
  final int eventID;

  ParticipantsScreenArguments(this.eventID);
}

class ParticipantsScreen extends StatefulWidget {
  final String title;

  static String tag = "participants🐢";

  ParticipantsScreen({Key key, this.title}) : super(key: key);

  @override
  _ParticipantsScreenState createState() => new _ParticipantsScreenState();
}

class _ParticipantsScreenState extends State<ParticipantsScreen> {
  List<User> approved = [];
  List<User> pending = [];

  List<Widget> approvedWidgets = [];
  List<Widget> pendingWidgets = [];

  bool _approvedLoaded = false;
  bool _pendingLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ParticipantsScreenArguments args = ModalRoute.of(context).settings.arguments;

    if (args == null || args.eventID == null) {
      setState(() {
        _approvedLoaded = true;
        _pendingLoaded = true;
      });
      return;
    }

    getApprovedParticipants(args.eventID).then((participants) {
      buildUserList(participants).then((widgets) {
        setState(() {
          approvedWidgets = widgets;
          _approvedLoaded = true;
        });
      });
    });
    getPendingParticipants(args.eventID).then((participants) {
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
          title: new Text("Participants",
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
