import 'package:http/http.dart';

Future<int> login(String email, String password) async {
  String url = "https://brae.uqcloud.net/groupie/login.php";
  Map<String, String> request = {
    "email": email,
    "password": password
  };

  // Await the http get response, then decode the json-formatted responce.
  Response response = await post(url, body: request);

  if (response.statusCode == 200) {
    if (response.body == "ERROR") {
      print("ah fuck");
      return null;
    } else {
      int result = int.tryParse(response.body);
      return result;
    }
  } else {
    print("Request failed with status: ${response.statusCode}.");
    return null;
  }
}