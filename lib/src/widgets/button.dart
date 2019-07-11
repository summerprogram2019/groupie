import 'package:flutter/material.dart';
import 'package:groupie/util.dart' show GroupieColours;

class CircleButton extends Container {
  CircleButton(Function onPressed, IconData chosenIcon, String tooltip, {Widget child}) : super (
    decoration: BoxDecoration(shape: BoxShape.circle,
        boxShadow: [BoxShadow(
            color: Color.fromARGB(70, 0, 0, 0),
            blurRadius: 6,
            offset: Offset(0, 3)
        )]
    ),
    child: ClipOval(
      child: Container(
        color: Colors.white,
        child: IconButton(
          icon: new Icon(chosenIcon),
          iconSize: 45.0,
          tooltip: tooltip,
          onPressed: onPressed,
          color: GroupieColours.grey69,
        ),
      ),
    ),
  );
}