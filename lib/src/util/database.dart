import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:groupie/model.dart';

import 'login.dart' show getUserId;

const String _ERROR_MESSAGE = "ERROR";
const String _BASE_ENDPOINT = "https://brae.uqcloud.net/groupie";
const String _USER_ENDPOINT = _BASE_ENDPOINT + "/user.php";

class Reply {
  bool hasError;
  String error;
  Map<String, dynamic> result;

  Reply({this.hasError, this.error, this.result});
}

Future<Reply> makeRequest(String endpoint, Map<String, String> request) async {
  Response response = await post(_USER_ENDPOINT, body: request);

  if (response.statusCode != 200) {
    return Reply(hasError: true,
        error: "Request failed with status: ${response.statusCode}.");
  }

  if (response.body.startsWith(_ERROR_MESSAGE)) {
    String error = response.body.substring(0, _ERROR_MESSAGE.length);
    return Reply(hasError: true, error: error);
  }

  try {
    Map<String, dynamic> result = jsonDecode(response.body);
    return Reply(hasError: false, result: result);
  } catch (exception) {
    return Reply(hasError: true, error: "Invalid response: " + exception.toString());
  }
}

Future<User> getUser() async {
  int id = await getUserId();

  Map<String, String> request = {
    "user_key": id.toString()
  };

  Reply reply = await makeRequest(_USER_ENDPOINT, request);
  if (reply.hasError) {
    print(reply.error);
    return null;
  }

  return User.fromJson(reply.result);
}