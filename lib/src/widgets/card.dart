import 'package:flutter/material.dart';

import 'package:groupie/model.dart' show HobbyCard;
import 'package:groupie/util.dart' show GroupieColours;

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

Widget _createCard(HobbyCard card) {
  return Card(
    elevation: 12.0,
    color: Color.fromARGB(255, card.red, card.green, card.blue),
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      width: 360.0,
      height: 575.0,
      child: Row(
        children: [

        ]
      ),
    ),
  );
}
