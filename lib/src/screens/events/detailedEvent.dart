//the screen shown when a user selects one of their chosen events
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:groupie/screens.dart' show LoginScreen, ParticipantsScreen;
import 'package:groupie/util.dart' show GroupieColours, logout;
import 'package:groupie/widgets.dart' show DescriptionCard, DetailsCard, LinkCard;

//for persist functionality
import 'package:shared_preferences/shared_preferences.dart';

//look into using a 'hero' to animate from the events list to the detailedEvent screen

class DetailedEventScreen extends StatefulWidget {
  final String title;
  static String tag = "detailedEvent";

  DetailedEventScreen({Key key, this.title}) : super(key: key);

  @override
  _DetailedEventScreenState createState() {
    return new _DetailedEventScreenState();
  }
}

class _DetailedEventScreenState extends State<DetailedEventScreen> {
  _DetailedEventScreenState() : super();

  var futureEventTime = new DateTime(2019, 7, 11);

  //the values for the switches and sliders
  bool _silenceNotificationToggle = false;
  bool _pushNotificationToggle = false;

  double _maxCost;
  var _maxCostString = '';

  double _maxDistance;
  var _maxDistanceString = '';

  //load the values for preferences from persist
  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _maxCost = (prefs.getDouble('maxCost') ?? 50);
      _maxDistance = (prefs.getDouble('maxDistance') ?? 10);
      _maxCostString = '\$' + _maxCost.toStringAsFixed(0);
      _maxDistanceString = _maxDistance.toStringAsFixed(0) + ' km';
      _silenceNotificationToggle = (prefs.getBool('NOTIFICATION_TOGGLE') ?? false);
      _pushNotificationToggle = (prefs.getBool('PUSH_TOGGLE') ?? false);
    });
  }

  @override
  void initState() {
    super.initState();
    //todo change what is loaded
    _loadPreferences();
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
          DescriptionCard('Description',
              'The Jindamurry mountain range east of the big smoke has large '
                  'campsites available. The range is called Jindamurry and '
                  'we\'ll be staying at West Chemer Parklands site 6. Looking '
                  'to set up a campfire but there should be some amenities '
                  'available around the campsite.',
              Theme.of(context).textTheme.subhead
          ),

          //Details of Event
          DetailsCard(
              'Details',
              'Location:', (){return 'Chemer Parklands, Brisbane';},
              'Time:', (){return futureEventTime.toString();},
              'Countdown: ', (){return futureEventTime.difference(DateTime.now()).toString() + ' days';},
              Theme.of(context).textTheme.subhead
          ),


          //todo sync requirements data from server for specific event
          //Requirements of event
          DetailsCard(
              'Requirements',
              'Participants:', (){return '5-10';},
              'Estimated Cost:', (){return 'Free';},
              'Age Restriction: ', (){return '18-30';},
              Theme.of(context).textTheme.subhead
          ),

          LinkCard('View Participants', _goToParticipants),

          LinkCard('Leave Event', _leaveEvent, Theme.of(context).textTheme.body2),

        ],
      ),
    );
  }
}
