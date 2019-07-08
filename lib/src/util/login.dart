import 'dart:async';

import 'package:http/http.dart';

const String LOGIN_ENDPOINT = "https://brae.uqcloud.net/groupie/login.php";
const String ERROR_MESSAGE = "ERROR";

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

  // Await the http get response, then decode the json-formatted responce.
  Response response = await post(LOGIN_ENDPOINT, body: request);

  if (response.statusCode == 200) {
    if (response.body.startsWith(ERROR_MESSAGE)) {
      String error = response.body.substring(0, ERROR_MESSAGE.length);
      return LoginResponse(hasError: true, error: error);
    } else {
      int result = int.tryParse(response.body);
      if (result == null) {
        return LoginResponse(hasError: true, error: "Unknown error: bad request response");
      }
      return LoginResponse(hasError: false, userId: result);
    }
  } else {
    return LoginResponse(hasError: true, error: "Request failed with status: ${response.statusCode}.");
  }
}