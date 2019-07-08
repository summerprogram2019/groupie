import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'profile.dart';
import 'package:groupie/util.dart' show GroupieColours;

class PreferencesScreen extends StatefulWidget {
  final String title;
  static String tag = "preferences";

  PreferencesScreen({Key key, this.title}) : super(key: key);

  @override
  _PreferencesScreenState createState() {

    return new _PreferencesScreenState();
  }
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  _PreferencesScreenState() : super() {

  }


  void _openProfile() {
    Navigator.pushNamed(context, ProfileScreen.tag);
  }

  //the values for the switches and sliders
  bool _silenceNotificationToggle = false;
  bool _pushNotificationToggle = false;

  double _maxCost = 100;
  var _maxCostString = '100';


  double _maxDistance = 20;
  var _maxDistanceString = '20';

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
        ]
      ),
      body: new Column(
          children: <Widget>[


            Card(
                child: Column(
                  children: <Widget>[
                    const ListTile(
                        title: Text('View your profile')
                    )
                  ],
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
                      value: _maxCost,
                      min: 0,
                      max: 1000,
                      divisions: 50,
                      onChanged: (double value){
                        setState(() {
                          _maxCost = value;
                          _maxCostString = '\$' + value.toStringAsFixed(0);

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
                      value: _maxDistance,
                      min: 0,
                      max: 200,
                      divisions: 20,
                      onChanged: (double value){
                        setState(() {
                          _maxDistance = value;
                          _maxDistanceString = value.toStringAsFixed(0) + ' km';

                          if (value == 0){
                            _maxDistanceString = 'Free';
                          }
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

            Card(
                child: Column(
                  children: <Widget>[
                    MergeSemantics(
                      child: ListTile(
                        title: Text('Silence Notifications'),
                        trailing: CupertinoSwitch(
                          value: _silenceNotificationToggle,
                          onChanged: (bool value) { setState(() { _silenceNotificationToggle = value; }); },
                        ),
                        onTap: () { setState(() { _silenceNotificationToggle = !_silenceNotificationToggle; }); },
                      ),
                    )
                  ],
                )
            ),

            Card(
                child: Column(
                  children: <Widget>[
                    MergeSemantics(
                      child: ListTile(
                        title: Text('Push Notifications'),
                        trailing: CupertinoSwitch(
                          value: _pushNotificationToggle,
                          onChanged: (bool value) { setState(() { _pushNotificationToggle = value; }); },
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
