import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'profile.dart';
import 'package:groupie/screens.dart' show LoginScreen, DetailedEventScreen;
import 'package:groupie/util.dart' show GroupieColours, logout;
import 'package:groupie/widgets.dart' show LinkCard, ToggleCard, SliderCard;

//for persist functionality
import 'package:shared_preferences/shared_preferences.dart';


class PreferencesScreen extends StatefulWidget {
  final String title;
  static String tag = "preferences🐢";

  PreferencesScreen({Key key, this.title}) : super(key: key);

  @override
  _PreferencesScreenState createState() {
    return new _PreferencesScreenState();
  }
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  _PreferencesScreenState() : super();

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

  //Updating the max cost persist after change
  _storeMaxCost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble('maxCost', _maxCost);
    });
  }

  //Updating the max distance persist after change
  _storeMaxDistance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble('maxDistance', _maxDistance);
    });
  }

  //Updating the silence toggle persist after change
  _storeSilenceNotificationToggle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('NOTIFICATION_TOGGLE', _silenceNotificationToggle);
    });
  }

  //Updating the push notifications toggle persist after change
  _storePushNotificationToggle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('PUSH_TOGGLE', _pushNotificationToggle);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }


  void _openProfile() {
    Navigator.pushNamed(context, ProfileScreen.tag);
  }

  void _openDetailedEventScreen() {
    Navigator.pushNamed(context, DetailedEventScreen.tag);
  }

  //Logs the user out and returns them to the login screen
  void _logoutOfAccount(){
    Navigator.pushNamed(context, LoginScreen.tag);
    logout();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //the universal background colour
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: GroupieColours.logoColor,
        actions: <Widget>[
        ],
          iconTheme: new IconThemeData(color: Colors.white)
      ),
      body: new Column(
          children: <Widget>[

            //View your profile with modular card
            LinkCard('View your profile', _openProfile),

            //Max cost Slider
            SliderCard('Maximum Cost of Event: ', _maxCost, _maxCostString, 50, 0, 1000, (double value){
              setState(() {
                _maxCost = value;
                _maxCostString = '\$' + value.toStringAsFixed(0);

                _storeMaxCost();

                if (value == 0){
                  _maxCostString = 'Free';
                }
                if (value == 1000){
                  _maxCostString = 'No limit';
                }
              });
            },
                Theme.of(context).textTheme.subhead
            ),


            //Max Distance Slider
            SliderCard('Maximum Distance of Event: ', _maxDistance, _maxDistanceString, 20, 5, 205, (double value){
              setState(() {

                _storeMaxDistance();

                _maxDistance = value;
                _maxDistanceString = value.toStringAsFixed(0) + ' km';

                if (value == 205){
                  _maxDistanceString = 'No limit';
                }
              });
            },
                Theme.of(context).textTheme.subhead
            ),

            //Silence notification Toggle
            ToggleCard('Silence Notifications', _silenceNotificationToggle,
                    (bool value) {setState(() { _silenceNotificationToggle = value;}); _storeSilenceNotificationToggle();},
                    () { setState(() {_silenceNotificationToggle = !_silenceNotificationToggle;}); }
                    ),

            //Push notification toggle
            ToggleCard('Push Notifications', _pushNotificationToggle,
                    (bool value) {setState(() { _pushNotificationToggle = value;}); _storePushNotificationToggle();},
                    () { setState(() {_pushNotificationToggle = !_pushNotificationToggle;}); }
            ),

            //Privacy policy link (currently opens nothing)
            LinkCard('Privacy Policy', (){}),

            //to push the logout and delete account elements to the bottom of the page
            Spacer(),

            LinkCard('Logout', _logoutOfAccount),

            LinkCard('Delete Account', null, Theme.of(context).textTheme.body2),


          ],
        ),
      );
  }
}
