import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:groupie/util.dart' show GroupieColours;


// Import the home screen from the screens package
import 'package:groupie/screens.dart';

void main(){
  //debugPaintSizeEnabled = false;
  runApp(new MyApp());
}

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
    PreferencesScreen.tag: (context) => new PreferencesScreen(title: 'Preferences'),
    ParticipantsScreen.tag: (context) => new ParticipantsScreen(title: title),
    EditProfile.tag: (context) => new EditProfile(title: title),
    CreateNewEventMajorPage.tag: (context) => new CreateNewEventMajorPage(title: title),
    CreateNewEventMinorPage.tag: (context) => new CreateNewEventMinorPage(title: title),
    CreateNewEventPreviewPage.tag: (context) => new CreateNewEventPreviewPage(title: title)
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
          backgroundColor: Color.fromARGB(255, 247, 247, 247),
          //define the default font family
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 36.0, fontWeight: FontWeight.normal),
            //normal text in cards e.g. Logout button, view your profile
            subhead: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: GroupieColours.grey69),
            //confirmation text style
            body1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: GroupieColours.logoColor),
            //extreme text style e.g. delete account, reject changes
            body2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: GroupieColours.extremeText),
          )
      ),
      home: new WelcomeScreen(title: title),
      routes: routes,
    );
  }
}

