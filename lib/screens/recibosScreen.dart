import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:san_juan/models/ProntoPago.dart';
import 'package:san_juan/models/abonoEfectuado.dart';
import 'package:san_juan/screens/impresionScreen.dart';
import 'package:san_juan/widgets/prontoPagoWidget.dart';

import '../models/cobro.dart';
import '../widgets/abonoEfectuadoWidget.dart';

class RecibosScreen extends StatefulWidget {
  const RecibosScreen({Key? key, required this.cobro}) : super(key: key);
  final Cobro cobro;

  @override
  State<RecibosScreen> createState() => _RecibosScreenState();
}

class _RecibosScreenState extends State<RecibosScreen> {
  late Cobro cobro;
  List<ProntoPago> _itemsProntoPago = [];
  List<AbonoEfectuado> _itemsAbonosEfectuados = [];
  @override
  void initState() {
    super.initState();
    cobro = widget.cobro;
    hacerListaProntoPago();
    hacerListaAbonosEfectuados();
  }

  void hacerListaProntoPago() {
    final arrProntoPago = cobro.prontoPago.split('y');
    if (arrProntoPago.length > 1 ||
        (arrProntoPago.length == 1 && arrProntoPago[0].isNotEmpty)) {
      for (var i = 0; i < arrProntoPago.length; i++) {
        final arrItem = arrProntoPago[i].split(' ');
        final fecha = arrItem[0];
        final cantidad = double.parse(arrItem[1]);
        ProntoPago nuevo = ProntoPago(fecha: fecha, cantidad: cantidad);
        _itemsProntoPago.add(nuevo);
      }
    }
  }

  void hacerListaAbonosEfectuados() {
    final arrAbonosEfectuados = cobro.relacionPagos.split('y');
    if (arrAbonosEfectuados.length > 1 ||
        (arrAbonosEfectuados.length == 1 &&
            arrAbonosEfectuados[0].isNotEmpty)) {
      for (var i = 0; i < arrAbonosEfectuados.length; i++) {
        final arrItem = arrAbonosEfectuados[i].split(' ');
        final noAbono = int.parse(arrItem[0]);
        final fecha = arrItem[1].toString();
        final recibo = int.parse(arrItem[2]);
        final monto = double.parse(arrItem[3]);
        final saldo = double.parse(arrItem[4]);

        AbonoEfectuado nuevo = AbonoEfectuado(
            noAbono: noAbono,
            fecha: fecha,
            recibo: recibo,
            monto: monto,
            saldo: saldo);
        _itemsAbonosEfectuados.add(nuevo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##,##0.00');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recibo de pago"),
      ),
      body:
          // agregar Expanded para alinear columnas a ver si funciona
          // igual debe ponerse despues de Column y antes de children
          SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            Text(
              "Recibo de Pago",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "Cuenta: ${widget.cobro.claveCuenta}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              cobro.nombreCliente,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "${cobro.calle} ${cobro.noExt} ${cobro.noInt}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              "${cobro.colonia} ${cobro.cp}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              cobro.delegacion,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Semanal:",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "${cobro.diaPagoA} - ${cobro.diaPagoA}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Fecha de Venta:",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  cobro.fechaVenta,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Fecha de Liquidación:",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  cobro.fechaTerminacionCredito,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Porcentaje pagado:",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  cobro.porcentajePagado,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "No. de abonos atrazados:",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  cobro.pagosAtrasados.toString(),
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Saldo atrasado:",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  formatter.format(cobro.saldoAtrasado),
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Pago mínimo:",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  formatter.format(cobro.montoAbonoAcordado),
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Importe de venta:",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  formatter.format(cobro.montoTotal),
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Text(
              cobro.productos,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Descuentos pronto pago",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Pagando antes de:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            (_itemsProntoPago.isNotEmpty)
                ? ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _itemsProntoPago.length,
                    itemBuilder: (context, item) {
                      return ProntoPagoWidget(
                          prontoPago: _itemsProntoPago[item]);
                    })
                : Text(
                    "No hay oferta de pronto pago",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Abonos efectuados:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            (_itemsAbonosEfectuados.isNotEmpty)
                ? ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _itemsAbonosEfectuados.length,
                    itemBuilder: (context, item) {
                      return AbonoEfectuadoWidget(
                          abonoEfectuado: _itemsAbonosEfectuados[item]);
                    })
                : Text(
                    "No hay pagos registrados",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
            Text(
              "Su pago:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "\$${cobro.montoCobradoEnVisita}",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
            ),
            const SizedBox(height: 30),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (_) => ImpresionScreen(cobro: cobro)));
            //   },
            //   icon: const Icon(Icons.print),
            //   label: const Text('Imprimir'),
            // ),
          ],
        ),
      ),
    );
  }
}
