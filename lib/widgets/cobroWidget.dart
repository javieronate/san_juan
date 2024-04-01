import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:san_juan/models/cobro.dart';

class CobroWidget extends StatelessWidget {
  const CobroWidget({
    Key? key,
    required this.cobro,
    required this.onSeleccionarCobro,
  }) : super(key: key);
  final Cobro cobro;
  final void Function(Cobro cobro) onSeleccionarCobro;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: InkWell(
          onTap: () {
            onSeleccionarCobro(cobro);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.menu),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cobro.nombreCliente,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          cobro.calle + " " + cobro.noExt + " " + cobro.noInt,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          cobro.colonia + " " + cobro.cp,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          cobro.referencias,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          cobro.delegacion,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "Cuenta: ${cobro.claveCuenta}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "Saldo: ${cobro.saldo}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "\$${cobro.montoAbonoAcordado} ",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        // Text(
                        //   "Orden: ${cobro.orden}",
                        //   style: Theme.of(context).textTheme.bodyMedium,
                        // ),
                        // Text(
                        //   "foto ine: ${cobro.fotoIdentificacion}",
                        //   style: Theme.of(context).textTheme.bodyMedium,
                        // ),
                        // Text(
                        //   "foto fachada: ${cobro.fotoFachada}",
                        //   style: Theme.of(context).textTheme.bodyMedium,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
