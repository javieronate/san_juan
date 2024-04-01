import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:san_juan/models/cobro.dart';
import 'package:san_juan/models/pagosTransferidos.dart';
import 'package:san_juan/repositories/dataService.dart';

class CobrosServices {
  DataService _dataService = DataService();

  Future<List<Cobro>?> buscarCobrosServidor(nombre, direccion, cuenta) async {
    String nombreEnvio = '';
    String direccionEnvio = '';
    String cuentaEnvio = '';
    if (nombre != "") {
      nombreEnvio = nombre;
    }
    if (cuenta != "") {
      cuentaEnvio = cuenta;
    }
    if (direccion != "") {
      direccionEnvio = direccion;
    }
    if (nombreEnvio.isNotEmpty ||
        cuentaEnvio.isNotEmpty ||
        direccionEnvio.isNotEmpty) {
      var token = await _dataService.getItem("token");
      var idPersona = await _dataService.getItem("idPersona");
      if (token != null && idPersona != null) {
        var client = http.Client();
        var uri =
            Uri.parse('https://dedalo.com.mx/sanJuan/public/api/pagos/buscar');
        var response = await client.post(uri,
            headers: {
              "Content-Type": "application/json; charset=UTF-8",
              "Accept": "application/json",
              "Authorization": "Bearer $token"
            },
            body: jsonEncode(
              {
                "nombre": nombreEnvio,
                "direccion": direccionEnvio,
                "cuenta": cuentaEnvio
              },
            ));
        //print(jsonDecode(response as String));
        if (response.statusCode == 400) {
          return null;
        }
        if (response.statusCode == 200) {
          var json = response.body;

          return cobroFromJson(json);
        }
      }
    }
  }

  Future<List<Cobro>?> getCobros() async {
    // traer valores de token y idCobrador de guardados
    var token = await _dataService.getItem("token");
    // print(token);
    var idPersona = await _dataService.getItem("idPersona");
    // print(idPersona);
    if (token != null && idPersona != null) {
      var client = http.Client();
      var uri =
          Uri.parse('https://dedalo.com.mx/sanJuan/public/api/cobros/lista');
      var response = await client.post(uri,
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(
            {"idCobrador": idPersona},
          ));
      //print(jsonDecode(response as String));
      if (response.statusCode == 400) {
        return null;
      }

      if (response.statusCode == 200) {
        var json = response.body;
        return cobroFromJson(json);
      }
    }
  }

  Future<List<dynamic>?> uploadCobros(List<Cobro> listaPagosLocal) async {
    // final listaJson = jsonEncode(listaPagosLocal);

    //print(exportar);

    //print(listaJson);
    // traer valores de token y idCobrador de guardados
    final token = await _dataService.getItem("token");
    if (token != null) {
      var client = http.Client();
      var uri =
          Uri.parse('https://dedalo.com.mx/sanJuan/public/api/pagos/recibir');
      var response = await client.post(uri,
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(
            {"pagos": listaPagosLocal},
          ));
      var json = response.body;
      var respuesta = jsonDecode(json);
      var lista = respuesta['pagosTransferidos'];
      return lista;
    }
  }
}
