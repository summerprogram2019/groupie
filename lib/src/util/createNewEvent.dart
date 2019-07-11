import 'dart:async';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'event.dart';

const String _CREATENEWEVENT_ENDPOINT =
    "https://brae.uqcloud.net/groupie/create_new_event.php";
const String _ERROR_MESSAGE = "ERROR";
const String _USER_KEY = "USER_KEY";

class CreateNewEventResponse {
  String error;
  int eventId;
  bool hasError;

  CreateNewEventResponse({this.error, this.eventId, this.hasError});
}

Future<CreateNewEventResponse> createNewEvent(Event event) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> request = event.getRequestMap(prefs.getInt(_USER_KEY));

//  return CreateNewEventResponse(error: event.getField(), hasError: true, eventId: 0);

  print(request);
  
  Response response = await post(_CREATENEWEVENT_ENDPOINT, body: request);

  if (response.statusCode != 200) {
    return CreateNewEventResponse(
        hasError: true,
        error: "Request failed with status: ${response.statusCode}.");
  }

  if (response.body.startsWith(_ERROR_MESSAGE)) {
    String error = response.body;
    return CreateNewEventResponse(hasError: true, error: error);
  }

  int result = int.tryParse(response.body);
  if (result == null) {
    return CreateNewEventResponse(
        hasError: true, error: "Unknown error: bad request response");
  }

//  prefs.setInt(_USER_KEY, result);
  return CreateNewEventResponse(hasError: false, eventId: result);
}
