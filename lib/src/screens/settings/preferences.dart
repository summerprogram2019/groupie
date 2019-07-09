import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'profile.dart';
import 'package:groupie/util.dart' show GroupieColours;

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




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //the universal background colour
      //backgroundColor: Color.fromARGB(255, 112, 112, 112),
      backgroundColor: Theme.of(context).backgroundColor,

      appBar: new AppBar(
        title: new Text(widget.title),
        backgroundColor: GroupieColours.white69,
        actions: <Widget>[
           new IconButton(
             icon: new Icon(Icons.person_outline),
             tooltip: 'Open Profile',
             onPressed: _openProfile,
           ),
        ],
          iconTheme: new IconThemeData(color: GroupieColours.grey69)
      ),
      body: new Column(
          children: <Widget>[


            Card(
                child: InkWell(
                  onTap: _openProfile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(10.0),
                        child: Text('View your profile'),
                      ),

                      new IconButton(
                        icon: new Icon(Icons.arrow_forward_ios),
                        tooltip: 'Open Profile',
                        onPressed: _openProfile,
                      ),
                    ],
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
                            'Maximum Cost of Event:'
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                            _maxCostString
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Slider(
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
                            'Maximum Distance of Event:'
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                            _maxDistanceString
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Slider(
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

            Card(
                child: Column(
                  children: <Widget>[
                    const ListTile(
                        title: Text('Privacy Policy')
                    )
                  ],
                )
            ),

            Card(
                child: Column(
                  children: <Widget>[
                    const ListTile(
                        title: Text('Logout')
                    )
                  ],
                )
            ),

            FlatButton(
              onPressed: () {
            /*...*/
            },
              child: Text(
                "Logout",
              ),
            ),

            Card(
                child: Column(
                  children: <Widget>[
                    const ListTile(
                        title: Text('Delete Account')
                    )
                  ],
                )
            ),

          ],
        ),
      );
  }
}
