import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupie/src/util/sizes.dart';
import 'package:groupie/src/util/colours.dart';

import 'package:groupie/screens.dart' show HomePage;
import 'package:groupie/model.dart' show Event;

/// SUPERSEDED: see detailedEvent.dart
class CreateNewEventPreviewPage extends StatefulWidget {
  final String title;

  final Event event;

  static String tag = "createNewEventMPreview";

  CreateNewEventPreviewPage({Key key, this.title, this.event}) : super(key: key);

  @override
  _CreateNewEventPreviewPageState createState() =>
      new _CreateNewEventPreviewPageState(event);
}

class _CreateNewEventPreviewPageState extends State<CreateNewEventPreviewPage> {
  final FocusNode focus = FocusNode();

  final Event event;

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

  _CreateNewEventPreviewPageState(this.event) : super() {
    eventNameController.text = event.eventName;
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
                  'Waiting for Leon\'s event profile page with short information',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
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
          Navigator.of(context).pushNamed(HomePage.tag);
        },
        backgroundColor: GroupieColours.logoColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
