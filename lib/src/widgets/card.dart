import 'package:flutter/material.dart';

import 'package:groupie/model.dart' show HobbyCard;
import 'package:groupie/util.dart' show GroupieColours;


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