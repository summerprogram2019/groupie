import 'package:flutter/material.dart';

import 'package:groupie/screens.dart' show HomePage;

class CreateEventSecondScreen extends StatefulWidget {
  final String title;

  static String tag = "createEventSecond";

  CreateEventSecondScreen({Key key, this.title}) : super(key: key);

  @override
  _CreateEventSecondScreenState createState() => new _CreateEventSecondScreenState();
}

class _CreateEventSecondScreenState extends State<CreateEventSecondScreen> {

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
          title: new Text("My CreateEventSecond"),
        ),
        backgroundColor: Colors.white,
        body: Row(
            children: [
              Column(
                children: [ //CreateEventSecond pic goes here
                  new Container(
                      width: 80.0,
                      height: 80.0,
                      child: new ClipOval(
                          child: Image.asset('laura.jpg',
                              fit: BoxFit.cover)
                      )
                  )
                ],),
              Column( //CreateEventSecond Declaration goes here
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
                        "their \r\n interests.\r\n", textAlign: TextAlign.center)
                  ]
              ),
              Column(
                  children: [
                    editButton(context)
                  ]
              )
            ]
        )
    );
  }
}
