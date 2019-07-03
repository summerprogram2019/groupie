import 'package:flutter/material.dart';

import 'package:groupie/screens.dart' show WelcomeScreen;
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

  /// Retrieves the text in the email entry field
  final TextEditingController emailController = new TextEditingController();
  /// Retrieves the text in the password entry field
  final TextEditingController passwordController = new TextEditingController();

  bool _loggingIn = false;

  String errors = "";

  @override
  Widget build(BuildContext context) {

    final logo = new GroupieLogo(() => FocusScope.of(context).requestFocus(focus));

    // the email entry field
    final email = TextFormField(
        key: Key('email_field'),
        keyboardType: TextInputType.emailAddress,
        focusNode: focus,
        controller: emailController,
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
            ),
          ),
        ),
    );

    // password entry field
    final password = TextFormField(
        key: Key('password_field'),
        autofocus: false,
        obscureText: true,
        controller: passwordController,
        decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
            ),
          ),
        ),
    );

    final forgotLabel = FlatButton(
      key: Key('forgot_password'),
      child: Text(
        'Forgot your password?',
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(WelcomeScreen.tag);
      },
    );

    final signupButton = RaisedButton(
      key: Key('signup_button'),
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.red,
      onPressed: () {
        Navigator.of(context).pushNamed(WelcomeScreen.tag);
      },
    );

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
                email,
                SizedBox(height: 8.0),
                password,
                SizedBox(height: 24.0),
                forgotLabel,
                SizedBox(height: 24.0),
                Text(errors),
                SizedBox(height: 24.0),
                signupButton
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
