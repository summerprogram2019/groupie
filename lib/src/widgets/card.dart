import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:groupie/model.dart' show HobbyCard, Event;
import 'package:groupie/src/util/dateFunctions.dart';
import 'package:groupie/util.dart' show GroupieColours;
import 'package:intl/intl.dart';

//for persist functionality
import 'package:shared_preferences/shared_preferences.dart';

class ParticipantCard extends Expanded {
  ParticipantCard({Widget child})
      : super(
            child: Card(
                child: Padding(padding: EdgeInsets.all(10.0), child: child)));
}


/*
A card used on the upcoming events and my 'view your created events' pages.
Shown in a list with other MiniEventCards
Has a title, number of participants, image, small description, location and time
 */
class MiniEventCard extends Card{
  //outputs a string in the form "( currentNoOfParticipants / requiredNoOfParticipants )'
  static _getParticipantString(int currentNoOfParticipants, int requiredNoOfParticipants){
    return '(' + currentNoOfParticipants.toString() + '/' + requiredNoOfParticipants.toString() + ')';
  }

  static _chooseTextColour(int currentNoOfParticipants, int requiredNoOfParticipants, BuildContext context){
    if (currentNoOfParticipants < requiredNoOfParticipants){
      //there are less participants than the event requires, therefore red text
      return Theme.of(context).textTheme.body2;
    } else {
      return Theme.of(context).textTheme.body1;
    }
  }

  MiniEventCard(
      String titleText,
      String eventDescription,
      Image eventImage,
      String locationText,
      DateTime eventTime,
      int currentNoOfParticipants,
      int requiredNoOfParticipants,
      BuildContext context,
      [TextStyle chosenStyle])
      : super(
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                  titleText,
                  style: chosenStyle
              ),

              Row(
                children: <Widget>[
                  Icon(Icons.perm_identity,),
                  Text(
                      _getParticipantString(currentNoOfParticipants, requiredNoOfParticipants),
                      style: _chooseTextColour(currentNoOfParticipants, requiredNoOfParticipants, context)
                  ),
                ],
              ),

            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width*0.5,
              child: Hero(
                tag: "event_id_" + titleText,
                child: ClipRRect(
                  child: eventImage,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width*0.4,
              child: Text(
                eventDescription,
                style: TextStyle(fontSize: 14, color: GroupieColours.grey69),
                maxLines:  6,
                overflow: TextOverflow.ellipsis,
              ),
            ),

          ],
        ),

        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      'Location:',
                      style: TextStyle(fontSize: 14, color: GroupieColours.grey69)
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      locationText,
                      style: TextStyle(fontSize: 14, color: GroupieColours.grey69)
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      'Time:',
                      style: TextStyle(fontSize: 14, color: GroupieColours.grey69)
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      eventTime.toIso8601String(),
                      style: TextStyle(fontSize: 14, color: GroupieColours.grey69)
                  ),
                ),
              ],
            ),


          ],
        )

      ],
    ),
  );
}




/*
Takes a card title, three detail labels and three functions to fetch the values for the details.
 */
class DetailsCard extends Card {
  DetailsCard(
      String cardTitle,
      String detailOneLabel,
      Function getDetailOne,
      String detailTwoLabel,
      Function getDetailTwo,
      String detailThreeLabel,
      Function getDetailThree,
      [TextStyle chosenStyle])
      : super(
            child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(cardTitle, style: chosenStyle),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(detailOneLabel, style: chosenStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(getDetailOne(), style: chosenStyle),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(detailTwoLabel, style: chosenStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(getDetailTwo(), style: chosenStyle),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(detailThreeLabel, style: chosenStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(getDetailThree(), style: chosenStyle),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
}

/*
A card with a title and a body
 */
class DescriptionCard extends Card {
  DescriptionCard(String titleText, String bodyText, [TextStyle chosenStyle])
      : super(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(titleText, style: chosenStyle),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(bodyText, style: chosenStyle),
                  ),
                ],
              ),
            ],
          ),
        );
}

//defining the standard cards used on the preferences screens

/* used when the card links to another page or performs an action on press e.g.
'view your profile' or 'logout'.
 */
class LinkCard extends Card {
  //text style is an optional parameter
  LinkCard(String cardText, Function action, [TextStyle chosenStyle])
      : super(
            child: InkWell(
          onTap: action,
          child: ListTile(
            title: Text(cardText, style: chosenStyle),
            trailing: new IconButton(
              icon: new Icon(Icons.arrow_forward_ios),
              tooltip: 'Open Profile',
              onPressed: action,
            ),
          ),
        ));
}

//Similar to link card but includes a preceding string and icon - primarily for view participants link
class IconLinkCard extends Card {
  //text style is an optional parameter
  IconLinkCard(String cardText, String iconText, TextStyle iconTextStyle,
      IconData iconImage, Function action,
      [TextStyle chosenStyle])
      : super(
            child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 250),
              child: Row(
                children: <Widget>[
                  Icon(iconImage),
                  Text(iconText, style: iconTextStyle),
                ],
              ),
            ),
            InkWell(
                onTap: action,
                child: ListTile(
                  title: Text(cardText, style: chosenStyle),
                  trailing: new IconButton(
                    icon: new Icon(Icons.arrow_forward_ios),
                    tooltip: 'Open Profile',
                    onPressed: action,
                  ),
                ))
          ],
        ));
}

/* used when the card links to another page or performs an action on press e.g.
'view your profile' or 'logout'.
 */
class ToggleCard extends Card {
  /*Takes a callback for the onChanged and onTap functions (basically just give the(){} parts
  as parameters. text style is an optional parameter
   */
  ToggleCard(String cardText, valueToToggle, onChanged, onTap,
      [TextStyle chosenStyle])
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
        ));
}

//A card which has a slider on it, a description and a live value
class SliderCard extends Card {
  SliderCard(String cardText, valueToSlide, String valueString,
      int noOfDivisions, double minValue, double maxValue, onChanged,
      [TextStyle chosenStyle])
      : super(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(cardText, style: chosenStyle),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(valueString, style: chosenStyle),
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
                    onChanged: onChanged),
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
  EventCard(Event event, {remove})
      : super(
            top: 5.0,
            child: Draggable(
              onDragEnd: (details) {
                if (details.wasAccepted && remove != null) {
                  remove();
                }
              },
              childWhenDragging: Container(),
              feedback: _createEventCard(event),
              child: _createEventCard(event),
              data: event,
            ));
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
          event.eventName, //Update to load from DB
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
            new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // When database is ready, update these to take directly from there:
              Text(event.location),
              Text(DateFunctions.getDateString(event.start)),
              Text(event.minimumParticipants.toString() +
                  " - " +
                  event.maximumParticipants.toString()),
              Text(event.cost.toString()),
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
      ));
}

/*
 * Activity Card Template for the homescreen
 * TODO update this when database is ready to go
 */
Widget _createCard(HobbyCard card) {
  return Card(
    elevation: 12.0,
    color: Color.fromARGB(255, card.red, card.green, card.blue),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      width: 360.0,
      height: 550.0,
      child: Column(children: [
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
              SizedBox(width: 100.0),
            ]),
            //TODO fix this alignment so that its not hardcoded in
            new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // When database is ready, update these to take directly from there:
              Text("Location"),
              Text("Date"),
              Text("Participants"),
              Text("Estimated Cost"),
              Text("Age Restriction"),
            ]),
          ],
        ),
      ]),
    ),
  );
}
