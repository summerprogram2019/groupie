import 'package:flutter/material.dart';

import 'package:groupie/util.dart' show getUserId;
import 'package:groupie/screens.dart' show HomePage, LoginScreen, SignupPage, CreateNewEventMajorPage;
import 'package:groupie/widgets.dart' show GroupieLogo;

class WelcomeScreen extends StatelessWidget {
  final String title;

  static String tag = "welcome";

  WelcomeScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getUserId().then((id) {
      if (id != null) {
        Navigator.pushReplacementNamed(context, HomePage.tag);
      }
    });

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
                      Navigator.of(context).pushNamed(SignupPage.tag);
                    },
                  ),
                  SizedBox(height: 16.0),
                  RaisedButton(
                    key: Key('createNewEvent'),
                    child: Text(
                      'Create new event \r\n For dev. purp.',
                      style: TextStyle(color: Colors.black54, fontSize: 32.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CreateNewEventMajorPage.tag);
                    },
                  ),
                  SizedBox(height: 32.0),
                ]
              )
            ],
          )
        ),
      );
  }
}
