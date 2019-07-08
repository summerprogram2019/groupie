import 'package:flutter/material.dart';

import 'package:groupie/util.dart' show GroupieColours;

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

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
        title: new Text("Edit Profile",
        style: new TextStyle(
          color: GroupieColours.grey69,
          fontSize: 20.0,)),
    backgroundColor: GroupieColours.white69,
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
              )
            ],
          ),
        ],
      )
    );
  }
}