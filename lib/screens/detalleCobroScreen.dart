import 'dart:io';

import 'package:flutter/material.dart';
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

  @override
  // initState() {
  //   //_cargarImagenIfe();
  //   super.initState();
  // }

  // irARegistro() {
  //   cambiarPagina();
  // }

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
    final alto = MediaQuery.of(context).size.height;
    final ancho = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cliente"),
      ),
      body: Container(
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
              Image.network(
                'https://dedalo.com.mx/sanJuan/public/imagenesClientes/ife.jpg',
                width: ancho - 100,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Fachada",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Image.network(
                'https://dedalo.com.mx/sanJuan/public/imagenesClientes/fachada.png',
                width: ancho - 100,
              ),
              const SizedBox(
                height: 30,
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
