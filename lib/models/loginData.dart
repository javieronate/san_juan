// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  String token;
  int idPersona;
  String nombreUsuario;

  LoginData({
    required this.token,
    required this.idPersona,
    required this.nombreUsuario,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"],
        idPersona: json["idPersona"],
        nombreUsuario: json["nombreUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "idPersona": idPersona,
        "nombreUsuario": nombreUsuario,
      };
}
