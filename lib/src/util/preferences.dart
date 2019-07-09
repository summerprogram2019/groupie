import 'dart:async';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';






//the values for the switches and sliders
bool _silenceNotificationToggle = false;
bool _pushNotificationToggle = false;

double _maxCost = 100;
var _maxCostString = '100';


double _maxDistance = 20;
var _maxDistanceString = '20';