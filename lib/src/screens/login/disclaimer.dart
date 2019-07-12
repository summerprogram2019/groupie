import 'package:flutter/material.dart';

import 'package:groupie/screens.dart' show EditProfile;
import 'package:groupie/widgets.dart' show LoadableScreen;
import 'package:groupie/util.dart' show GroupieColours;
class DisclaimerScreen extends StatefulWidget {
  final String title;

  static String tag = "disclaimer🐢";

  DisclaimerScreen({Key key, this.title}) : super(key: key);

  @override
  _DisclaimerScreenState createState() => new _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  final FocusNode focus = FocusNode();

  /// Retrieves the text in the email entry field
  final TextEditingController emailController = new TextEditingController();

  bool _loggingIn = false;

  String errors = "";

  bool _ticked = false;

  void _tick(bool value) {
    setState(() {
      _ticked = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    final confirm = CheckboxListTile(
        key: Key('checkbox'),
        title: const Text('I have read and agree to the Terms and Conditions'),
        value: _ticked,
        onChanged: _tick,
    );

    final continueButton = RaisedButton(
      key: Key('continue_button'),
      child: Text(
        'Continue',
        style: TextStyle(color: Colors.white),
      ),
      color: GroupieColours.logoColor,
      onPressed: () {
        Navigator.of(context).pushNamed(EditProfile.tag);
      },
    );

    final disclaimerText = Container(
        height: 200.0,
        width: 200.0,
        decoration: BoxDecoration(
          border: Border.all(color: GroupieColours.grey69),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
                "Lorem Ipsum is simply dummy text of the printing and "
                    "typesetting industry. Lorem Ipsum has been the industry's "
                    "standard dummy text ever since the 1500s, when an unknown "
                    "printer took a galley of type and scrambled it to make a type "
                    "specimen book. It has survived not only five centuries, but "
                    "also the leap into electronic typesetting, remaining "
                    "essentially unchanged. It was popularised in the 1960s with "
                    "the release of Letraset sheets containing Lorem Ipsum passages, "
                    "and more recently with desktop publishing software like Aldus "
                    "PageMaker including versions of Lorem Ipsum. \r\n "
                    "It is a long established fact that a reader will be "
                    "distracted by the readable content of a page when looking "
                    "at its layout. The point of using Lorem Ipsum is that it "
                    "has a more-or-less normal distribution of letters, as "
                    "opposed to using 'Content here, content here', making it "
                    "look like readable English. Many desktop publishing "
                    "packages and web page editors now use Lorem Ipsum as their "
                    "default model text, and a search for 'lorem ipsum' will "
                    "uncover many web sites still in their infancy. Various "
                    "versions have evolved over the years, sometimes by a",
                style: TextStyle(color: GroupieColours.grey69)
            ),
          )
      )
    );

    return Scaffold(
      appBar: new AppBar(
          backgroundColor: GroupieColours.white69,
          iconTheme: new IconThemeData(color: GroupieColours.grey69),
      ),
      backgroundColor: GroupieColours.white69,
      body: Center(
        child: LoadableScreen(
          visible: _loggingIn,
          child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: 24.0),
                Center(
                    child: Text(
                      'Disclaimer',
                      style: TextStyle(color: Colors.black, fontSize: 30.0),
                    )
                ),
                SizedBox(height: 24.0),
                disclaimerText,
                SizedBox(height: 100.0),
                Text(errors),
                SizedBox(height: 48.0),
                confirm,
                SizedBox(height: 12.0),
                continueButton
              ],
            )
          ),
      ),
    );
  }
}
