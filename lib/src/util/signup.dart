import 'dart:async';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _SIGNUP_ENDPOINT = "https://brae.uqcloud.net/groupie/signup.php";
const String _ERROR_MESSAGE = "ERROR";
const String _USER_KEY = "USER_KEY";

class SignupResponse {
  String error;
  int userId;
  bool hasError;

  SignupResponse({this.error, this.userId, this.hasError});
}

Future<SignupResponse> signup(String email, String password) async {
  Map<String, String> request = {
    "email": email,
    "password": password
  };

  Response response = await post(_SIGNUP_ENDPOINT, body: request);

  if (response.statusCode != 200) {
    return SignupResponse(hasError: true,
        error: "Request failed with status: ${response.statusCode}.");
  }

  if (response.body.startsWith(_ERROR_MESSAGE)) {
    String error = response.body;
    return SignupResponse(hasError: true, error: error);
  }

  int result = int.tryParse(response.body);
  if (result == null) {
    return SignupResponse(hasError: true, error: "Unknown error: bad request response");
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(_USER_KEY, result);
  return SignupResponse(hasError: false, userId: result);
}
