import 'package:flutter/material.dart';

import 'package:groupie/model.dart' show User;
import 'package:groupie/util.dart' show GroupieColours, getUser, getProfileImageProvider;
import 'package:groupie/widgets.dart' show LoadableScreen;
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
  TextInput(String key, String text,
      {TextEditingController controller, String placeholder}) : super(
    key: Key(key),
    controller: controller,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      labelText: text,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
        ),
      ),
    )
  ) {
    controller.text = placeholder;
    controller.addListener(() {
      placeholder = controller.text;
    });
  }
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
  String name;
  String biography;
  String location;
  String phone;
  String email;

  bool _loading = true;

  ImageProvider profilePicture = AssetImage("placeholderUser.png");

  _EditProfileState() : super() {
    getUser().then(setFields);
    getProfileImageProvider().then((image) {
      setState(() {
        profilePicture = image;
      });
    });
  }

  void setFields(User user) {
    setState(() {
      name = user.givenName + " " + user.familyName;
      biography = "uh";
      location = user.city + "," + user.country;
      phone = ":O";
      email = "🐢";
      _loading = false;
    });
  }

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

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _bioController = new TextEditingController();
  final TextEditingController _locationController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// Button for changing the username
    final setName = TextInput("name_field", "Username",
        controller: _nameController, placeholder: name);
    _nameController.addListener(() {
      name = _nameController.text;
    });

    /// Button for changing the user's bio
    final setBio = TextInput("bio_field", "User Bio",
        controller: _bioController, placeholder: biography);
    _bioController.addListener(() {
      biography = _bioController.text;
    });

    /// Button for changing the user's location
    final setLocation = TextInput("location_field", "User location",
        controller: _locationController, placeholder: location);
    _locationController.addListener(() {
      location = _locationController.text;
    });

    /// Button for changing the user's number
    final setNumber = TextInput("phNumber_field", "User Telephone Number",
        controller: _phoneController, placeholder: phone);
    _phoneController.addListener(() {
      phone = _phoneController.text;
    });

    /// Button for changing the user's email
    final setEmail = TextInput("email_field", "User Email",
        controller: _emailController, placeholder: email);
    _emailController.addListener(() {
      email = _emailController.text;
    });

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
        body: LoadableScreen(
          visible: !_loading,
          child: ListView(
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
                                image: profilePicture,
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
        )));
  }
}
