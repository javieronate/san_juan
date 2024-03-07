import 'package:flutter/material.dart';

import '../models/cobro.dart';
import '../widgets/cobroWidget.dart';
import 'detalleCobroScreen.dart';

class ResultadosBusquedaScreen extends StatefulWidget {
  const ResultadosBusquedaScreen(
      {Key? key, required this.listaCobrosEncontrados})
      : super(key: key);

  final List<Cobro> listaCobrosEncontrados;
  @override
  State<ResultadosBusquedaScreen> createState() =>
      _ResultadosBusquedaScreenState();
}

class _ResultadosBusquedaScreenState extends State<ResultadosBusquedaScreen> {
  void _seleccionarCobro(BuildContext context, Cobro cobro) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DetalleCobroScreen(
          cobro: cobro,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados de búsqueda"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            //   child: ElevatedButton.icon(
            //     onPressed: _getCobros,
            //     icon: const Icon(Icons.cloud_download),
            //     label: const Text('Recargar cobros'),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.listaCobrosEncontrados.length,
                itemBuilder: (ctx, index) => CobroWidget(
                  cobro: widget.listaCobrosEncontrados[index],
                  onSeleccionarCobro: (cobro) {
                    _seleccionarCobro(context, cobro);
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
