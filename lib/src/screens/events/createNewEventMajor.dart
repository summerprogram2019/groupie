import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:groupie/src/util/dateFunctions.dart';
import 'package:groupie/src/util/event.dart';
import 'package:groupie/src/util/sizes.dart';
import 'package:groupie/src/util/colours.dart';

import 'package:groupie/screens.dart' show HomePage, CreateNewEventMinorPage;

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
  final TextEditingController _eventNameController =
      new TextEditingController();

  /// Retrieves the text in the event's location entry field
  final TextEditingController _eventLocationController =
      new TextEditingController();

  List _activities = [
    "Mixed",
    "Play sport",
    "Bar",
    "Karaoke",
    "Cafe/restaurant",
    "Watch sport-events",
    "Cinema"
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedActivity;

  @override
  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_activities);
    _selectedActivity = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List activities) {
    List<DropdownMenuItem<String>> items = new List();
    for (String activity in activities) {
      items.add(
          new DropdownMenuItem(value: activity, child: new Text(activity)));
    }
    return items;
  }

  void changedDropDownItem(String selectedActivity) {
    setState(() {
      _selectedActivity = selectedActivity;
    });
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

  String _startTimeString = "Tap to choose";
  bool _startTimeChosen = false;
  DateTime _startTime = DateTime.now();

  String _finishTimeString = "Tap to choose";
  bool _finishTimeChosen = false;
  DateTime _finishTime = DateTime.now();

  void changeTextStartTimeButton(DateTime date) {
    setState(() {
      _startTimeString = DateFunctions.getDateString(date);
      _startTimeChosen = true;
      _startTime = date;
    });
  }

  void changeTextFinishTimeButton(DateTime date) {
    setState(() {
      _finishTimeString = DateFunctions.getDateString(date);
      _finishTimeChosen = true;
      _finishTime = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    // the event's name entry field
    final eventName = TextFormField(
      key: Key('eventName_field'),
      keyboardType: TextInputType.text,
      focusNode: focus,
      controller: _eventNameController,
      decoration: InputDecoration(
        hintText: "Enter name of event here",
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
      controller: _eventLocationController,
      decoration: InputDecoration(
        hintText: "Enter event location here",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
        ),
      ),
    );

    DateTime getStartTime() {
      if (!_startTimeChosen) {
        _startTime = DateTime.now();
      }
      return _startTime;
    }

    final startTimePicker = RaisedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context, onChanged: (date) {
            print('change $date');
          }, onConfirm: (date) {
            changeTextStartTimeButton(date);
            print('confirm $date.');
          },
              currentTime: getStartTime() /*DateTime.now()*/,
              locale: LocaleType.en);
        },
        child: Text(
          _startTimeString,
          style: TextStyle(color: GroupieColours.white69),
        ),
        color: GroupieColours.logoColor);

    DateTime getFinishTime() {
      if (!_finishTimeChosen) {
        _finishTime = DateTime.now();
      }
      return _finishTime;
    }

    final finishTimePicker = RaisedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context, onChanged: (date) {
            print('change $date');
          }, onConfirm: (date) {
            changeTextFinishTimeButton(date);
            print('confirm $date');
          },
              currentTime: getFinishTime() /*DateTime.now()*/,
              locale: LocaleType.en);
        },
        child: Text(
          _finishTimeString,
          style: TextStyle(color: GroupieColours.white69),
        ),
        color: GroupieColours.logoColor);

    final activitySelectionButton = DropdownButton(
      value: _selectedActivity,
      items: _dropDownMenuItems,
      onChanged: changedDropDownItem,
      isExpanded: true,
    );

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Create Event"),
        backgroundColor: GroupieColours.logoColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(Sizes.leftPadding, Sizes.topPadding,
            Sizes.rightPadding, Sizes.bottomPadding),
        child: Stack(fit: StackFit.passthrough, children: [
          ListView(
            shrinkWrap: true,
//            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              // Sizedboxes are used for whitespace and padding on the screen
              Text('Choose Event\'s Type',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
              SizedBox(height: Sizes.smallGap),
              activitySelectionButton,
              SizedBox(height: 8.0),
              Text('Enter Event\'s Name',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
              SizedBox(height: Sizes.smallGap),
              eventName,
              SizedBox(height: Sizes.bigGap),
              Text('Set Location',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
              SizedBox(height: Sizes.smallGap),
              eventLocation,
              SizedBox(height: Sizes.bigGap),
              Text('Set Start-Time',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
              SizedBox(height: Sizes.smallGap),
              startTimePicker,
              SizedBox(height: Sizes.bigGap),
              Text('Set Finish-Time',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
              SizedBox(height: Sizes.smallGap),
              finishTimePicker,
              SizedBox(height: Sizes.bottomGap),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
//        icon: const Icon(Icons.add),
        label: const Text(
          'Continue',
          style: TextStyle(color: GroupieColours.white69),
        ),
        onPressed: () {
          Event newEvent = new Event();
          newEvent.addMajor(_selectedActivity, _eventNameController.text, _eventLocationController.text,
              _startTime, _finishTime);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateNewEventMinorPage(newEventMinor: newEvent),
            ),
          );
        },
        backgroundColor: GroupieColours.logoColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
