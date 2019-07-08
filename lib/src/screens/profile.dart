import 'package:flutter/material.dart';

import 'package:groupie/widgets.dart' show GroupieProfile;
import 'package:groupie/screens.dart' show HomePage;
import 'package:groupie/util.dart' show GroupieColours;

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

  void _open_edit_screen() {
    Navigator.pushNamed(context, ProfileScreen.tag);
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
              onPressed: _open_edit_screen,
            ),
          ]
      ),
      backgroundColor: GroupieColours.white69,
      body: ListView(
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
          new Row(
            children: <Widget>[
              Expanded(
              child: Card(
                child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0),
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0))),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                child: RichText(
                                text: TextSpan(
                                    text: "Profile Name\r\n",
                                    style: new TextStyle(
                                      color: GroupieColours.darkText,
                                      fontSize: 15.0),
                                    children: [
                                      TextSpan(text: 'Daisy', style: new TextStyle(
                                          color: GroupieColours.grey69,
                                          fontSize: 18.0))
                                    ]
                                ),
                                )
                                )
                              ],
                            )
                )
                )
              )
            ],
          ),
          SizedBox(height: 8.0),
          new Row(
            children: <Widget>[
              Expanded(
              child: Card(
                  child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0),
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0))),
                      child: Row(
                        children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: RichText(
                            text: TextSpan(
                                text: "Bio\r\n",
                                style: new TextStyle(
                                    color: GroupieColours.darkText,
                                    fontSize: 15.0),
                                children: [
                                  TextSpan(text: 'Living, laughting and '
                                      'loving life!', style: new TextStyle(
                                      color: GroupieColours.grey69,
                                      fontSize: 18.0))
                                ]
                            ),
                          )
                      )
                        ],
                      )
                  )
              )
              )
            ],
          ),
          SizedBox(height: 8.0),
          new Row(
            children: <Widget>[
              Expanded(
                  child: Card(
                  child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0),
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0))),
                      width: 80.0,
                      child: Row(
                        children: <Widget>[
                          Padding(
                      padding: EdgeInsets.all(10.0),
                          child: RichText(
                            text: TextSpan(
                                text: "Location\r\n",
                                style: new TextStyle(
                                    color: GroupieColours.darkText,
                                    fontSize: 15.0),
                                children: [
                                  TextSpan(text: 'Chengdu, China', style: new TextStyle(
                                      color: GroupieColours.grey69,
                                      fontSize: 18.0))
                                ]
                            ),
                          )
                          )
                        ],
                      )
                  )
                  )
              )
            ],
          ),
          SizedBox(height: 8.0),
          new Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0),
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0))),
                      width: 80.0,
                      child: Row(
                        children: <Widget>[
                        Padding(
                        padding: EdgeInsets.all(10.0),
                          child: RichText(
                              text: TextSpan(
                                  text: "Contact Details\r\n",
                                  style: new TextStyle(
                                      color: GroupieColours.darkText,
                                      fontSize: 15.0),
                                  children: [
                                    TextSpan(text: 'ph. 0845 349 235\r\n'
                                        'Em. DaisyFlower@gmail.com',
                                        style: new TextStyle(
                                        color: GroupieColours.grey69,
                                        fontSize: 18.0))
                                  ]
                              ),
                            )
                        )
                        ],
                      )
                  )
                  )
              )
            ],
          ),
          SizedBox(height: 8.0),
          new Row(
            children: <Widget>[
              Expanded(
                  child: Card(
                  child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0),
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0))),
                      child: Row(
                        children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: RichText(
                              text: TextSpan(
                                  text: "Profile Details\r\n",
                                  style: new TextStyle(
                                      color: GroupieColours.darkText,
                                      fontSize: 15.0),
                                  children: [
                                    TextSpan(
                                        text: 'Member Since:        8/4/2019\r\n'
                                              'Events Created:             8\r\n'
                                              'Events Joined:             12',
                                        style: new TextStyle(
                                        color: GroupieColours.grey69,
                                        fontSize: 18.0)),
                                  ]
                              ),
                            ),
                      )
                        ],
                      )
                  )
              )
              ),
            ],
          ),
        viewEvents(context)
        ]
      )
    );
  }
}
