import 'package:flutter/material.dart';

class GroupieLogo extends Hero {
  GroupieLogo(GestureTapCallback onTap) : super(
      tag: 'login',
      key: Key('login_logo'),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 40.0,
          child: Image.asset('sun.png'),
        ),
      )
  );
}