import 'package:flutter/material.dart';

import 'package:groupie/screens.dart' show LoginScreen;
//import 'package:groupie/widgets.dart' show GroupieLogo;

class RecoveryPage extends StatefulWidget {
  final String title;

  static String tag = "recovery";

  RecoveryPage({Key key, this.title}) : super(key: key);

  @override
  _RecoveryPageState createState() => new _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  final FocusNode focus = FocusNode();

  /// Retrieves the text in the email entry field
  final TextEditingController emailController = new TextEditingController();

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

    final sendRecovery = RaisedButton(
      key: Key('recovery_button'),
      child: Text(
        'Send Recovery Link',
        style: TextStyle(color: Colors.black),
      ),
      color: Colors.white,
      onPressed: () {
        Navigator.of(context).pushNamed(LoginScreen.tag);
      },
    );

    final backButton = RaisedButton(
      key: Key('back_button'),
      child: Text(
        '<',
        style: TextStyle(color: Colors.black, fontSize: 50.0),
      ),
      color: Colors.white,
      onPressed: () {
        Navigator.of(context).pushNamed(LoginScreen.tag);
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
      ),
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
                        'Password Recovery',
                        style: TextStyle(color: Colors.black, fontSize: 30.0),
                      )
                  ),
                  // Sizedboxes are used for whitespace and padding on the screen
                  SizedBox(height: 48.0),
                  email,
                  SizedBox(height: 24.0),
                  Text(errors),
                  SizedBox(height: 48.0),
                  sendRecovery
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
