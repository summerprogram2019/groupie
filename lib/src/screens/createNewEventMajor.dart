import 'package:flutter/material.dart';

import 'package:groupie/screens.dart' show HomePage;

class CreateNewEventMajorPage extends StatefulWidget {
  final String title;

  static String tag = "createNewEventMajor";

  CreateNewEventMajorPage({Key key, this.title}) : super(key: key);

  @override
  _CreateNewEventMajorPageState createState() =>
      new _CreateNewEventMajorPageState();
}

class _CreateNewEventMajorPageState extends State<CreateNewEventMajorPage> {
  final FocusNode focus = FocusNode();

  /// Retrieves the text in the event's name entry field
  final TextEditingController eventNameController = new TextEditingController();

  /// Retrieves the text in the event's location entry field
  final TextEditingController eventLocationController =
      new TextEditingController();

  /// Retrieves the text in the event's start-time entry field
  final TextEditingController eventStartTimeController =
      new TextEditingController();

  /// Retrieves the text in the event's finish-time entry field
  final TextEditingController eventFinishTimeController =
      new TextEditingController();

  /// Retrieves the text in the event's description entry field
  final TextEditingController eventDescriptionController =
      new TextEditingController();

  Widget buildRow(String text, IconData icon, {style}) {
    if (text == null) {
      return new Padding(padding: EdgeInsets.all(0.0));
    }

    style = style ?? new TextStyle(color: Colors.black54);
    return new Row(
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new Icon(icon, color: Colors.black54)),
        new Expanded(
            child: new Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child:
                    new Text(text, textAlign: TextAlign.center, style: style)),
            key: Key('expanded'))
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
    // the event's name entry field
    final eventName = TextFormField(
      key: Key('eventName_field'),
      keyboardType: TextInputType.text,
      focusNode: focus,
      controller: eventNameController,
      decoration: InputDecoration(
        labelText: "Bowling, bar or other...",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
        ),
      ),
    );

    // the event's name entry field
    final eventLocation = TextFormField(
      key: Key('eventLocation_field'),
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: eventLocationController,
      decoration: InputDecoration(
        labelText: "e.g. ChengYuan waterpark",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
        ),
      ),
    );

    // the event's name entry field
    final eventStartTime = TextFormField(
      key: Key('eventStartTime_field'),
      keyboardType: TextInputType.datetime,
      autofocus: false,
      controller: eventStartTimeController,
      decoration: InputDecoration(
        labelText: "Start-time",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
        ),
      ),
    );

    // the event's name entry field
    final eventFinishTime = TextFormField(
      key: Key('eventFinishTime_field'),
      keyboardType: TextInputType.datetime,
      autofocus: false,
      controller: eventFinishTimeController,
      decoration: InputDecoration(
        labelText: "Finish-time",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
        ),
      ),
    );

    // the event's name entry field
    final eventDescription = TextFormField(
      key: Key('eventDescription_field'),
      keyboardType: TextInputType.text,
      autofocus: false,
      maxLines: 5,
//      expands: true,
      controller: eventDescriptionController,
      decoration: InputDecoration(
        labelText: "Description",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
        ),
      ),
    );


    final continueButton = RaisedButton(
      key: Key('continue_button'),
      child: Text(
        'Continue',
        style: TextStyle(color: Colors.black),
      ),
      color: Colors.white,
      onPressed: () {
        Navigator.of(context).pushNamed(CreateNewEventMajorPage.tag);
      },
    );

//    return Scaffold(
//        appBar: new AppBar(
//          title: new Text("Create Event"),
//        ),
//        backgroundColor: Colors.white,
//        body: Row(
//            children: [
//              Column( //CreateEventPreview Declaration goes here
//                  children: [
//                    Text("Lolkek\r\n",
//                      textAlign: TextAlign.right,
//                      style: new TextStyle(
//                        color: Colors.black,
//                        fontSize: 20.0,
//                      ),
//                    ),
//
//                    SizedBox(height: 10.0),
//                    Text("LOLOLOLOL The user can add a short bio \r\n describing themselves and "
//                        "their \r\n interests.\r\n", textAlign: TextAlign.center)
//                  ]
//              ),
//              Column(
//                  children: [
//                    editButton(context)
//                  ]
//              )
//            ]
//        )
//    );

    final double standartFontSize = 14.0;
    final double standartSmallGap = 4.0;
    final double standartBigGap = 6.0;

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Create Event"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(fit: StackFit.passthrough, children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
//              Expanded(
//                child: TextField(
//                  expands: true,
//                  maxLines: null,
//                ),
//              ),
//              Center(
//                  child: Text(
//                'Create a New Event',
//                style: TextStyle(color: Colors.black, fontSize: 30.0),
//              )),
              // Sizedboxes are used for whitespace and padding on the screen
              SizedBox(height: 8.0),
              Text('Enter Event Name',
                  style: TextStyle(color: Colors.black, fontSize: standartFontSize)),
              SizedBox(height: standartSmallGap),
              eventName,
              SizedBox(height: standartBigGap),
              Text('Set Event Location',
                  style: TextStyle(color: Colors.black, fontSize: standartFontSize)),
              SizedBox(height: standartSmallGap),
              eventLocation,
              SizedBox(height: standartBigGap),
              Text('Set Event Start-Time',
                  style: TextStyle(color: Colors.black, fontSize: standartFontSize)),
              SizedBox(height: standartSmallGap),
              eventStartTime,
              SizedBox(height: standartBigGap),
              Text('Set Event Finish-Time',
                  style: TextStyle(color: Colors.black, fontSize: standartFontSize)),
              SizedBox(height: standartSmallGap),
              eventFinishTime,
              SizedBox(height: standartBigGap),
              Text('Set Event Description',
                  style: TextStyle(color: Colors.black, fontSize: standartFontSize)),
              SizedBox(height: standartSmallGap),
              eventDescription,
              SizedBox(height: standartBigGap),
              continueButton,


//              Text('Fill fields',
//                  style: TextStyle(color: Colors.black, fontSize: standartFontSize)),
//              SizedBox(height: standartSmallGap),
//              eventName,
//              SizedBox(height: standartSmallGap),
//              eventLocation,
//              SizedBox(height: standartBigGap),
//              Text('Set Event Start-Time',
//                  style: TextStyle(color: Colors.black, fontSize: standartFontSize)),
//              SizedBox(height: standartSmallGap),
//              eventStartTime,
//              SizedBox(height: standartBigGap),
//              Text('Set Event Finish-Time',
//                  style: TextStyle(color: Colors.black, fontSize: standartFontSize)),
//              SizedBox(height: standartSmallGap),
//              eventFinishTime,
//              SizedBox(height: standartBigGap),
//              Text('Set Event Description',
//                  style: TextStyle(color: Colors.black, fontSize: standartFontSize)),
//              SizedBox(height: standartSmallGap),
//              eventDescription,


//              SizedBox(height: 8.0),
//              SizedBox(height: 8.0),
//              password,
//              SizedBox(height: 24.0),
//              forgotLabel,
//              SizedBox(height: 24.0),
//              Text(errors),
//              SizedBox(height: 24.0),
//              loginButton,
//              SizedBox(height: 24.0),
//              signupButton

//                loginButton,
//                SizedBox(height: 8.0),
//                newUser,
//                SizedBox(height: 4.0),
//                forgotLabel
            ],
          ),

//          new Offstage(
//               displays the loading icon while the user is logging in
//              offstage: !_loggingIn,
//              child: new Center(
//                  child: _loggingIn
//                      ? new CircularProgressIndicator(
//                          value: null,
//                          strokeWidth: 7.0,
//                        )
//                      : null))
        ]),
      ),
    );
  }
}
