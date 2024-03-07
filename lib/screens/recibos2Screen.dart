import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/cobro.dart';

class Recibos2Screen extends StatefulWidget {
  const Recibos2Screen({Key? key}) : super(key: key);
  //final Cobro cobro;

  @override
  State<Recibos2Screen> createState() => _Recibos2ScreenState();
}

class _Recibos2ScreenState extends State<Recibos2Screen> {
  //late Cobro cobro;

  @override
  void initState() {
    super.initState();
    //cobro = widget.cobro;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de pago"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
            // children: [
            //   Text(
            //     cobro.nombreCliente,
            //     style: Theme.of(context).textTheme.titleMedium,
            //   ),
            //   Text(
            //     "${cobro.calle} ${cobro.noExt} ${cobro.noInt}",
            //     style: Theme.of(context).textTheme.bodyLarge,
            //   ),
            //   Text(
            //     "${cobro.colonia} ${cobro.cp}",
            //     style: Theme.of(context).textTheme.bodyMedium,
            //   ),
            //   Text(
            //     cobro.referencias,
            //     style: Theme.of(context).textTheme.bodySmall,
            //   ),
            //   Text(
            //     cobro.delegacion,
            //     style: Theme.of(context).textTheme.bodySmall,
            //   ),
            //   Text(
            //     "Cuenta: ${widget.cobro.claveCuenta}",
            //     style: Theme.of(context).textTheme.bodyMedium,
            //   ),
            //   Text(
            //     "Saldo: ${widget.cobro.saldo}",
            //     style: Theme.of(context).textTheme.bodyMedium,
            //   ),
            //   const SizedBox(
            //     height: 30,
            //   ),
            //   Text(
            //     "\$${cobro.montoAbonoAcordado}",
            //     style: Theme.of(context).textTheme.displayLarge,
            //   ),
            //   const Padding(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: 40,
            //       vertical: 10,
            //     ),
            //   ),
            //   const SizedBox(height: 30),
            //   ElevatedButton.icon(
            //     onPressed: () {},
            //     icon: const Icon(Icons.thumb_up),
            //     label: const Text('Registrar pago'),
            //   ),
            //   const SizedBox(height: 30),
            //   ElevatedButton.icon(
            //     onPressed: () {},
            //     icon: const Icon(Icons.warning),
            //     label: const Text('Visitado sin pago'),
            //   ),
            // ],
            ),
      ),
    );
  }
}
