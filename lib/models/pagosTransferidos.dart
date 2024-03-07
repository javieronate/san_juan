// To parse this JSON data, do
//
//     final pagosTransferidos = pagosTransferidosFromJson(jsonString);

import 'dart:convert';

List<PagosTransferidos> pagosTransferidosFromJson(String str) =>
    List<PagosTransferidos>.from(
        json.decode(str).map((x) => PagosTransferidos.fromJson(x)));

String pagosTransferidosToJson(List<PagosTransferidos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PagosTransferidos {
  int idCuenta;
  bool grabado;

  PagosTransferidos({
    required this.idCuenta,
    required this.grabado,
  });

  factory PagosTransferidos.fromJson(Map<String, dynamic> json) =>
      PagosTransferidos(
        idCuenta: json["idCuenta"],
        grabado: json["grabado"],
      );

  Map<String, dynamic> toJson() => {
        "idCuenta": idCuenta,
        "grabado": grabado,
      };
}
