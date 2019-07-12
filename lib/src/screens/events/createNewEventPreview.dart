import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupie/src/util/createNewEvent.dart';
import 'package:groupie/src/util/dateFunctions.dart';
import 'package:groupie/src/util/event.dart';
import 'package:groupie/src/util/sizes.dart';
import 'package:groupie/src/util/colours.dart';

import 'package:groupie/screens.dart' show HomePage;
import 'package:groupie/src/model/card.dart';
import 'package:intl/intl.dart';

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

  Widget _createEventCard(Event event) {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        width: 360.0,
        height: 600.0,
        child: Column(children: [
          Text(
            event.name, //Update to load from DB
            style: new TextStyle(
              color: GroupieColours.grey69,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 10.0),
          Image.asset("sun.png"), //Update to load from DB
          SizedBox(height: 10.0),
          Center(
            child: Text(
              event.description, //Update to load from DB
              style: new TextStyle(
                color: GroupieColours.grey69,
                fontSize: 15.0,
              ),
            ),
          ),
          SizedBox(height: 18.0),
          new Row(
            children: <Widget>[
              new Column(children: [
                SizedBox(width: 10.0),
              ]),
              new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Location"),
                    Text("Date"),
                    Text("Participants"),
                    Text("Estimated Cost"),
                    Text("Age Restriction"),
                  ]),
              new Column(children: [
                SizedBox(width: 50.0),
              ]),
              new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // When database is ready, update these to take directly from there:
                    Text(event.location),
                    Text(DateFormat('dd-MM-yyyy - kk:mm')
                        .format(event.startTime)),
                    Text(event.minimumParticipantsNumber.toString() +
                        " - " +
                        event.maximumParticipantsNumber.toString()),
                    Text(event.price.toString()),
                    Text(event.minimumAge.toString() +
                        " - " +
                        event.maximumAge.toString()),
                  ]),
            ],
          ),
        ]),
      ),
    );
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
        title: new Text("Event Preview"),
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
              Card(
                elevation: 12.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  width: 360.0,
                  height: 600.0,
                  child: Column(children: [
                    Text(
                      widget.newEvent.name, //Update to load from DB
                      style: new TextStyle(
                        color: GroupieColours.grey69,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Image.asset("sun.png"), //Update to load from DB
                    SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        widget.newEvent.description, //Update to load from DB
                        style: new TextStyle(
                          color: GroupieColours.grey69,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 18.0),
                    new Row(
                      children: <Widget>[
                        new Column(children: [
                          SizedBox(width: 10.0),
                        ]),
                        new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Location"),
                              Text("Date"),
                              Text("Participants"),
                              Text("Estimated Cost"),
                              Text("Age Restriction"),
                            ]),
                        new Column(children: [
                          SizedBox(width: 50.0),
                        ]),
                        new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // When database is ready, update these to take directly from there:
                              Text(widget.newEvent.location),
//                              Text(DateFormat('dd-MM-yyyy - kk:mm').format(widget.newEvent.startTime)),
                              Text(DateFunctions.getDateString(widget.newEvent.startTime)),
                              Text(widget.newEvent.minimumParticipantsNumber
                                      .toString() +
                                  " - " +
                                  widget.newEvent.maximumParticipantsNumber
                                      .toString()),
                              Text(widget.newEvent.price.toString()),
                              Text(widget.newEvent.minimumAge.toString() +
                                  " - " +
                                  widget.newEvent.maximumAge.toString()),
                            ]),
                      ],
                    ),
                  ]),
                ),
              ),
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
