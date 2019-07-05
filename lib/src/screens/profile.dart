import 'package:flutter/material.dart';

import 'package:groupie/widgets.dart' show GroupieProfile;
import 'package:groupie/screens.dart' show HomePage;

class ProfileScreen extends StatefulWidget {
  final String title;

  static String tag = "profile";

  ProfileScreen({Key key, this.title}) : super(key: key);

  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Widget buildRow(String text, IconData icon, {style}) {
    if (text == null) {
      return new Padding(padding: EdgeInsets.all(0.0));
    }

    style = style ?? new TextStyle(
        color: Colors.black54
    );
    return new Row(
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new Icon(icon, color: Colors.black54)
        ),
        new Expanded(
            child: new Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: new Text(text,
                    textAlign: TextAlign.center,
                    style: style
                )
            ),
            key: Key('expanded')
        )
      ],
    );
  }

  Widget buildRowPadding(String context) {
    if (context == null) {
      return new Padding(padding: EdgeInsets.all(0.0));
    }

    return new Padding(padding: EdgeInsets.only(bottom: 20.0));
  }

  final profile = new GroupieProfile(); //Profile picture

  final editButton = (context) => RaisedButton(
    key: Key('edit_button'),
    child: Text(
      'Edit',
      style: TextStyle(color: Colors.grey),
    ),
    color: Colors.white,
    shape: new CircleBorder(),
    onPressed: () {
      Navigator.of(context).pushNamed(HomePage.tag);
    },
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My Profile"),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Row(
          children: <Widget>[
            Column(
              children: [ //Profile pic goes here
                //SizedBox(width: 4.0),
                new Container(
                    width: 80,
                    height: 80,
                    child: new ClipOval(
                        child: Image.asset('laura.jpg',
                            fit: BoxFit.cover)
                    )
                )
              ],),
            Expanded(
              child: Column( //Profile Declaration goes here
                  children: [
                    Text("Username\r\n",
                      textAlign: TextAlign.right,
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),

                    SizedBox(height: 10.0),
                    Text("The user can add a short bio \r\n describing themselves and "
                        "their \r\n interests.\r\n", textAlign: TextAlign.right)
                  ]
              ),
            ),
            Column(
                children: [
                  editButton(context)
                ]
            )
          ],
          ),
          Row(
                children:[
                  Expanded(
                    child: Column(
                      children: [
                        Text("Top Activities",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,)
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          
                        ],
                      )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text("Connections",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,)
                      )
                    ],
                  )
    ],
          )
    ]
      )
    );
  }
}
