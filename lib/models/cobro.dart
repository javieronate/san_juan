// To parse this JSON data, do
//
//     final cobro = cobroFromJson(jsonString);

import 'dart:convert';

List<Cobro> cobroFromJson(String str) =>
    List<Cobro>.from(json.decode(str).map((x) => Cobro.fromJson(x)));

String cobroToJson(List<Cobro> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cobro {
  int idCobrador;
  int idContrato;
  int idCliente;
  int idCuenta;
  String fechaVenta;
  String claveCuenta;
  int idTipoPago;
  String diaPago;
  int diaPagoA;
  int diaPagoB;
  String fechaProximoPago;
  int idPersona;
  String nombreCliente;
  int idDireccion;
  String calle;
  String noExt;
  String noInt;
  String colonia;
  String delegacion;
  String municipio;
  String referencias;
  String cp;
  int orden;
  int cobrado;
  int subido;
  int recibo;
  String fotoIdentificacion;
  String fotoFachada;
  double montoCobradoEnVisita;
  String fechaSiguientePago;
  String nota;
  int visitado;
  double montoTotal;
  double montoAbonoAcordado;
  String fechaPrimerPago;
  String fechaTerminacionCredito;
  double saldo;
  String porcentajePagado;
  int pagosAtrasados;
  int saldoAtrasado;
  String productos;
  String prontoPago;
  String relacionPagos;

  Cobro({
    required this.idCobrador,
    required this.idContrato,
    required this.idCliente,
    required this.idCuenta,
    required this.fechaVenta,
    required this.claveCuenta,
    required this.idTipoPago,
    required this.diaPago,
    required this.diaPagoA,
    required this.diaPagoB,
    required this.fechaProximoPago,
    required this.idPersona,
    required this.nombreCliente,
    required this.idDireccion,
    required this.calle,
    required this.noExt,
    required this.noInt,
    required this.colonia,
    required this.delegacion,
    required this.municipio,
    required this.referencias,
    required this.cp,
    required this.orden,
    required this.cobrado,
    required this.subido,
    required this.recibo,
    required this.fotoIdentificacion,
    required this.fotoFachada,
    required this.montoCobradoEnVisita,
    required this.fechaSiguientePago,
    required this.nota,
    required this.visitado,
    required this.montoTotal,
    required this.montoAbonoAcordado,
    required this.fechaPrimerPago,
    required this.fechaTerminacionCredito,
    required this.saldo,
    required this.porcentajePagado,
    required this.pagosAtrasados,
    required this.saldoAtrasado,
    required this.productos,
    required this.prontoPago,
    required this.relacionPagos,
  });

  factory Cobro.fromJson(Map<String, dynamic> json) => Cobro(
        idCobrador: json["idCobrador"],
        idContrato: json["idContrato"],
        idCliente: json["idCliente"],
        idCuenta: json["idCuenta"],
        fechaVenta: json["fechaVenta"],
        claveCuenta: json["claveCuenta"],
        idTipoPago: json["idTipoPago"],
        diaPago: json["diaPago"],
        diaPagoA: json["diaPagoA"],
        diaPagoB: json["diaPagoB"],
        fechaProximoPago: json["fechaProximoPago"],
        idPersona: json["idPersona"],
        nombreCliente: json["nombreCliente"],
        idDireccion: json["idDireccion"],
        calle: json["calle"],
        noExt: json["no_ext"],
        noInt: json["no_int"],
        colonia: json["colonia"],
        delegacion: json["delegacion"],
        municipio: json["municipio"],
        referencias: json["referencias"],
        cp: json["cp"],
        orden: json["orden"],
        cobrado: json["cobrado"],
        subido: json["subido"],
        recibo: json["recibo"],
        fotoIdentificacion: json["fotoIdentificacion"],
        fotoFachada: json["fotoFachada"],
        montoCobradoEnVisita: json["montoCobradoEnVisita"].toDouble(),
        fechaSiguientePago: json["fechaSiguientePago"],
        nota: json["nota"],
        visitado: json["visitado"],
        montoTotal: json["montoTotal"].toDouble(),
        montoAbonoAcordado: json["montoAbonoAcordado"].toDouble(),
        fechaPrimerPago: json["fechaPrimerPago"],
        fechaTerminacionCredito: json["fechaTerminacionCredito"],
        saldo: json["saldo"].toDouble(),
        porcentajePagado: json["porcentajePagado"],
        pagosAtrasados: json["pagosAtrasados"],
        saldoAtrasado: json["saldoAtrasado"],
        productos: json["productos"],
        prontoPago: json["prontoPago"],
        relacionPagos: json["relacionPagos"],
      );

  Map<String, dynamic> toJson() => {
        "idCobrador": idCobrador,
        "idContrato": idContrato,
        "idCliente": idCliente,
        "idCuenta": idCuenta,
        "fechaVenta": fechaVenta,
        "claveCuenta": claveCuenta,
        "idTipoPago": idTipoPago,
        "diaPago": diaPago,
        "diaPagoA": diaPagoA,
        "diaPagoB": diaPagoB,
        "fechaProximoPago": fechaProximoPago,
        "idPersona": idPersona,
        "nombreCliente": nombreCliente,
        "idDireccion": idDireccion,
        "calle": calle,
        "no_ext": noExt,
        "no_int": noInt,
        "colonia": colonia,
        "delegacion": delegacion,
        "municipio": municipio,
        "referencias": referencias,
        "cp": cp,
        "orden": orden,
        "cobrado": cobrado,
        "subido": subido,
        "recibo": recibo,
        "fotoIdentificacion": fotoIdentificacion,
        "fotoFachada": fotoFachada,
        "montoCobradoEnVisita": montoCobradoEnVisita,
        "fechaSiguientePago": fechaSiguientePago,
        "nota": nota,
        "visitado": visitado,
        "montoTotal": montoTotal,
        "montoAbonoAcordado": montoAbonoAcordado,
        "fechaPrimerPago": fechaPrimerPago,
        "fechaTerminacionCredito": fechaTerminacionCredito,
        "saldo": saldo,
        "porcentajePagado": porcentajePagado,
        "pagosAtrasados": pagosAtrasados,
        "saldoAtrasado": saldoAtrasado,
        "productos": productos,
        "prontoPago": prontoPago,
        "relacionPagos": relacionPagos,
      };
}
