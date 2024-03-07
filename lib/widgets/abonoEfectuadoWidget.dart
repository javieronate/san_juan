import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/abonoEfectuado.dart';

class AbonoEfectuadoWidget extends StatelessWidget {
  const AbonoEfectuadoWidget({Key? key, required this.abonoEfectuado})
      : super(key: key);
  final AbonoEfectuado abonoEfectuado;
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##,##0.00');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          abonoEfectuado.noAbono.toString(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          abonoEfectuado.fecha,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          abonoEfectuado.recibo.toString(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          formatter.format(abonoEfectuado.monto),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          formatter.format(abonoEfectuado.saldo),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
