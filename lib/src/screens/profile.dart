import 'package:flutter/material.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My Profile"),
      ),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Column(
          children: [
            Text("hi")
          ],
          ),
          Column(
            children: [
              Text("Laura Davis\n"),
              Text("lauragrace949@gmail.com")
            ]
            )
    ]
      )
    );
  }
}
