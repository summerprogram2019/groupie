import 'package:flutter/material.dart';

// Import the home screen from the screens package
import 'package:groupie/screens.dart' show HomePage, ProfileScreen, LoginScreen, WelcomeScreen, SignupPage, RecoveryPage, DisclaimerScreen, CreateNewEventMajorPage, CreateEventSecondScreen, CreateEventPreviewScreen;

void main() => runApp(new MyApp());

// For removing glow effect everywhere
class RemoveGlowEffectBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

// Main application, specifies the application to dispglay when first opening the app.
class MyApp extends StatelessWidget {
  static final String title = 'Groupie';

  static final routes = <String, WidgetBuilder>{
    WelcomeScreen.tag: (context) => new WelcomeScreen(title: title),
    LoginScreen.tag: (context) => new LoginScreen(title: title),
    SignupPage.tag: (context) => new SignupPage(title: title),
    HomePage.tag: (context) => new HomePage(title: title),
    ProfileScreen.tag: (context) => new ProfileScreen(title: title),
    RecoveryPage.tag: (context) => new RecoveryPage(title: title),
    DisclaimerScreen.tag: (context) => new DisclaimerScreen(title: title),
    CreateNewEventMajorPage.tag: (context) => new CreateNewEventMajorPage(title: title),
    CreateEventSecondScreen.tag: (context) => new CreateEventSecondScreen(title: title),
    CreateEventPreviewScreen.tag: (context) => new CreateEventPreviewScreen(title: title),
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: RemoveGlowEffectBehavior(),
          child: child,
        );
      },
      title: title,
      theme: new ThemeData(
        //primarySwatch: Colors.white54,
      ),
      home: new WelcomeScreen(title: title),
      routes: routes,
    );
  }
}

