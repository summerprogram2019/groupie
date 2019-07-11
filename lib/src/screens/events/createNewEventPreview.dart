import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:groupie/src/util/dateFunctions.dart';
import 'package:groupie/src/util/sizes.dart';
import 'package:groupie/src/util/colours.dart';

import 'package:groupie/screens.dart' show HomePage, CreateNewEventPreviewPage;
import 'package:groupie/model.dart' show Event;

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

  List<String> _ages = new List<String>();

  List<DropdownMenuItem<String>> _dropDownMenuMinimumAge =
  new List<DropdownMenuItem<String>>();
  String _selectedMinimumAge;

  List<DropdownMenuItem<String>> _dropDownMenuMaximumAge =
  new List<DropdownMenuItem<String>>();
  String _selectedMaximumAge;

  List<String> _participantsNumbers = new List<String>();

  List<DropdownMenuItem<String>> _dropDownMenuMinimumParticipantsNumber =
  new List<DropdownMenuItem<String>>();
  String _selectedMinimumParticipantsNumber;

  List<DropdownMenuItem<String>> _dropDownMenuMaximumParticipantsNumber =
  new List<DropdownMenuItem<String>>();
  String _selectedMaximumParticipantsNumber;

  _CreateNewEventPreviewPageState(this.event) : super() {
    eventNameController.text = event.eventName;
  }

  @override
  void initState() {
    _ages.add('no matter');
    for (int i = 14; i < 100; ++i) {
      _ages.add(i.toString());
    }
    _dropDownMenuMinimumAge = buildAndGetDropDownMenuItems(_ages);
    _selectedMinimumAge = _dropDownMenuMinimumAge[0].value;
    _dropDownMenuMaximumAge = buildAndGetDropDownMenuItems(_ages);
    _selectedMaximumAge = _dropDownMenuMaximumAge[0].value;

    _participantsNumbers.add('no matter');
    for (int i = 0; i < 31; ++i) {
      _participantsNumbers.add(i.toString());
    }
    _dropDownMenuMinimumParticipantsNumber =
        buildAndGetDropDownMenuItems(_participantsNumbers);
    _selectedMinimumParticipantsNumber = _dropDownMenuMinimumAge[0].value;
    _dropDownMenuMaximumParticipantsNumber =
        buildAndGetDropDownMenuItems(_participantsNumbers);
    _selectedMaximumParticipantsNumber = _dropDownMenuMaximumAge[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  void changedDropMenuMinimumAge(String selectedAge) {
    setState(() {
      _selectedMinimumAge = selectedAge;
    });
  }

  void changedDropMenuMaximumAge(String selectedAge) {
    setState(() {
      _selectedMaximumAge = selectedAge;
    });
  }

  void changedDropMenuMinimumParticipantsNumber(
      String selectedParticipantsNumber) {
    setState(() {
      _selectedMinimumParticipantsNumber = selectedParticipantsNumber;
    });
  }

  void changedDropMenuMaximumParticipantsNumber(
      String selectedParticipantsNumber) {
    setState(() {
      _selectedMaximumParticipantsNumber = selectedParticipantsNumber;
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

  String _joiningFinishTimeString = "Tap to choose";
  bool _joiningFinishTimeChosen = false;
  DateTime _joiningFinishTime = DateTime.now();

  void changeTextJoiningFinishTimeButton(DateTime date) {
    setState(() {
      _joiningFinishTimeString = DateFunctions.getDateString(date);
      _joiningFinishTimeChosen = true;
      _joiningFinishTime = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    // the event's description entry field
    final eventDescription = TextFormField(
      key: Key('eventDescription_field'),
      keyboardType: TextInputType.multiline,
      autofocus: false,
      maxLines: 5,
      maxLength: 150,
      // it'll have problems on different devices (screen sizes), but it seems hard for fixing
//      expands: true,
      controller: eventDescriptionController,
      decoration: InputDecoration(
        hintText: "All true guys are going to be here!",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
        ),
      ),
    );

    DateTime getStartTime() {
      if (!_joiningFinishTimeChosen) {
        _joiningFinishTime = DateTime.now();
      }
      return _joiningFinishTime;
    }

    final joiningFinishTimePicker = RaisedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context, onChanged: (date) {
            print('change $date');
          }, onConfirm: (date) {
            changeTextJoiningFinishTimeButton(date);
            print('confirm $date.');
          },
              currentTime: getStartTime() /*DateTime.now()*/,
              locale: LocaleType.en);
        },
        child: Text(
          _joiningFinishTimeString,
          style: TextStyle(color: GroupieColours.white69),
        ),
        color: GroupieColours.logoColor);

    final minimumAgeSelectionButton = DropdownButton(
      value: _selectedMinimumAge,
      items: _dropDownMenuMinimumAge,
      onChanged: changedDropMenuMinimumAge,
    );

    final maximumAgeSelectionButton = DropdownButton(
      value: _selectedMaximumAge,
      items: _dropDownMenuMaximumAge,
      onChanged: changedDropMenuMaximumAge,
    );

    final minimumParticipantsNumberSelectionButton = DropdownButton(
      value: _selectedMinimumParticipantsNumber,
      items: _dropDownMenuMinimumParticipantsNumber,
      onChanged: changedDropMenuMinimumParticipantsNumber,
    );

    final maximumParticipantsNumberSelectionButton = DropdownButton(
      value: _selectedMaximumParticipantsNumber,
      items: _dropDownMenuMaximumParticipantsNumber,
      onChanged: changedDropMenuMaximumParticipantsNumber,
    );

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
