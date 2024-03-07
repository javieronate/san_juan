import 'dart:convert';
// import 'dart:js_interop_unsafe';
import 'package:flutter/material.dart';
import 'package:san_juan/models/pagosTransferidos.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:san_juan/repositories/cobrosRepository.dart';

import '../models/cobro.dart';
import '../repositories/cobrosRepository.dart';
import 'package:san_juan/widgets/pagoWidget.dart';

import '../services/cobrosServices.dart';

class ReporteScreen extends StatefulWidget {
  const ReporteScreen({Key? key}) : super(key: key);

  @override
  State<ReporteScreen> createState() => _ReporteScreenState();
}

class _ReporteScreenState extends State<ReporteScreen> {
  List<Cobro>? _listaPagosLocal;
  var _cargandoDatos = true;
  @override
  void initState() {
    super.initState();
    getPagos();
  }

  void getPagos() async {
    final repositorio = new CobrosRepository();
    _listaPagosLocal = await repositorio.leerPagos();
    if (_listaPagosLocal != null) {
      setState(() {
        _cargandoDatos = false;
      });
    }
  }

  void _transferirCobros() async {
    // transferir pagos a servidor
    final pagosTransferidos =
        (await CobrosServices().uploadCobros(_listaPagosLocal!));
    // borrar pagos de celular
    if (pagosTransferidos != null) {
      //final repositorio = new CobrosRepository();
      CobrosRepository().borrarTransferidos(pagosTransferidos!);
      // recargar lista
      _listaPagosLocal = await CobrosRepository().leerPagos();
      setState(() {});
    }
  }

  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'cobros.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE cobros('
            'idCuenta  INT PRIMARY KEY,'
            'idCobrador INT,'
            'idContrato INT, '
            'idCliente INT,'
            'claveCuenta TEXT, '
            'idTipoPago INT, '
            'diaPago TEXT,'
            'diaPagoA INT, '
            'diaPagoB INT,'
            'montoTotal TEXT, '
            'abono TEXT, '
            'totalPagado TEXT, '
            'idPersona INT, '
            'nombreCliente TEXT,'
            'idDireccion INT,'
            'calle TEXT, '
            'noExt TEXT,'
            'noInt TEXT, '
            'colonia TEXT,'
            'delegacion TEXT, '
            'municipio TEXT, '
            'referencias TEXT, '
            'cp TEXT,'
            'orden INT, '
            'cobrado INT,'
            'subido INT, '
            'fotoIdentificacion TEXT,'
            'fotoFachada TEXT,'
            'montoPagado INT,'
            'fechaSiguientePago TEXT,'
            'nota TEXT,visitado INT )');
      },
      version: 1,
    );
    return db;
  }

  @override
  Widget build(BuildContext context) {
    return _cargandoDatos
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: ElevatedButton.icon(
                  onPressed: _transferirCobros,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text('Transferir a servidor'),
                ),
              ),
              Expanded(
                child: _listaPagosLocal!.isEmpty
                    ? const Center(
                        child: Text("No hay cobros por ransferir a servidor"),
                      )
                    : ListView.builder(
                        itemCount: _listaPagosLocal!.length,
                        itemBuilder: (ctx, index) => PagoWidget(
                          pago: _listaPagosLocal![index],
                          // onSeleccionarCobro: (cobro) {
                          //   _seleccionarCobro(context, cobro);
                          // },
                        ),
                      ),
              ),
            ],
          );

    ListView.builder(
      itemCount: _listaPagosLocal!.length,
      itemBuilder: (ctx, index) => PagoWidget(
        pago: _listaPagosLocal![index],
        // onSeleccionarCobro: (cobro) {
        //   _seleccionarCobro(context, cobro);
        // },
      ),
    );
  }
}
