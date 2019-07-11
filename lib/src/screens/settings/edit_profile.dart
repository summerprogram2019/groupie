import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

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
  String givenName;
  String familyName;
  String city;
  String country;
  String dob;
  String sex;

  bool _loading = true;

  ImageProvider profilePicture = AssetImage("placeholderUser.png");
  File imageFile;

  _EditProfileState() : super() {
    getUser().then(setFields);
    getProfileImageProvider().then((image) {
      setState(() {
        profilePicture = image;
      });
    });
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = image;
      profilePicture = FileImage(image);
    });
  }

  void setFields(User user) {
    setState(() {
      givenName = user.givenName;
      familyName = user.familyName;
      city = user.city;
      country = user.country;
      dob = user.dob.toString();
      sex = user.sex;
      _loading = false;
    });
  }

  final TextEditingController _givenNameController = new TextEditingController();
  final TextEditingController _familyNameController = new TextEditingController();
  final TextEditingController _cityController = new TextEditingController();
  final TextEditingController _countryController = new TextEditingController();
  final TextEditingController _dobController = new TextEditingController();
  final TextEditingController _sexController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      onPressed: getImage,
    );

    /// Button for changing the username
    final setGivenName = TextInput("given_name_field", "Given Name",
        controller: _givenNameController, placeholder: givenName);
    _givenNameController.addListener(() {
      givenName = _givenNameController.text;
    });

    final setFamilyName = TextInput("family_name_field", "Family Name",
        controller: _familyNameController, placeholder: familyName);
    _familyNameController.addListener(() {
      familyName = _familyNameController.text;
    });

    /// Button for changing the user's city
    final setCity = TextInput("city_field", "City",
        controller: _cityController, placeholder: city);
    _cityController.addListener(() {
      city = _cityController.text;
    });

    /// Button for changing the user's country
    final setCountry = TextInput("country_field", "Country",
        controller: _countryController, placeholder: country);
    _countryController.addListener(() {
      country = _countryController.text;
    });

    /// Button for changing the user's dob
    final setDob = TextInput("dob_field", "Date of Birth",
        controller: _dobController, placeholder: dob);
    _dobController.addListener(() {
      dob = _dobController.text;
    });

    /// Button for changing the user's sex
    final setSex = TextInput("sex_field", "Sex",
        controller: _sexController, placeholder: sex);
    _sexController.addListener(() {
      sex = _sexController.text;
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
                color: Colors.white,
                fontSize: 20.0,
              )),
          backgroundColor: GroupieColours.logoColor,
          iconTheme: new IconThemeData(color: Colors.white),
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
                    // Change given name
                    setGivenName,
                    SizedBox(height: 6.0),
                    // Change family name
                    setFamilyName,
                    SizedBox(height: 6.0),
                    // Change city
                    setCity,
                    SizedBox(height: 6.0),
                    // Change country
                    setCountry,
                    SizedBox(height: 6.0),
                    // Change dob
                    setDob,
                    SizedBox(height: 6.0),
                    // Change sex
                    setSex,
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
