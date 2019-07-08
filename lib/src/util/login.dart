import 'dart:async';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _LOGIN_ENDPOINT = "https://brae.uqcloud.net/groupie/login.php";
const String _ERROR_MESSAGE = "ERROR";
const String _USER_KEY = "USER_KEY";

class LoginResponse {
  String error;
  int userId;
  bool hasError;

  LoginResponse({this.error, this.userId, this.hasError});
}

Future<LoginResponse> login(String email, String password) async {
  Map<String, String> request = {
    "email": email,
    "password": password
  };

  Response response = await post(_LOGIN_ENDPOINT, body: request);

  if (response.statusCode != 200) {
    return LoginResponse(hasError: true,
        error: "Request failed with status: ${response.statusCode}.");
  }

  if (response.body.startsWith(_ERROR_MESSAGE)) {
    String error = response.body.substring(0, _ERROR_MESSAGE.length);
    return LoginResponse(hasError: true, error: error);
  }

  int result = int.tryParse(response.body);
  if (result == null) {
    return LoginResponse(hasError: true, error: "Unknown error: bad request response");
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(_USER_KEY, result);
  return LoginResponse(hasError: false, userId: result);
}

Future<bool> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove(_USER_KEY);
}

Future<int> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(_USER_KEY);
}
