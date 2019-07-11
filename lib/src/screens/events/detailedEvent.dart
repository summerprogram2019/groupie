//the screen shown when a user selects one of their chosen events
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:groupie/model.dart' show Event;
import 'package:groupie/screens.dart' show LoginScreen, ParticipantsScreen;
import 'package:groupie/util.dart' show GroupieColours, logout;
import 'package:groupie/widgets.dart' show DescriptionCard, DetailsCard, LinkCard;

//for persist functionality
import 'package:shared_preferences/shared_preferences.dart';

//look into using a 'hero' to animate from the events list to the detailedEvent screen

class DetailedEventScreen extends StatefulWidget {
  final String title;
  static String tag = "detailedEvent";

  final Event event;

  DetailedEventScreen({Key key, this.title, this.event}) : super(key: key);

  @override
  _DetailedEventScreenState createState() {
    return new _DetailedEventScreenState(event);
  }
}

class _DetailedEventScreenState extends State<DetailedEventScreen> {
  final Event event;

  var futureEventTime = new DateTime(2019, 7, 11);

  //the values for the switches and sliders
  String _eventDescription = "";
  String _eventLocation = "";
  String _eventStart = "";
  String _eventParticipants = "";
  String _eventCost = "";
  String _eventAge = "";

  double _maxCost;
  var _maxCostString = '';

  double _maxDistance;
  var _maxDistanceString = '';

  _DetailedEventScreenState(this.event) : super() {
    _eventDescription = event.description;
    _eventLocation = event.location;
    _eventStart = event.start.toString();
    _eventParticipants = event.minimumParticipants.toString() + " - " + event.maximumParticipants.toString();
    _eventCost = event.cost.toString();
    _eventAge = event.minimumAge.toString() + " - " + event.maximumAge.toString();
    futureEventTime = event.start;
  }



  //Removes user from the event, removes event from users event list and sends user to event list
  void _leaveEvent(){
    //todo push back to the events list
    Navigator.pushNamed(context, LoginScreen.tag);
    //logout();
  }

  //Goes to a particular events participants page
  void _goToParticipants(){
    //todo change screen to particular events participants page
    Navigator.pushNamed(context, ParticipantsScreen.tag);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //the universal background colour
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: new AppBar(
        //todo should have the title of the event
          title: new Text(widget.title),
          backgroundColor: GroupieColours.logoColor,
          actions: <Widget>[
          ],
          iconTheme: new IconThemeData(color: Colors.white)
      ),
      body: new ListView(
        children: <Widget>[

          //todo replace with loaded image based on event
          //Photo with curved border
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            //use Image.network to load images from webpages
            child: Image.asset('sun.png'),
          ),

          //Description of event
          //todo fetch event description based on selected event
          DescriptionCard('Description', _eventDescription,
              Theme.of(context).textTheme.subhead
          ),

          //Details of Event
          DetailsCard(
              'Details',
              'Location:', (){return _eventLocation;},
              'Time:', (){return _eventStart;},
              'Countdown: ', (){return futureEventTime.difference(DateTime.now()).toString() + ' days';},
              Theme.of(context).textTheme.subhead
          ),


          //todo sync requirements data from server for specific event
          //Requirements of event
          DetailsCard(
              'Requirements',
              'Participants:', (){return _eventParticipants;},
              'Estimated Cost:', (){return _eventCost;},
              'Age Restriction: ', (){return _eventAge;},
              Theme.of(context).textTheme.subhead
          ),

          LinkCard('View Participants', _goToParticipants),

          LinkCard('Leave Event', _leaveEvent, Theme.of(context).textTheme.body2),

        ],
      ),
    );
  }
}
