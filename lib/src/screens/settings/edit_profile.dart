import 'package:flutter/material.dart';

import 'package:groupie/util.dart' show GroupieColours;
import 'package:groupie/screens.dart' show HomePage;

/*
  Note: fontWeight for save/discard changes buttons set to FontWeight.w300
        font set to default
 */


class TextPrompt extends Text {
  TextPrompt(String text) : super(
    text,
    textAlign: TextAlign.left,
    style: TextStyle(
        color: GroupieColours.grey69,
        fontSize: 30.0
    )
  );
}

class TextInput extends TextFormField {
  TextInput(String key, String text) : super(
    key: Key(key),
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      labelText: text,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
        ),
      ),
    )
  );
}

class ApplyButton extends RaisedButton {
  ApplyButton({String key, String text, Color textColor, Function onPressed}) : super(
    key: Key(key),
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0)
    ),
    child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: 30.0,
              fontWeight: FontWeight.w300
          ),
        )
    ),
    color: Colors.white,
    onPressed: onPressed
  );
}

/// Initiates the edit profile screen
class EditProfile extends StatefulWidget {
  final String title;

  static String tag = "editprofile🐢";

  EditProfile({Key key, this.title}) : super(key: key);

  @override
  _EditProfileState createState() => new _EditProfileState();
}

/// Initiates the state of the edit profile screen
class _EditProfileState extends State<EditProfile> {
  _EditProfileState() : super();

  /// Button for changing the profile picture of the user
  final changeProfileImage = (context) => RaisedButton(
        key: Key('changeprofileimage_button'),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Change Profile Picture',
              style: TextStyle(color: GroupieColours.grey69, fontSize: 26.0),
            )),
        onPressed: () {
          Navigator.of(context).pushNamed(HomePage.tag);
        },
      );

  /// Button for changing the username
  final setName = TextInput("name_field", "Username");

  /// Button for changing the user's bio
  final setBio = TextInput("bio_field", "User Bio");

  /// Button for changing the user's location
  final setLocation = TextInput("location_field", "User location",);

  /// Button for changing the user's number
  final setNumber = TextInput("phNumber_field", "User Telephone Number");

  /// Button for changing the user's email
  final setEmail = TextInput("email_field", "User Email");

  /// Button for saving any changes made to the profile
  final saveChanges = (context) => ApplyButton(
        key: 'savechanges_button',
        text: 'Save Changes',
        textColor: GroupieColours.logoColor,
        onPressed: () {
          Navigator.of(context).pushNamed(EditProfile.tag);
        },
  );

  /// Button for discarding any changes the user may have begun to make
  final discardChanges = (context) => ApplyButton(
        key: 'discard_changes_button',
        text: 'Discard Changes',
        textColor: Colors.red,
        onPressed: () {
          Navigator.of(context).pushNamed(HomePage.tag);
        },
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Edit Profile",
              style: new TextStyle(
                color: GroupieColours.grey69,
                fontSize: 20.0,
              )),
          backgroundColor: GroupieColours.white69,
          iconTheme: new IconThemeData(color: GroupieColours.grey69),
        ),
        backgroundColor: GroupieColours.white69,
        body: ListView(
          children: <Widget>[
            new Row(
              children: <Widget>[
                // Current profile picture is displayed
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
                            ))))),
              ],
            ),
            //Place button
            changeProfileImage(context),
            SizedBox(height: 12.0),
            Center(
                child: new Container(
              width: 325.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Change username
                  TextPrompt("Set Profile Name"),
                  setName,
                  SizedBox(height: 6.0),
                  // Change the user's bio
                  TextPrompt("Set Bio"),
                  setBio,
                  SizedBox(height: 6.0),
                  // Change user's set location
                  TextPrompt("Set Location"),
                  setLocation,
                  SizedBox(height: 6.0),
                  // Change the user's phone number
                  TextPrompt("Set Phone Number"),
                  setNumber,
                  SizedBox(height: 6.0),
                  // Change the user's email address
                  TextPrompt("Set Email"),
                  setEmail,
                  SizedBox(height: 6.0),
                ],
              ),
            )),
            saveChanges(context),
            SizedBox(height: 12.0),
            discardChanges(context)
          ],
        ));
  }
}
