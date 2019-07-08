import 'package:flutter/material.dart';

import 'package:groupie/util.dart' show GroupieColours;
import 'package:groupie/screens.dart' show HomePage;

/*
  Initiates the edit profile screen
 */
class EditProfile extends StatefulWidget {
final String title;

static String tag = "edit profile";

EditProfile({Key key, this.title}) : super(key: key);

@override
_EditProfileState createState() => new _EditProfileState();
}

/*
  Initiates the state of the edit profile screen
 */
class _EditProfileState extends State<EditProfile> {
  _EditProfileState() : super();

  final changeProfileImage = (context) => RaisedButton(
    key: Key('changeprofileimage_button'),
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
    color: Colors.white,
    child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Change Profile Picture',
          style: TextStyle(color: GroupieColours.grey69,
              fontSize: 26.0),
        )),
    onPressed: () {
      Navigator.of(context).pushNamed(HomePage.tag);
    },
  );

  final setName = TextFormField(
    key: Key('name_field'),
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      labelText: "Username",
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
        ),
      ),
    ),
  );

  final setBio = TextFormField(
    key: Key('bio_field'),
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      labelText: "User Bio",
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
        ),
      ),
    ),
  );

  final setLocation = TextFormField(
    key: Key('location_field'),
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      labelText: "User location",
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
        ),
      ),
    ),
  );

  final setNumber = TextFormField(
    key: Key('phNumber_field'),
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: "User Telephone Number",
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
        ),
      ),
    ),
  );

  final setEmail = TextFormField(
    key: Key('email_field'),
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      labelText: "User Email",
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
        ),
      ),
    ),
  );

  final saveChanges = (context) => RaisedButton(
    key: Key('savechanges_button'),
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
    child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Save Changes',
          style: TextStyle(color: GroupieColours.logoColor,
              fontSize: 30.0),
        )),
    color: Colors.white,
    onPressed: () {
      Navigator.of(context).pushNamed(EditProfile.tag);
    },
  );

  final discardChanges = (context) => RaisedButton(
    key: Key('discard_changes_button'),
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
    child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Discard Changes',
          style: TextStyle(color: Colors.red,
              fontSize: 30.0),
        )),
    color: Colors.white,
    onPressed: () {
      Navigator.of(context).pushNamed(HomePage.tag);
    },
  );

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Edit Profile",
                style: new TextStyle(
                  color: GroupieColours.grey69,
                  fontSize: 20.0,)),
            backgroundColor: GroupieColours.white69,
            iconTheme: new IconThemeData(color: GroupieColours.grey69),
        ),
        backgroundColor: GroupieColours.white69,
        body: ListView(
        children: <Widget>[
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
              ),
            ],
          ),
          changeProfileImage(context),
          SizedBox(height: 12.0),
          Center(
            child: new Container(
              width: 325.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Set Profile Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: GroupieColours.grey69,
                      fontSize: 30.0)),
                  setName,
                  SizedBox(height: 6.0),
                  Text("Set Bio",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: GroupieColours.grey69,
                      fontSize: 30.0)),
                  setBio,
                  SizedBox(height: 6.0),
                  Text("Set Location",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: GroupieColours.grey69,
                      fontSize: 30.0)),
                  setLocation,
                  SizedBox(height: 6.0),
                  Text("Set Phone Number",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: GroupieColours.grey69,
                      fontSize: 30.0)),
                  setNumber,
                  SizedBox(height: 6.0),
                  Text("Set Email",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: GroupieColours.grey69,
                      fontSize: 30.0)),
                  setEmail,
                  SizedBox(height: 6.0),
                ],
            ),
          )
          ),
          saveChanges(context),
          SizedBox(height: 12.0),
          discardChanges(context)
          /*Expanded(
            child: new Row(
              children: <Widget>[

              ],
            )
          )*/
        ],
      )
    );
  }
}