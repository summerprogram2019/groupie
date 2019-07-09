import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'profile.dart';
import 'package:groupie/util.dart' show GroupieColours;

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
  _PreferencesScreenState() : super() {

  }


  void _openProfile() {
    Navigator.pushNamed(context, ProfileScreen.tag);
  }

  //the values for the switches and sliders
  bool _silenceNotificationToggle = false;
  bool _pushNotificationToggle = false;
  double _maxCost = 100.0;
  double _maxDistance = 20.0;

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
      body: new Center(
        child: new ListView(
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

            Card(
              child: Column(
                children: <Widget>[
                  Text('Maximum Cost: \$ ${_maxCost.toStringAsFixed(0)}'),

                  CupertinoSlider(
                    value: _maxCost,
                    min: 0.0,
                    max: 1000.0,
                    divisions: 50,
                    onChanged: (double value){
                      setState(() {
                        _maxCost = value;
                      });
                    },

                    onChangeEnd: (double value){
                      if (value == 0) {




                      }
                      setState(() {
                        _maxCost = value;
                      });
                    },
                  ),
                ],
              )
            ),

            Card(
                child: Column(
                  children: <Widget>[
                    const ListTile(
                        title: Text('Maximum Distance')
                    )
                  ],
                )
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
      ),
    );
  }
}
