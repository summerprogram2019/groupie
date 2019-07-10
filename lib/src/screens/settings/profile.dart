import 'package:flutter/material.dart';

import 'package:groupie/model.dart' show User;
import 'package:groupie/widgets.dart' show ProfileCard, LoadingIcon;
import 'package:groupie/screens.dart' show HomePage, EditProfile;
import 'package:groupie/util.dart' show GroupieColours, getUser, getProfileImageProvider;

class ScreenArguments {
  final User profile;

  ScreenArguments(this.profile);
}

class ProfileScreen extends StatefulWidget {
  final String title;

  static String tag = "profile🐢";

  ProfileScreen({Key key, this.title}) : super(key: key);

  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name;
  String biography;
  String location;
  String contactDetails;
  String profileDetails;

  ImageProvider profilePicture = AssetImage("placeholderUser.png");

  bool _loading = true;

  _ProfileScreenState() : super() {
//    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    final ScreenArguments args = ScreenArguments(null);

    if (args.profile == null) {
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
      setupDisplay(args.profile);
    }

    getProfileImageProvider().then((image) {
      setState(() {
        profilePicture = image;
      });
    });
  }

  void setupDisplay(User user) {
    setState(() {
      name = user.givenName + " " + user.familyName;
      biography = "Loaded but not actually cause database doesn't support it";
      location = user.city + ", " + user.country;
      contactDetails = "Also not supported";
      profileDetails = "As above";
      _loading = false;
    });
  }

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
                            image: profilePicture,
                          )
                        )
                      )
                    )
                  )
                ],
              ),
              SizedBox(height: 18.0),
              ProfileCard("Profile Name", name),
              SizedBox(height: 8.0),
              ProfileCard("Bio", biography),
              SizedBox(height: 8.0),
              ProfileCard("Location", location),
              SizedBox(height: 8.0),
              ProfileCard("Contact Details", contactDetails),
              SizedBox(height: 8.0),
              ProfileCard("Profile Details", profileDetails),
              viewEvents(context)
            ]
          ),
          LoadingIcon(!_loading)
        ]
      )
    );
  }
}
