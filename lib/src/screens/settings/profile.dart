import 'package:flutter/material.dart';

import 'package:groupie/model.dart' show User;
import 'package:groupie/widgets.dart' show GroupieProfile, profileCard, LoadingIcon;
import 'package:groupie/screens.dart' show HomePage, EditProfile;
import 'package:groupie/util.dart' show GroupieColours, getUser;

class ProfileScreen extends StatefulWidget {
  final String title;

  static String tag = "profile";

  final User profile;

  ProfileScreen({Key key, this.title, this.profile}) : super(key: key);

  @override
  _ProfileScreenState createState() => new _ProfileScreenState(profile);
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name;
  String biography;
  String location;
  String contactDetails;
  String profileDetails;

  bool _loading = true;

  _ProfileScreenState(User profile) : super() {
    if (profile == null) {
      getUser().then(setupDisplay).catchError((error) {
        // TODO When I get internet connection, make this a snackbar popup instead of this hack
        setupDisplay(User.fromJson({
          "given_name": "Error Loading Data",
          "birthday": DateTime.now().toIso8601String(),
          'family_name': "",
          'country': "",
          'city': "",
          'sex': "",
          'picture_id': ""
        }));
      });
    } else {
      setupDisplay(profile);
    }
  }

  void setupDisplay(User user) {
    setState(() {
      name = user.givenName + " " + user.familyName;
      biography = "Loaded but not actually cause database doesn't support it";
      location = user.city + ", " + user.country;
      contactDetails = "Also not supported";
      profileDetails = "As above";
    });
  }

  final profile = new GroupieProfile();

  void _openEditScreen() {
    Navigator.pushNamed(context, EditProfile.tag);
  }

  final viewEvents = (context) => RaisedButton(
    key: Key('viewevents_button'),
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
    child: Padding(
      padding: EdgeInsets.all(10.0),
        child: Text(
          'View Your Created Events',
          style: TextStyle(color: GroupieColours.darkText,
          fontSize: 26.0),
        )),
    color: Colors.white,
    onPressed: () {
      Navigator.of(context).pushNamed(HomePage.tag);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My Profile",
            style: new TextStyle(
              color: GroupieColours.grey69,
              fontSize: 20.0,)),
        backgroundColor: GroupieColours.white69,

        iconTheme: new IconThemeData(color: GroupieColours.grey69),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.border_color),
              tooltip: 'Open Edit Screen',
              onPressed: _openEditScreen,
            ),
          ]
      ),
      backgroundColor: GroupieColours.white69,
      body: new Stack(
        children: [
          ListView(
            children: [
              new Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                    child: new Container(
                          width: 80.0,
                          height: 240.0,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter,
                      image: AssetImage('laura.jpg'),
                    )
                  )
                )
                    )
                  )
                ],
              ),
              SizedBox(height: 18.0),
              profileCard("Profile Name", name),
              SizedBox(height: 8.0),
              profileCard("Bio", biography),
              SizedBox(height: 8.0),
              profileCard("Location", location),
              SizedBox(height: 8.0),
              profileCard("Contact Details", contactDetails),
              SizedBox(height: 8.0),
              profileCard("Profile Details", profileDetails),
              viewEvents(context)
            ]
          ),
          LoadingIcon(_loading)
        ]
      )
    );
  }
}
