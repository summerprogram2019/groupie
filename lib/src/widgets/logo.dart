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

class GroupieProfile extends Container {
  GroupieProfile(ImageProvider image) : super(
    width: 100.0,
    height: 100.0,
    margin: EdgeInsets.all(10.0),

    decoration: new BoxDecoration(
      shape: BoxShape.circle,
      image: new DecorationImage(
        fit: BoxFit.cover,
        image: image
      )
    )
  );
}