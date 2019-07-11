import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:groupie/src/util/dateFunctions.dart';
import 'package:groupie/src/util/event.dart';
import 'package:groupie/src/util/sizes.dart';
import 'package:groupie/src/util/colours.dart';

import 'package:groupie/screens.dart' show HomePage, CreateNewEventPreviewPage;

class CreateNewEventMinorPage extends StatefulWidget {
  final String title;
  final Event newEventMinor;

  static String tag = "createNewEventMinor";

  CreateNewEventMinorPage({Key key, this.title, @required this.newEventMinor})
      : super(key: key);

  @override
  _CreateNewEventMinorPageState createState() =>
      new _CreateNewEventMinorPageState();
}

class _CreateNewEventMinorPageState extends State<CreateNewEventMinorPage> {
  final FocusNode focus = FocusNode();

  /// Retrieves the text in the event's description entry field
  final TextEditingController _eventDescriptionController =
      new TextEditingController();

  double _priceNewEvent = -100;
  var _priceNewEventString = 'Unknown';

  List<String> _agesNewEvent = new List<String>();

  List<DropdownMenuItem<String>> _dropDownMenuMinimumAge =
      new List<DropdownMenuItem<String>>();
  String _selectedMinimumAge = 'no matter';

  List<DropdownMenuItem<String>> _dropDownMenuMaximumAge =
      new List<DropdownMenuItem<String>>();
  String _selectedMaximumAge = 'no matter';

  List<String> _participantsNumbers = new List<String>();

  List<DropdownMenuItem<String>> _dropDownMenuMinimumParticipantsNumber =
      new List<DropdownMenuItem<String>>();
  String _selectedMinimumParticipantsNumber;

  List<DropdownMenuItem<String>> _dropDownMenuMaximumParticipantsNumber =
      new List<DropdownMenuItem<String>>();
  String _selectedMaximumParticipantsNumber;

  @override
  void initState() {
    _agesNewEvent.add('no matter');
    for (int i = 14; i < 100; ++i) {
      _agesNewEvent.add(i.toString());
    }
    _dropDownMenuMinimumAge = buildAndGetDropDownMenuItems(_agesNewEvent);
    _selectedMinimumAge = _dropDownMenuMinimumAge[0].value;
    _dropDownMenuMaximumAge = buildAndGetDropDownMenuItems(_agesNewEvent);
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

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List elements) {
    List<DropdownMenuItem<String>> items = new List();
    for (String element in elements) {
      items.add(new DropdownMenuItem(value: element, child: new Text(element)));
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

  String _rsvpTimeString = "Tap to choose";
  bool _rsvpTimeChosen = false;
  DateTime _rsvpTime = DateTime.now();

  void changeTextrsvpTimeButton(DateTime date) {
    setState(() {
      _rsvpTimeString = DateFunctions.getDateString(date);
      _rsvpTimeChosen = true;
      _rsvpTime = date;
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
      controller: _eventDescriptionController,
      decoration: InputDecoration(
        hintText: "All true guys are going to be here!",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
        ),
      ),
    );

    DateTime getrsvpTime() {
      if (!_rsvpTimeChosen) {
        _rsvpTime = DateTime.now();
      }
      return _rsvpTime;
    }

    final rsvpTimePicker = RaisedButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context, onChanged: (date) {
            print('change $date');
          }, onConfirm: (date) {
            changeTextrsvpTimeButton(date);
            print('confirm $date.');
          },
              currentTime: getrsvpTime() /*DateTime.now()*/,
              locale: LocaleType.en);
        },
        child: Text(
          _rsvpTimeString,
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
        title: new Text("Create Event. Minor Details"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      //'Maximum Cost: \$ ${_maxCostString}',
                      'Event Price Estimate:'),
                  Text(
                    _priceNewEventString,
                  ),
                ],
              ),
              CupertinoSlider(
                value: _priceNewEvent,
                min: -100,
                max: 1000,
                divisions: 55,
                onChanged: (double value) {
                  setState(() {
                    _priceNewEvent = value;
                    _priceNewEventString = value.toStringAsFixed(0);

                    if (value < -50) {
                      _priceNewEventString = 'Unknown';
                    }
                    if (value > -50 && value <= 0) {
                      _priceNewEventString = 'Free';
                    }
                    if (value == 1000) {
                      _priceNewEventString = 'No limit';
                    }
                  });
                },
              ),
              SizedBox(height: Sizes.bigGap),
              Text('Age Restrictions',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
              SizedBox(height: Sizes.smallGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  minimumAgeSelectionButton,
                  Text('—'),
                  maximumAgeSelectionButton,
                ],
              ),
              SizedBox(height: Sizes.bigGap),
              Text('Participants Number Limits',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
              SizedBox(height: Sizes.smallGap),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  minimumParticipantsNumberSelectionButton,
                  Text('—'),
                  maximumParticipantsNumberSelectionButton,
                ],
              ),
              SizedBox(height: Sizes.bigGap),
              Text('Set RSVP Time',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
              SizedBox(height: Sizes.smallGap),
              rsvpTimePicker,
              SizedBox(height: Sizes.bigGap),
              Text('Type Event\'s Description',
                  style: TextStyle(
                      color: Colors.black, fontSize: Sizes.titleFontSize)),
              SizedBox(height: Sizes.smallGap),
              eventDescription,
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

          if (_priceNewEvent < -50) {
            _priceNewEvent = -1;
          }
          if (_priceNewEvent > -50 && _priceNewEvent <= 0) {
            _priceNewEvent = 0;
          }
          if (_priceNewEvent == 1000) {
            _priceNewEvent = 100500;
          }

          double _priceEvent = _priceNewEvent < -50 ? -1 : _priceNewEvent <= 0 ? 0 : _priceNewEvent == 1000 ? 100500 : _priceNewEvent;
          int _minimumAge = _selectedMinimumAge == 'no matter' ? 0 : int.parse(_selectedMinimumAge);
          int _maximumAge = _selectedMaximumAge == 'no matter' ? 0 : int.parse(_selectedMaximumAge);
          int _minimumParticipantsNumber = _selectedMinimumParticipantsNumber == 'no matter' ? 0 : int.parse(_selectedMinimumParticipantsNumber);
          int _maximumParticipantsNumber = _selectedMaximumParticipantsNumber == 'no matter' ? 0 : int.parse(_selectedMaximumParticipantsNumber);

          // don't change value-variables of dropDownButtons like following!!!
//          if (_selectedMinimumAge == 'no matter') {
//            _selectedMinimumAge = '0';
//          }
//          if (_selectedMaximumAge == 'no matter') {
//            _selectedMaximumAge = '0';
//          }
//          if (_selectedMinimumParticipantsNumber == 'no matter') {
//            _selectedMinimumParticipantsNumber = '0';
//          }
//          if (_selectedMaximumParticipantsNumber == 'no matter') {
//            _selectedMaximumParticipantsNumber = '0';
//          }

          widget.newEventMinor.addMinor(
              _priceEvent,
              _minimumAge,
              _maximumAge,
              _minimumParticipantsNumber,
              _maximumParticipantsNumber,
              _rsvpTime,
              _eventDescriptionController.text);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateNewEventPreviewPage(newEvent: widget.newEventMinor),
            ),
          );
//          Navigator.of(context).pushNamed(CreateNewEventPreviewPage.tag);
        },
        backgroundColor: GroupieColours.logoColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
