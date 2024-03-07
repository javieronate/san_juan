import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:san_juan/models/loginData.dart';

class LogServices {
  Future<LoginData?> login(
    String usuario,
    String password,
  ) async {
    var client = http.Client();
    var uri = Uri.parse('https://dedalo.com.mx/sanJuan/public/api/login');
    var response = await client.post(uri,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json"
        },
        body: jsonEncode(
          {"usuario": usuario, "password": password},
        ));
    //print(jsonDecode(response as String));
    if (response.statusCode == 400) {
      return null;
    }

    if (response.statusCode == 200) {
      var json = response.body;
      return loginDataFromJson(json);
    }
  }
}
