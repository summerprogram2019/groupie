import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupie/src/util/createNewEvent.dart';
import 'package:groupie/src/util/event.dart';
import 'package:groupie/src/util/sizes.dart';
import 'package:groupie/src/util/colours.dart';

import 'package:groupie/screens.dart' show HomePage;

class CreateNewEventPreviewPage extends StatefulWidget {
  final String title;
  final Event newEvent;

  static String tag = "createNewEventPreview";

  CreateNewEventPreviewPage({Key key, this.title, this.newEvent})
      : super(key: key);

  @override
  _CreateNewEventPreviewPageState createState() =>
      new _CreateNewEventPreviewPageState();
}

class _CreateNewEventPreviewPageState extends State<CreateNewEventPreviewPage> {
  final FocusNode focus = FocusNode();

  bool _creatingNewEvent = false;

  String errors = "";

  void _createnewevent(CreateNewEventResponse response) {
    if (response.hasError) {
      setState(() {
        errors = response.error;
        _creatingNewEvent = false;
      });
    } else {
      _creatingNewEvent = false;
      Navigator.pushNamed(context, HomePage.tag);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Create Event. Preview"),
        backgroundColor: GroupieColours.logoColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(Sizes.leftPadding, Sizes.topPadding,
            Sizes.rightPadding, Sizes.bottomPadding),
        child: Stack(fit: StackFit.passthrough, children: [
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              // Sizedboxes are used for whitespace and padding on the screen
              Text(
                  'Waiting for Eliza\'s event profile page including a short information (which is for the tinder-like swipe-page)',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
              Text(errors),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
//        icon: const Icon(Icons.add),
        label: const Text(
          'Finish',
          style: TextStyle(color: GroupieColours.white69),
        ),
        onPressed: () {
          setState(() {
            _creatingNewEvent = true;
          });
          createNewEvent(widget.newEvent).then((response) {
            _createnewevent(response);
          });

//          Navigator.of(context).pushNamed(HomePage.tag);
        },
        backgroundColor: GroupieColours.logoColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}