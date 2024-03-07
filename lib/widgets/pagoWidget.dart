import 'package:flutter/material.dart';
import 'package:san_juan/models/cobro.dart';

class PagoWidget extends StatelessWidget {
  const PagoWidget({
    Key? key,
    required this.pago,
    // required this.onSeleccionarCobro,
  }) : super(key: key);
  final Cobro pago;
  // final void Function(Cobro cobro) onSeleccionarCobro;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon(Icons.menu),
            // const SizedBox(width: 20),

            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pago.nombreCliente,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "\$${pago.montoCobradoEnVisita}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
