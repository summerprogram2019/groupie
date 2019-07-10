import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:groupie/model.dart' show HobbyCard, Event;
import 'package:groupie/util.dart' show GroupieColours;

//for persist functionality
import 'package:shared_preferences/shared_preferences.dart';

class ParticipantCard extends Expanded {
  ParticipantCard({Widget child}) : super(
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: child
      )
    )
  );
}

//defining the standard card used on the preferences screens

/* used when the card links to another page or performs an action on press e.g.
'view your profile' or 'logout'.
 */
class LinkCard extends Card{
  //text style is an optional parameter
  LinkCard(String cardText, Function action, [TextStyle chosenStyle])
      : super(
      child: InkWell(
        onTap: action,
        child: ListTile(
          title: Text(
              cardText,
              style: chosenStyle
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.arrow_forward_ios),
            tooltip: 'Open Profile',
            onPressed: action,
          ),
        ),
      )
  );
}

/* used when the card links to another page or performs an action on press e.g.
'view your profile' or 'logout'.
 */
class ToggleCard extends Card{
  /*Takes a callback for the onChanged and onTap functions (basically just give the(){} parts
  as parameters. text style is an optional parameter
   */
  ToggleCard(String cardText, valueToToggle, onChanged, onTap, [TextStyle chosenStyle])
      : super(
      child: Column(
        children: <Widget>[
          MergeSemantics(
            child: ListTile(
              title: Text(cardText),
              trailing: CupertinoSwitch(
                value: valueToToggle,
                onChanged: onChanged,
              ),
              onTap: onTap,
            ),
          )
        ],
      )
  );
}

class SliderCard extends Card{
  SliderCard(String cardText, valueToSlide, String valueString, int noOfDivisions, double minValue, double maxValue, onChanged, [TextStyle chosenStyle])
      : super(
    child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                  cardText,
                  style: chosenStyle
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                  valueString,
                  style: chosenStyle
              ),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.all(10.0),
          child: CupertinoSlider(
            //sets to 0 if null on first build to avoid null assert exception
            value: valueToSlide ?? 0,
            min: minValue,
            max: maxValue,
            divisions: noOfDivisions,
            onChanged: onChanged
          ),
        )
      ],
    ),
  );
}


class ProfileCard extends Row {
  ProfileCard(String title, String contents)
      : super(
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
                                text: title + "\r\n",
                                style: new TextStyle(
                                    color: GroupieColours.darkText,
                                    fontSize: 15.0),
                                children: [
                                  TextSpan(
                                      text: contents,
                                      style: TextStyle(
                                          color: GroupieColours.grey69,
                                          fontSize: 18.0))
                                ]),
                          ))
                    ],
                  ))))
    ],
  );
}

class EventCard extends Positioned {
  EventCard(Event event) : super(
      top: 5.0,
      child: Draggable(
        childWhenDragging: Container(),
        feedback: _createEventCard(event),
        child: _createEventCard(event),
      )
  );
}

Widget _createEventCard(Event event) {
  return Card(
    elevation: 12.0,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child:
    Container(
      width: 360.0,
      height: 600.0,
      child: Column(
          children: [
            Text(
              event.eventName, //Update to load from DB
              style: new TextStyle(
                color: GroupieColours.grey69,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Image.asset("sun.png"), //Update to load from DB
            SizedBox(height: 10.0),
            Text(
              "Short Description Here", //Update to load from DB
              style: new TextStyle(
                color: GroupieColours.grey69,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 18.0),
            new Row(
              children: <Widget>[
                new Column(
                    children: [
                      SizedBox(width: 10.0),
                    ]
                ),
                new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Location"),
                      Text("Date"),
                      Text("Participants"),
                      Text("Estimated Cost"),
                      Text("Age Restriction"),
                    ]
                ),
                new Column(
                    children: [
                      SizedBox(width: 130.0),
                    ]
                ),
                new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // When database is ready, update these to take directly from there:
                      Text(event.location),
                      Text(event.start.toString()),
                      Text(event.minimumParticipants.toString() + " - " + event.maximumParticipants.toString()),
                      Text(event.cost.toString()),
                      Text("HELP"),
                    ]
                ),
              ],
            ),
          ]
      ),
    ),
  );
}

Widget createCard(HobbyCard card, VoidCallback remove) {
  return new Positioned(
    top: 5.0,
    child: Draggable(
      onDragCompleted: () {
        remove();
      },
      childWhenDragging: Container(),
      feedback: _createCard(card),
      child: _createCard(card),
    )
  );
}

/*
 * Activity Card Template for the homescreen
 * TODO update this when database is ready to go
 */
Widget _createCard(HobbyCard card) {
  return Card(
    elevation: 12.0,
    color: Color.fromARGB(255, card.red, card.green, card.blue),
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child:
      Container(
          width: 360.0,
          height: 550.0,
          child: Column(
            children: [
              Text(
                "This is the Event Name", //Update to load from DB
                style: new TextStyle(
                  color: GroupieColours.grey69,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 10.0),
              Image.asset("sun.png"), //Update to load from DB
              SizedBox(height: 10.0),
              Text(
                "Short Description Here", //Update to load from DB
                style: new TextStyle(
                  color: GroupieColours.grey69,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 18.0),
              new Row(
                children: <Widget>[
                  new Column(
                      children: [
                        SizedBox(width: 10.0),
                      ]
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Location"),
                        Text("Date"),
                        Text("Participants"),
                        Text("Estimated Cost"),
                        Text("Age Restriction"),
                      ]
                  ),
                  new Column(
                      children: [
                        SizedBox(width: 100.0),
                      ]
                  ),
                  //TODO fix this alignment so that its not hardcoded in
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // When database is ready, update these to take directly from there:
                        Text("Location"),
                        Text("Date"),
                        Text("Participants"),
                        Text("Estimated Cost"),
                        Text("Age Restriction"),
                      ]
                  ),
                ],
              ),
            ]
          ),
      ),
  );
}
