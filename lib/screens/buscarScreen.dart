import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:san_juan/screens/recibosScreen.dart';
import 'package:san_juan/screens/resultadosBusquedaScreen.dart';

import '../models/cobro.dart';
import '../repositories/cobrosRepository.dart';
import '../services/cobrosServices.dart';
import '../widgets/cobroWidget.dart';
import '../widgets/pagoWidget.dart';
import '../widgets/resultadoBusquedaWidget.dart';
import 'detalleCobroScreen.dart';
import 'impresionScreen.dart';

class BuscarScreen extends StatefulWidget {
  const BuscarScreen({Key? key}) : super(key: key);

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
  List<Cobro>? _listaBusqueda;
  var _resutladosVacios = true;
  @override
  void initState() {
    super.initState();
  }

  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _cuentaController = TextEditingController();

  void _buscarEnServidor() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final nombreIndicado = _nombreController.text;
    final direccionIndicada = _direccionController.text;
    final cuentaIndicada = _cuentaController.text;
    setState(() {
      _listaBusqueda = [];
      _resutladosVacios = true;
    });
    if (nombreIndicado.isNotEmpty || cuentaIndicada.isNotEmpty) {
      final listaServidor = await CobrosServices().buscarCobrosServidor(
          nombreIndicado, direccionIndicada, cuentaIndicada);
      if (listaServidor != null && listaServidor!.isNotEmpty) {
        setState(() {
          _listaBusqueda = listaServidor;
          _resutladosVacios = false;
        });
      }
    }
  }

  void _buscar() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final nombreIndicado = _nombreController.text;
    final direccionIndicada = _direccionController.text;
    final cuentaIndicada = _cuentaController.text;

    setState(() {
      _listaBusqueda = [];
      _resutladosVacios = true;
    });

    if (nombreIndicado.isNotEmpty ||
        direccionIndicada.isNotEmpty ||
        cuentaIndicada.isNotEmpty) {
      final repositorio = CobrosRepository();
      _listaBusqueda = (await repositorio.buscarCobros(
          nombreIndicado, direccionIndicada, cuentaIndicada));
      if (_listaBusqueda != null && _listaBusqueda!.isNotEmpty) {
        setState(() {
          _resutladosVacios = false;
        });
      }
    }
  }

  void _seleccionarItemEncontrado(BuildContext context, Cobro cobro) {
    if (cobro.montoCobradoEnVisita > 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => RecibosScreen(
            cobro: cobro,
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => DetalleCobroScreen(
            cobro: cobro,
          ),
        ),
      );
    }
  }

  _relacionEncontrados() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            ResultadosBusquedaScreen(listaCobrosEncontrados: _listaBusqueda!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final alto = MediaQuery.of(context).size.height;
    final ancho = MediaQuery.of(context).size.width;
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Buscar clientes"),
      // ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Cliente'),
              controller: _nombreController,
            ),
            const SizedBox(height: 3),
            TextField(
              decoration: const InputDecoration(labelText: 'Cuenta'),
              controller: _cuentaController,
            ),
            const SizedBox(height: 3),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Dirección (sólo busqueda local)'),
              controller: _direccionController,
            ),
            const SizedBox(height: 3),
            ElevatedButton.icon(
              onPressed: _buscar,
              icon: const Icon(Icons.find_in_page),
              label: const Text('Buscar'),
            ),
            const SizedBox(height: 3),
            ElevatedButton.icon(
              onPressed: _buscarEnServidor,
              icon: const Icon(Icons.download_outlined),
              label: const Text('Buscar en servidor'),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 5,
            ),
            Expanded(
              child: _resutladosVacios
                  ? const Center(
                      child: Text("No hay resultados que mostrar"),
                    )
                  : ListView.builder(
                      itemCount: _listaBusqueda!.length,
                      itemBuilder: (ctx, index) => ResultadoBusquedaWidget(
                        cobro: _listaBusqueda![index],
                        onSeleccionarItem: (cobro) {
                          _seleccionarItemEncontrado(context, cobro);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
