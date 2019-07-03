import 'package:flutter/material.dart';

import 'package:groupie/widgets.dart' show GroupieLogo;

class LoginScreen extends StatefulWidget {
  final String title;

  static String tag = "login";

  LoginScreen({Key key, this.title}) : super(key: key);

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode focus = FocusNode();

  bool _loggingIn = false;

  @override
  Widget build(BuildContext context) {

    final logo = new GroupieLogo(() => FocusScope.of(context).requestFocus(focus));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                // Sizedboxes are used for whitespace and padding on the screen
                SizedBox(height: 48.0),
//                email,
//                SizedBox(height: 8.0),
//                password,
//                SizedBox(height: 24.0),
//                loginButton,
//                SizedBox(height: 8.0),
//                newUser,
//                SizedBox(height: 4.0),
//                forgotLabel
              ],
            ),
            new Offstage(
              // displays the loading icon while the user is logging in
                offstage: !_loggingIn,
                child: new Center(
                    child: _loggingIn ? new CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ) : null
                )
            )
          ]),
      ),
    );
  }
}
