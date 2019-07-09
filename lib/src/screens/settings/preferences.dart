import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'profile.dart';
import 'package:groupie/screens.dart' show LoginScreen;
import 'package:groupie/util.dart' show GroupieColours, logout;


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
            //View your profile
            Card(
                child: InkWell(
                  onTap: _openProfile,
                  child: ListTile(
                    title: Text(
                        'View your profile',
                        style: Theme.of(context).textTheme.subhead
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.arrow_forward_ios),
                      tooltip: 'Open Profile',
                      onPressed: _openProfile,
                    ),
                  ),
                )
            ),

            //Max cost Slider
            Card(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          //'Maximum Cost: \$ ${_maxCostString}',
                            'Maximum Cost of Event:',
                            style: Theme.of(context).textTheme.subhead
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                            _maxCostString,
                            style: Theme.of(context).textTheme.subhead
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CupertinoSlider(
                      //sets to 0 if null on first build to avoid null assert exception
                      value: _maxCost ?? 0,
                      min: 0,
                      max: 1000,
                      divisions: 50,
                      onChanged: (double value){
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
                    ),
                  )
                ],
              ),
            ),

            //max distance slider
            Card(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          //'Maximum Cost: \$ ${_maxCostString}',
                            'Maximum Distance of Event:',
                            style: Theme.of(context).textTheme.subhead
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                            _maxDistanceString,
                            style: Theme.of(context).textTheme.subhead
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CupertinoSlider(
                      //sets to 0 if null on first build to avoid null assert exception
                      value: _maxDistance ?? 5,
                      min: 5,
                      max: 200,
                      divisions: 20,
                      onChanged: (double value){
                        setState(() {

                          _storeMaxDistance();

                          _maxDistance = value;
                          _maxDistanceString = value.toStringAsFixed(0) + ' km';

                          if (value == 200){
                            _maxDistanceString = 'No limit';
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),

            //Silence notification Toggle
            Card(
                child: Column(
                  children: <Widget>[
                    MergeSemantics(
                      child: ListTile(
                        title: Text('Silence Notifications'),
                        trailing: CupertinoSwitch(
                          value: _silenceNotificationToggle,
                          onChanged: (bool value) {
                            setState(() { _silenceNotificationToggle = value;
                            });

                            _storeSilenceNotificationToggle();
                            },
                        ),
                        onTap: () { setState(() {
                          _silenceNotificationToggle = !_silenceNotificationToggle;
                        }); },
                      ),
                    )
                  ],
                )
            ),

            //Push notification toggle
            Card(
                child: Column(
                  children: <Widget>[
                    MergeSemantics(
                      child: ListTile(
                        title: Text('Push Notifications'),
                        trailing: CupertinoSwitch(
                          value: _pushNotificationToggle,
                          onChanged: (bool value) {
                            setState(() { _pushNotificationToggle = value;
                            _storePushNotificationToggle();
                            }); },
                        ),
                        onTap: () { setState(() { _pushNotificationToggle = !_pushNotificationToggle; }); },
                      ),
                    )
                  ],
                )
            ),

            //Privacy policy link
            Card(
                child: InkWell(
                  onTap: _openProfile,
                  child: ListTile(
                    title: Text(
                        'Privacy Policy',
                        style: Theme.of(context).textTheme.subhead
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.arrow_forward_ios),
                      tooltip: 'Open Profile',
                      onPressed: _openProfile,
                    ),
                  ),
                )
            ),

            //to push the logout and delete account elements to the bottom of the page
            Spacer(),

            Card(
                child: InkWell(
                  onTap: _logoutOfAccount,
                  child: ListTile(
                    title: Text(
                        'Logout',
                        style: Theme.of(context).textTheme.subhead
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.arrow_forward_ios),
                      tooltip: 'Logout of Account',
                    ),
                  ),
                )
            ),

            Card(
                child: InkWell(
                  onTap: (){print("Deleting account");},
                  child: ListTile(
                    title: Text(
                        'Delete Account',
                        style: Theme.of(context).textTheme.body2
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.arrow_forward_ios),
                      tooltip: 'Delete Account',
                    ),
                  ),
                )
            ),



          ],
        ),
      );
  }
}
