import 'package:flutter/material.dart';

// Import the home screen from the screens package
import 'package:groupie/screens.dart' show HomePage, ProfileScreen, LoginScreen, WelcomeScreen;

void main() => runApp(new MyApp());

// Main application, specifies the application to dispglay when first opening the app.
class MyApp extends StatelessWidget {
  static final String title = 'Groupie';

  static final routes = <String, WidgetBuilder>{
    WelcomeScreen.tag: (context) => new WelcomeScreen(title: title),
    LoginScreen.tag: (context) => new LoginScreen(title: title),
    HomePage.tag: (context) => new HomePage(title: title),
    ProfileScreen.tag: (context) => new ProfileScreen(title: title),
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: title,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new WelcomeScreen(title: title),
      routes: routes,
    );
  }
}

