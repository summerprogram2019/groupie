//the screen shown when a user selects one of their chosen events
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:groupie/model.dart' show Event;
import 'package:groupie/screens.dart' show LoginScreen, ParticipantsScreen;
import 'package:groupie/src/util/dateFunctions.dart';
import 'package:groupie/util.dart' show GroupieColours, logout, getEventDetails, getEventImageProvider, getEventImageProviderById, getApprovedParticipants;
import 'package:groupie/widgets.dart' show DescriptionCard, DetailsCard, LinkCard, IconLinkCard;

//for persist functionality
import 'package:shared_preferences/shared_preferences.dart';

//look into using a 'hero' to animate from the events list to the detailedEvent screen
class EventScreenArguments {
  final Event currentEvent;
  EventScreenArguments(this.currentEvent);
}

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
  //int activityId;
  //int initiatorId;
  //DateTime creationTime;
  String eventName;
  String description;
  String location;
  DateTime start;
  //DateTime finish;
  //String rsvpTime;
  int pictureId;
  int minimumAge;
  int maximumAge;
  //bool verified;

  int numParticipants = 1;

  int minimumParticipants = 1;
  int maximumParticipants;
  int cost;

  String participantRange = '? - ?';
  String ageRange = '? - ?';

  ImageProvider eventPicture = AssetImage("placeholderUser.png");

  bool _loading = true;


  final Event event;
  var futureEventTime = new DateTime(2019, 7, 11);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final EventScreenArguments args = ModalRoute.of(context).settings.arguments;

    if (args == null || args.currentEvent == null) {
        setupDisplay(Event.fromJson({
          'eventName' : "",
          'description' : "",
          'location' : DateTime.now().toIso8601String(),
          'start' : "",
          'minimumAge' : "?",
          'maximumAge' : "?",
          'minimumParticipants' : 1,
          'maximumParticipants' : 99,
          'cost' : 999,
          'pictureId' : '',
          'numParticipants' : 0
        }));

      getEventImageProvider().then((image) {
        setState(() {
          eventPicture = image;
        });
      });
    } else {
      getEventDetails(args.currentEvent.id).then(setupDisplay);
      setupDisplay(args.currentEvent);
      getEventImageProviderById(args.currentEvent).then((image) {
        setState(() {
          eventPicture = image;
        });
      });
      getApprovedParticipants(args.currentEvent.activityId).then((participants) {
        setState(() {
          numParticipants = participants.length;
        });
      });
    }
  }

  void setupDisplay(Event event) {
    setState(() {
      pictureId = event.pictureId;
      minimumAge = event.minimumAge;
      maximumAge = event.maximumAge;
      eventName = event.eventName;
      location = event.location;
      description = event.description;
      start = event.start;
      minimumParticipants = event.minimumParticipants;
      maximumParticipants = event.maximumParticipants;
      cost = event.cost;

      participantRange = minimumParticipants.toString() + ' - ' + maximumParticipants.toString();
      ageRange = minimumAge.toString() + " - " + maximumAge.toString();

      _loading = false;


      //Moving Eliza's Code
      _eventDescription = event.description;
      _eventLocation = event.location;
      _eventStart = DateFunctions.getDateString(event.start);

      if (event.minimumParticipants == null && event.maximumParticipants == null){
        _eventParticipants = "No limit";
      } else if (event.minimumParticipants == null){
        _eventParticipants = "1 - " + event.maximumParticipants.toString();
      } else if (event.maximumParticipants == null){
        _eventParticipants = event.minimumParticipants.toString() + " +";
      } else{
        _eventParticipants = event.minimumParticipants.toString() + " - " + event.maximumParticipants.toString();
      }

      if (event.cost == -20){
        _eventCost = "Free";
      } else if (event.cost == -100){
        _eventCost = "Unknown";
      } else {
        _eventCost = event.cost.toString();
      }

      if (event.minimumAge == null && event.maximumAge == null){
        _eventAge = "No limit";
      } else if (event.minimumAge == null){
        _eventAge = "13 - " + event.maximumAge.toString();
      } else if (event.maximumAge == null){
        _eventAge = event.minimumAge.toString() + " +";
      } else{
        _eventAge = event.minimumAge.toString() + " - " + event.maximumAge.toString();
      }

      futureEventTime = event.start;
    });
  }

  //todo make live updating
  _getParticipantNumbers(){
    return '(' + numParticipants.toString() + '/' + minimumParticipants.toString() + ')';
  }

  _chooseTextColour(){
    if (numParticipants < minimumParticipants){
      //there are less participants than the event requires, therefore red text
      return Theme.of(context).textTheme.body2;
    } else {
      return Theme.of(context).textTheme.body1;
    }
  }

  @override
  void initState() {
    super.initState();
    //todo change what is loaded
  }

  //the values for the switches and sliders
  String _eventDescription = "";
  String _eventLocation = "";
  String _eventStart = "";
  String _eventParticipants = "";
  String _eventCost = "";
  String _eventAge = "";

  _DetailedEventScreenState(this.event) : super() {
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
          Card(
            child: Image.asset('assets/hiking.jpg'),
          ),


          //Description of event
          DescriptionCard('Description', description,
              Theme.of(context).textTheme.subhead
          ),

          //Details of Event
          DetailsCard(
              'Details',
              'Location:', (){return _eventLocation;},
              'Time:', (){return _eventStart;},
              'Countdown: ', (){return futureEventTime.difference(DateTime.now()).inDays.toString() + ' days';},
              Theme.of(context).textTheme.subhead
          ),


          //todo sync requirements data from server for specific event
          //Requirements of event
          DetailsCard(
              'Requirements',
              'Participants:', (){return participantRange;},
              'Estimated Cost:', (){return cost.toString();},
              'Age Restriction: ', (){return _eventAge;},
              Theme.of(context).textTheme.subhead
          ),

          //todo add in live update to participant number based on event
          IconLinkCard('View Participants', _getParticipantNumbers(), _chooseTextColour(), Icons.perm_identity,  _goToParticipants),

          LinkCard('Leave Event', _leaveEvent, Theme.of(context).textTheme.body2),

        ],
      ),
    );
  }
}
