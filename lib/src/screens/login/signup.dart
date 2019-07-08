import 'package:flutter/material.dart';

import 'package:groupie/screens.dart' show HomePage, LoginScreen;
import 'package:groupie/util.dart' show signup, SignupResponse;
import 'package:groupie/widgets.dart' show LoadableScreen;

class SignupPage extends StatefulWidget {
  final String title;

  static String tag = "signup🐢";

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
  /// Retrieves the text in the password entry field
  final TextEditingController confirmController = new TextEditingController();

  bool _signingUp = false;

  String errors = "";

  void _signup(SignupResponse response) {
    if (response.hasError) {
      setState(() {
        errors = response.error;
        _signingUp = false;
      });
    } else {
      _signingUp = false;
      Navigator.pushNamed(context, HomePage.tag);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      controller: confirmController,
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
        setState(() {
          _signingUp = true;
        });
        signup(emailController.text, passwordController.text).then((response) {
          _signup(response);
        });
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
        Navigator.of(context).pushReplacementNamed(LoginScreen.tag);
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadableScreen(
          visible: !_signingUp,
          child: ListView(
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
              ],
            )
        ),
      ),
    );
  }
}
