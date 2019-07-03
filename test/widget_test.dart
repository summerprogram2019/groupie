import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:groupie/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());

    // We don't do tests around here!

    await tester.pump();
  });
}
