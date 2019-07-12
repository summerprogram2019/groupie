import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:groupie/model.dart';

import 'login.dart' show getUserId;

const String _ERROR_MESSAGE = "ERROR";
const String _BASE_ENDPOINT = "https://brae.uqcloud.net/groupie";
const String _USER_ENDPOINT = _BASE_ENDPOINT + "/profile_user.php";
const String _PICTURE_ENDPOINT = _BASE_ENDPOINT + "/pictures.php";
const String _PARTICIPANT_ENDPOINT = _BASE_ENDPOINT + "/participations.php";
const String _EVENT_LIST_ENDPOINT = _BASE_ENDPOINT + "/list_events.php";
const String _EVENT_DETAIL_ENDPOINT = _BASE_ENDPOINT + "/events.php";
const String _ADD_PARTICIPANT = _BASE_ENDPOINT + "/add_participations.php";
const String _PICTURE_DIR = _BASE_ENDPOINT + "/images/";

class Reply {
  final bool hasError;
  final String error;
  final Map<String, dynamic> result;
  final List<dynamic> listResult;

  final String request;

  Reply({this.hasError, this.error, this.result, this.request, this.listResult});
}

Reply _makeRequest(Response response) {
  if (response.statusCode != 200) {
    return Reply(hasError: true,
        error: "Request failed with status: ${response.statusCode}.");
  }

  if (response.body.startsWith(_ERROR_MESSAGE)) {
    String error = response.body.substring(0, _ERROR_MESSAGE.length);
    return Reply(hasError: true, error: error, request: response.request.toString());
  }

  try {
    if (response.body.startsWith("[")) {
      List<dynamic> result = jsonDecode(response.body);
      return Reply(hasError: false, listResult: result, request: response.request.toString());
    }
    Map<String, dynamic> result = jsonDecode(response.body);
    return Reply(hasError: false, result: result, request: response.request.toString());
  } catch (exception) {
    return Reply(
        hasError: true,
        error: "Invalid response: " + exception.toString(),
        request: response.request.toString()
    );
  }
}

Future<Reply> makeGetRequest(String endpoint, Map<String, String> request) async {
  String requests = "";
  for (MapEntry<String, String> entry in request.entries) {
    requests += entry.key + "=" + entry.value + "&";
  }
  Response response = await get(endpoint + "?" + requests);

  return _makeRequest(response);
}

Future<Reply> makePostRequest(String endpoint, Map<String, String> request) async {
  Response response = await post(endpoint, body: request);

  return _makeRequest(response);
}

Future<User> _getUserDetails(int userId) async {
  Map<String, String> request = {
    "account_id": userId.toString()
  };

  Reply reply = await makeGetRequest(_USER_ENDPOINT, request);
  if (reply.hasError) {
    print(reply.request);
    print(reply.error);
    return null;
  }

  return User.fromJson(reply.result);
}

Future<User> getUser() async {
  int id = await getUserId();

  return _getUserDetails(id);
}

Future<String> getImageUrl(int pictureId) async {
  Map<String, String> request = {
    "id": pictureId.toString()
  };

  Reply reply = await makeGetRequest(_PICTURE_ENDPOINT, request);
  if (reply.hasError) {
    print(reply.request);
    print(reply.error);
    return null;
  }

  return _PICTURE_DIR + reply.result["image"];
}

Future<String> _getImageUrl() async {
  User user = await getUser();

  return getImageUrl(int.parse(user.pictureId));
}

Future<Image> getProfileImage() async {
  String url = await _getImageUrl();

  if (url == null) {
    return Image.asset("sun.png");
  }

  return Image.network(url);
}

Future<ImageProvider> getProfileImageProviderById(User user) async {
  String url = await getImageUrl(int.parse(user.pictureId));

  if (url == null) {
    return AssetImage("sun.png");
  }

  return NetworkImage(url);
}

Future<ImageProvider> getProfileImageProvider() async {
  String url = await _getImageUrl();

  if (url == null) {
    return AssetImage("sun.png");
  }

  return NetworkImage(url);
}

Future<List<User>> _getParticipants(int eventId, String role) async {
  Map<String, String> request = {
    "event_id": eventId.toString()
  };

  Reply reply = await makeGetRequest(_PARTICIPANT_ENDPOINT, request);
  if (reply.hasError) {
    print(reply.request);
    print(reply.error);
    return null;
  }

  List<User> users = [];
  for (var user in reply.listResult) {
    if (user['role'] == role) {
      users.add(await _getUserDetails(int.parse(user['account_id'])));
    }
  }

  return users;
}

Future<List<User>> getApprovedParticipants(int eventId) async {
  return _getParticipants(eventId, 'approved');
}

Future<List<User>> getPendingParticipants(int eventId) {
  return _getParticipants(eventId, 'pending');
}

Future<List<Event>> getEvents() async {
  Reply reply = await makeGetRequest(_EVENT_LIST_ENDPOINT, {});

  if (reply.hasError) {
    print(reply.request);
    print(reply.error);
    return null;
  }

  List<Event> events = [];
  for (var event in reply.listResult) {
    print(event);
    events.add(Event.fromJson(event));
  }

  return events;
}

//fetches the list of upcoming user events (the ones a user has 'swiped' to agree to)
Future<List<Event>> getUpcomingEventsForUser(int userID) async {
  Reply reply = await makeGetRequest(_EVENT_LIST_ENDPOINT, {
    "user": userID.toString()
  });

  if (reply.hasError) {
    print(reply.request);
    print(reply.error);
    return null;
  }

  List<Event> events = [];
  for (var event in reply.listResult) {
    print(event);
    events.add(Event.fromJson(event));
  }

  return events;
}

//fetches the details for a given event Id
Future<Event> getEventDetails(int activityId) async {
  Map<String, String> request = {
    "event_id": activityId.toString()
  };

  Reply reply = await makeGetRequest(_EVENT_DETAIL_ENDPOINT, request);
  if (reply.hasError) {
    print(reply.request);
    print(reply.error);
    return null;
  }

  return Event.fromJson(reply.result);
}

//fetching the event image
Future<Image> getEventImage() async {
  String url = await _getImageUrl();

  if (url == null) {
    return Image.asset("sun.png");
  }

  return Image.network(url);
}

Future<Image> getEventImageById(Event event) async {
  String url = await getImageUrl(event.pictureId);

  if (url == null) {
    return Image.asset("sun.png");
  }

  return Image.network(url);
}

Future<ImageProvider> getEventImageProviderById(Event event) async {
  String url = await getImageUrl(event.pictureId);

  if (url == null) {
    return AssetImage("sun.png");
  }

  return NetworkImage(url);
}

Future<ImageProvider> getEventImageProvider() async {
  String url = await _getImageUrl();

  if (url == null) {
    return AssetImage("sun.png");
  }

  return NetworkImage(url);
}

void acceptEvent(Event event) async {
  Map<String, String> request = {
    "event_id": event.id.toString(),
    "activity_id": event.activityId.toString(),
    "role": "pending",
    "account_id": (await getUserId()).toString(),
  };
  print(request);

  Response response = await get(_ADD_PARTICIPANT, headers: request);

  if (response.statusCode != 200) {
    // TODO: Ignore error whoops
    print("bad response");
  }

  if (!response.body.startsWith("Successful")) {
    String error = response.body;
    // TODO: Ignore error whoops
    print(error);
  }
}
