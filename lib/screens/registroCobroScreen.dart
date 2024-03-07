import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:san_juan/models/cobro.dart';
import 'package:san_juan/screens/recibosScreen.dart';
import '../repositories/cobrosRepository.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class RegistroCobroScreen extends StatefulWidget {
  const RegistroCobroScreen({Key? key, required this.cobro}) : super(key: key);

  final Cobro cobro;

  @override
  State<RegistroCobroScreen> createState() => _RegistroCobroScreenState();
}

class _RegistroCobroScreenState extends State<RegistroCobroScreen> {
  late Cobro cobro;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cobro = widget.cobro;
  }

  final _pagoController = TextEditingController();
  final _notaController = TextEditingController();
  DateTime? _selectedDate;

  void _visitado() {
    const pago = 0.0;
    grabarPago(pago, 0);
  }

  void _pagado() {
    final pago = double.parse(_pagoController.text);
    setState(() {
      cobro.cobrado = 1;
    });
    grabarPago(pago, 1);
  }

  void grabarPago(pago, pagado) {
    final pagoIndicado = pago;
    final notaIndicada = _notaController.text;
    //final idCuenta = cobro.idCuenta;
    final siguienteDia = _selectedDate!.day;
    final siguienteMes = _selectedDate!.month;
    final siguienteAno = _selectedDate!.year;
    final nuevaFecha = "$siguienteAno-$siguienteMes-$siguienteDia";

    setState(() {
      cobro.montoCobradoEnVisita = pagoIndicado;
      cobro.fechaSiguientePago = nuevaFecha;
      cobro.nota = notaIndicada;
      cobro.visitado = 1;
    });

    // todo: validar datos correctos
    final repositorio = new CobrosRepository();
    final grabado = repositorio.apuntarCobro(cobro);
    // navegacion anterior regresar a pagina anterior

    if (pagado == 1) {
      // ir a pagina de recibo
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => RecibosScreen(
            cobro: widget.cobro,
          ),
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(now.year, now.month + 1, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate,
        helpText: 'Seleccione la fecha del siguiente pago',
        cancelText: 'Cancelar',
        confirmText: 'Seleccionar',
        fieldLabelText: 'Escriba la fecha',
        fieldHintText: 'dia/mes/año',
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark(),
            child: child!,
          );
        });
    print(pickedDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final alto = MediaQuery.of(context).size.height;
    final ancho = MediaQuery.of(context).size.width;
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de pago"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            Text(
              cobro.nombreCliente,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "${cobro.calle} ${cobro.noExt} ${cobro.noInt}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "${cobro.colonia} ${cobro.cp}",
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
              "Cuenta: ${widget.cobro.claveCuenta}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "Saldo: ${widget.cobro.saldo}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "\$${cobro.montoAbonoAcordado}",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pagoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\$ ',
                      label: Text('Monto pagado'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'Siguiente pago'
                            : formatter.format(_selectedDate!),
                      ),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextField(
              decoration: const InputDecoration(labelText: 'Nota'),
              controller: _notaController,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _pagado,
              icon: const Icon(Icons.thumb_up),
              label: const Text('Registrar pago'),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _visitado,
              icon: const Icon(Icons.warning),
              label: const Text('Visitado sin pago'),
            ),
          ],
        ),
      ),
    );
  }
}
