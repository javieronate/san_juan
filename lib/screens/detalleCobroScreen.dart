import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart';
import 'package:san_juan/models/cobro.dart';
import 'package:san_juan/screens/registroCobroScreen.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:image_downloader/image_downloader.dart';

class DetalleCobroScreen extends StatefulWidget {
  const DetalleCobroScreen({Key? key, required this.cobro}) : super(key: key);

  final Cobro cobro;
  @override
  State<DetalleCobroScreen> createState() => _DetalleCobroScreenState();
}

class _DetalleCobroScreenState extends State<DetalleCobroScreen> {
  //String? _imagenIfe;
  // bool cargada = true;
  String? _rutaFachada;
  String? _rutaIne;
  bool _cargandoFotos = true;

  Directory? directory;

  @override
  initState() {
    super.initState();
    _definirFotos();
  }

  void _definirFotos() async {
    directory = await getExternalStorageDirectory();
    if (await directory!.exists()) {
      if (widget.cobro.fotoFachada.isEmpty) {
        setState(() {
          _rutaFachada = "${directory!.path}/sinFotoCasa.png";
        });
      } else {
        final nombre = widget.cobro.fotoFachada;
        setState(() {
          _rutaFachada = directory!.path + '/' + nombre;
        });
      }
      if (widget.cobro.fotoIdentificacion.isEmpty) {
        setState(() {
          _rutaIne = "${directory!.path}/sinImagenIne.png";
        });
      } else {
        final nombre2 = widget.cobro.fotoIdentificacion;
        setState(() {
          _rutaIne = directory!.path + '/' + nombre2;
        });
      }
    }
    setState(() {
      _cargandoFotos = false;
    });
  }

  cambiarPagina() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => RegistroCobroScreen(
          cobro: widget.cobro,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final alto = MediaQuery.of(context).size.height;
    final ancho = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cliente"),
      ),
      body: _cargandoFotos
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: ancho,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.cobro.nombreCliente,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "${widget.cobro.calle} ${widget.cobro.noExt} ${widget.cobro.noInt}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "${widget.cobro.colonia} ${widget.cobro.cp}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      widget.cobro.referencias,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      widget.cobro.delegacion,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      "Cuenta: ${widget.cobro.claveCuenta}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "Saldo: ${widget.cobro.saldo}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "\$${widget.cobro.montoAbonoAcordado}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Identificación",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Image.file(
                      File(_rutaIne!),
                      //height: 245.0,
                      width: 245.0,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Fachada",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Image.file(
                      File(_rutaFachada!),
                      //height: 245.0,
                      width: 245.0,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        cambiarPagina();
                      },
                      icon: const Icon(Icons.payment_rounded),
                      label: const Text('Anotar pago'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
