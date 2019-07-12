//This page shows a list of all of the events a user has
// added to their list of events. (Events are added by swiping right on the main page)
import 'package:flutter/material.dart';
import 'package:groupie/model.dart' show User, Event;
import 'package:groupie/widgets.dart' show GroupieProfile, LoadableScreen, MiniEventCard;
import 'package:groupie/screens.dart' show DetailedEventScreen, EventScreenArguments;
import 'package:groupie/util.dart'
    show
    GroupieColours,
    getApprovedParticipants,
    getUpcomingEventsForUser,
    getImageUrl,
    getUserId;

class UpcomingEvents extends StatefulWidget {
  final String title;

  static String tag = "upcomingEvents";

  UpcomingEvents({Key key, this.title}) : super(key: key);

  @override
  _UpcomingEventsState createState() => new _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  List<User> events = [];

  List<Widget> eventWidgets = [];

  bool _eventsLoaded = false;

  int numOfParticipantsRequired;
  int currentNumOfParticipants;

  _getParticipantNumbers(){
    numOfParticipantsRequired = 5;
    currentNumOfParticipants = 7;

    return '(' + currentNumOfParticipants.toString() + '/' + numOfParticipantsRequired.toString() + ')';
  }

  _chooseTextColour(){
    if (currentNumOfParticipants < numOfParticipantsRequired){
      //there are less participants than the event requires, therefore red text
      return Theme.of(context).textTheme.body2;
    } else {
      return Theme.of(context).textTheme.body1;
    }
  }

  _UpcomingEventsState() : super() {
    getUserId().then((userId) {
      getUpcomingEventsForUser(userId).then((participants) {
        print(participants);
        buildEventList(participants).then((widgets) {
          setState(() {
            eventWidgets = widgets;
            _eventsLoaded = true;
          });
        });
      });
    });
  }

  Future<List<Widget>> buildEventList(List<Event> events) async {
    List<Widget> eventCards = [];

    for (Event event in events) {
      //todo add an image for each event
      getImageUrl(event.pictureId).then((image) {
        print(image);
      });
      Image eventImage = Image.network(await getImageUrl(event.pictureId));
      //todo add current number of participants calculator - could do a nice way with sql
      int noOfParticipants = (await getApprovedParticipants(event.id)).length;

      print(eventImage);

      eventCards.add(GestureDetector(
        //todo change the push screen to a generated detailedEvent page
          onTap: () => Navigator.of(context).pushNamed(DetailedEventScreen.tag,
              arguments: EventScreenArguments(event, eventImage)),
          child: new MiniEventCard(event.eventName, event.description,
              eventImage, event.location, event.start, noOfParticipants,
              event.minimumParticipants, context,
              Theme.of(context).textTheme.subhead)
      )
      );
    }

    return eventCards;
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
      body: ListView(children: [
//        MiniEventCard('Test', 'This is the description of the event',
//          Image.asset('sun.png'), 'this is the event location', DateTime.now(), 4,
//          3, context, Theme.of(context).textTheme.subhead),

        LoadableScreen(
            visible: _eventsLoaded,
            child: ListView(
              children: eventWidgets,
              shrinkWrap: true,
            )
        ),
      ]),
    );
  }
}
