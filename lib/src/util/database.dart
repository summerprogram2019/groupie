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
const String _PICTURE_DIR = _BASE_ENDPOINT + "/images/";

class Reply {
  final bool hasError;
  final String error;
  final Map<String, dynamic> result;

  final String request;

  Reply({this.hasError, this.error, this.result, this.request});
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

Future<User> getUser() async {
  int id = await getUserId();

  Map<String, String> request = {
    "account_id": id.toString()
  };

  Reply reply = await makeGetRequest(_USER_ENDPOINT, request);
  if (reply.hasError) {
    print(reply.request);
    print(reply.error);
    return null;
  }

  return User.fromJson(reply.result);
}

Future<String> _getImageUrl() async {
  User user = await getUser();

  Map<String, String> request = {
    "id": user.pictureId.toString()
  };

  Reply reply = await makeGetRequest(_PICTURE_ENDPOINT, request);
  if (reply.hasError) {
    print(reply.request);
    print(reply.error);
    return null;
  }

  return _PICTURE_DIR + reply.result["image"];
}

Future<Image> getProfileImage() async {
  String url = await _getImageUrl();

  if (url == null) {
    return Image.asset("sun.png");
  }

  return Image.network(url);
}

Future<ImageProvider> getProfileImageProvider() async {
  String url = await _getImageUrl();

  if (url == null) {
    return AssetImage("sun.png");
  }

  print(url);
  return NetworkImage(url);
}
