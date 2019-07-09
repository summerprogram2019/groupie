import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:groupie/main.dart';
import 'package:groupie/screens.dart';
import 'package:groupie/util.dart' show buildTestableWidget;

void main() {
  testWidgets('Switches to the signup screen from the login screen',
          (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());

    // We don't do tests around here!

    LoginScreen widget = new LoginScreen();
    await tester.pumpWidget(buildTestableWidget(widget));

    expect(find.byKey(Key("signup_button")), findsOneWidget);
    expect(find.byType(SignupPage), findsNothing);

    await tester.tap(find.byKey(Key('signup_button')));
    await tester.pumpAndSettle();

    expect(find.byType(SignupPage), findsOneWidget);

    await tester.pump();
  });
}
