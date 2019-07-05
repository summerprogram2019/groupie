import 'package:flutter/material.dart';

import 'package:groupie/screens.dart' show WelcomeScreen, HomePage, LoginScreen;
//import 'package:groupie/widgets.dart' show GroupieLogo;

class SignupPage extends StatefulWidget {
  final String title;

  static String tag = "sign up";

  SignupPage({Key key, this.title}) : super(key: key);

  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FocusNode focus = FocusNode();

  /// Retrieves the text in the email entry field
  final TextEditingController emailController = new TextEditingController();
  /// Retrieves the text in the password entry field
  final TextEditingController passwordController = new TextEditingController();

  bool _loggingIn = false;

  String errors = "";

  @override
  Widget build(BuildContext context) {

    //final logo = new GroupieLogo(() => FocusScope.of(context).requestFocus(focus));

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

    // password confirmation field
    final confirm = TextFormField(
      key: Key('confirmation_field'),
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
        ),
      ),
    );

    final createButton = RaisedButton(
      key: Key('create_button'),
      child: Text(
        'Create Account',
        style: TextStyle(color: Colors.black),
      ),
      color: Colors.white,
      onPressed: () {
        Navigator.of(context).pushNamed(HomePage.tag);
      },
    );

    final loginButton = RaisedButton(
      key: Key('login_button'),
      child: Text(
        'Log In',
        style: TextStyle(color: Colors.black),
      ),
      color: Colors.white,
      onPressed: () {
        Navigator.of(context).pushNamed(LoginScreen.tag);
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
                  //logo,
                  Center(
                      child: Text(
                        'Create an Account',
                        style: TextStyle(color: Colors.black, fontSize: 30.0),
                      )
                  ),
                  // Sizedboxes are used for whitespace and padding on the screen
                  SizedBox(height: 48.0),
                  email,
                  SizedBox(height: 8.0),
                  password,
                  SizedBox(height: 8.0),
                  confirm,
                  SizedBox(height: 24.0),
                  Text(errors),
                  SizedBox(height: 48.0),
                  createButton,
                  SizedBox(height: 24.0),
                  loginButton
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
