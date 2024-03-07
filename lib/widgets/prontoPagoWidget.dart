import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/ProntoPago.dart';

class ProntoPagoWidget extends StatelessWidget {
  const ProntoPagoWidget({Key? key, required this.prontoPago})
      : super(key: key);
  final ProntoPago prontoPago;
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##,##0.00');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          prontoPago.fecha,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          formatter.format(prontoPago.cantidad),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
