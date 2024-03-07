// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:san_juan/models/cobro.dart';
// import 'package:san_juan/models/estatus.dart';
import 'package:san_juan/screens/detalleCobroScreen.dart';
import 'package:san_juan/repositories/cobrosRepository.dart';
import 'package:san_juan/services/cobrosServices.dart';
import 'package:san_juan/widgets/cobroWidget.dart';
// import 'package:san_juan/repositories/dataService.dart';

class CobrosScreen extends StatefulWidget {
  const CobrosScreen({Key? key}) : super(key: key);
  @override
  State<CobrosScreen> createState() => _CobrosScreenState();
}

class _CobrosScreenState extends State<CobrosScreen> {
  List<Cobro>? _listaCobros;
  List<Cobro>? _listaCobrosLocal;
  var _cargandoDatos = true;

  @override
  void initState() {
    super.initState();
    _getCobrosDeLocal();
  }

  void _getCobrosDeLocal() async {
    // print("traer de base de cel");
    final repositorio = CobrosRepository();
    _listaCobrosLocal = await repositorio.leerCobros();
    if (_listaCobrosLocal != null) {
      setState(() {
        _cargandoDatos = false;
      });
    }
  }

  /*void _recargarCobros() async {}*/

  void ponerAlerta() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Alerta'),
        content: const Text(
            'Tiene registros por transferir al servidor. Primero transfieralos antes de recargar del servidor.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Regresar'),
          ),
        ],
      ),
    );
  }

  Future<int> _getCobros() async {
    // validar si hay registros por transferir

    final listaPorTransferir = await CobrosRepository().leerPagos();
    if (listaPorTransferir.isNotEmpty) {
      ponerAlerta();
    } else {
      _listaCobros = await CobrosServices().getCobros();
      final repositorio = CobrosRepository();
      if (_listaCobros != null) {
        final terminado = repositorio.ponerCobros(_listaCobros!);
        _listaCobrosLocal = await repositorio.leerCobros();
        setState(() {});
        if (await terminado) {
          final actualizado = repositorio.ponerCargado();
          if (await actualizado == 1) {
            return 1;
          }
        }
      }
    }
    return 0;
  }

  void _seleccionarCobro(BuildContext context, Cobro cobro) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (ctx) => DetalleCobroScreen(
          cobro: cobro,
        ),
      ),
    )
        .then((_) {
      _getCobrosDeLocal();
    });
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: ElevatedButton.icon(
                  onPressed: _getCobros,
                  icon: const Icon(Icons.cloud_download),
                  label: const Text('Recargar cobros'),
                ),
              ),
              Expanded(
                child: _listaCobrosLocal!.isEmpty
                    ? const Center(
                        child: Text("No se encontraron cobros por hacer"),
                      )
                    : ListView.builder(
                        itemCount: _listaCobrosLocal!.length,
                        itemBuilder: (ctx, index) => CobroWidget(
                          cobro: _listaCobrosLocal![index],
                          onSeleccionarCobro: (cobro) {
                            _seleccionarCobro(context, cobro);
                          },
                        ),
                      ),
              ),
            ],
          );
  }
}
