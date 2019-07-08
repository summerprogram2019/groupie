import 'package:flutter/material.dart';

import 'package:groupie/screens.dart' show HomePage;

class CreateEventSecondScreen extends StatefulWidget {
  final String title;

  static String tag = "createEventSecond🐢";

  CreateEventSecondScreen({Key key, this.title}) : super(key: key);

  @override
  _CreateEventSecondScreenState createState() => new _CreateEventSecondScreenState();
}

class _CreateEventSecondScreenState extends State<CreateEventSecondScreen> {
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
                ],
              ),
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
