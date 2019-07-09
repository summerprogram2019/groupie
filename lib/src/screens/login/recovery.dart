import 'package:flutter/material.dart';

import 'package:groupie/screens.dart' show LoginScreen;
import 'package:groupie/widgets.dart' show LoadableScreen;

class RecoveryPage extends StatefulWidget {
  final String title;

  static String tag = "recovery🐢";

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
      ),
      body: Center(
        child: LoadableScreen(
          visible: !_loggingIn,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Center(
                  child: Text(
                    'Password Recovery',
                    style: TextStyle(color: Colors.black, fontSize: 30.0),
                  )
              ),
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 24.0),
              Text(errors),
              SizedBox(height: 48.0),
              sendRecovery
            ],
          )
        ),
      ),
    );
  }
}
