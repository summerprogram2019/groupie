import 'package:flutter/material.dart';

import 'package:groupie/screens.dart' show LoginScreen;
import 'package:groupie/widgets.dart' show GroupieLogo;

class WelcomeScreen extends StatelessWidget {
  final String title;

  static String tag = "welcome";

  WelcomeScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logo = new GroupieLogo(() => {});

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 72.0),
              ListView(
                shrinkWrap: true,
                children: [
                  RaisedButton(
                    key: Key('login'),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 32.0),
                    ),
                    color: Colors.amber,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.tag);
                    },
                  ),
                  SizedBox(height: 16.0),
                  RaisedButton(
                    key: Key('signup'),
                    child: Text(
                      'Signup',
                      style: TextStyle(color: Colors.black54, fontSize: 32.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.tag);
                    },
                  ),
                  SizedBox(height: 48.0),
                ]
              )
            ],
          )
        ),
      );
  }
}