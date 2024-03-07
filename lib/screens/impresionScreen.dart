import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cobro.dart';

class ImpresionScreen extends StatefulWidget {
  const ImpresionScreen({Key? key, required this.cobro}) : super(key: key);
  final Cobro cobro;
  @override
  State<ImpresionScreen> createState() => _ImpresionScreenState();
}

class _ImpresionScreenState extends State<ImpresionScreen> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _devicesMsg = "";
  final f = NumberFormat("\$###,###.00", "en-US");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPrinter();
    });
  }

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));
    if (!mounted) return;
    bluetoothPrint.scanResults.listen((val) {
      if (!mounted) return;
      setState(() {
        _devices = val;
      });
      if (_devices.isEmpty) {
        setState(() {
          _devicesMsg = "No se encontro ninguna impresora";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccione una impresora"),
        backgroundColor: Colors.redAccent,
      ),
      body: _devices.isEmpty
          ? Center(child: Text(_devicesMsg ?? ''))
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (c, i) {
                return ListTile(
                    leading: Icon(Icons.print),
                    title: Text(_devices[i].name.toString()),
                    subtitle: Text(_devices[i].address.toString()),
                    onTap: () {
                      _iniciarImpresion(_devices[i]);
                    });
              }),
    );
  }

  Future<void> _iniciarImpresion(BluetoothDevice device) async {
    if (device != null && device.address != null) {
      await bluetoothPrint.connect(device);
      Map<String, dynamic> config = Map();
      List<LineText> list = [];
      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "Recibo de pago",
          weight: 2,
          width: 2,
          height: 2,
          align: LineText.ALIGN_CENTER,
          linefeed: 1,
        ),
      );
      // nombre cliente
      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: widget.cobro.nombreCliente,
          weight: 0,
          align: LineText.ALIGN_LEFT,
          linefeed: 1,
        ),
      );
      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: widget.cobro.productos,
          weight: 0,
          align: LineText.ALIGN_LEFT,
          linefeed: 1,
        ),
      );
    }
  }
}
