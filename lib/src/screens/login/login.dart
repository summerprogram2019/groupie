import 'package:flutter/material.dart';

import 'package:groupie/util.dart' show login, LoginResponse;
import 'package:groupie/screens.dart' show HomePage, SignupPage, RecoveryPage;
import 'package:groupie/widgets.dart' show LoadableScreen;

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

  void _login(LoginResponse response) {
    if (response.hasError) {
      setState(() {
        errors = response.error;
        _loggingIn = false;
      });
    } else {
      _loggingIn = false;
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

    final forgotLabel = FlatButton(
      key: Key('forgot_password'),
      child: Text(
        'Forgot your password?',
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(RecoveryPage.tag);
      },
    );

    final signupButton = RaisedButton(
      key: Key('signup_button'),
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.black),
      ),
      color: Colors.white,
      onPressed: () {
        Navigator.of(context).pushNamed(SignupPage.tag);
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
        setState(() {
          _loggingIn = true;
        });
        login(emailController.text, passwordController.text).then((LoginResponse response) =>
          _login(response)
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadableScreen(
            visible: !_loggingIn,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                Center(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 30.0),
                  )
                ),
                SizedBox(height: 48.0),
                email,
                SizedBox(height: 8.0),
                password,
                SizedBox(height: 24.0),
                forgotLabel,
                SizedBox(height: 24.0),
                Text(errors),
                SizedBox(height: 24.0),
                loginButton,
                SizedBox(height: 24.0),
                signupButton
              ],
            )
          ),
      ),
    );
  }
}
