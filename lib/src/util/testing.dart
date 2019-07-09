import 'package:flutter/material.dart';

import 'package:groupie/main.dart' show MyApp;

Widget buildTestableWidget(Widget widget) {
  return new MaterialApp(
    routes: MyApp.routes,
    home: widget,
  );
}