// import 'package:flutter/cupertino.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:san_juan/models/cobro.dart';
import 'package:san_juan/models/orden.dart';
// import 'package:san_juan/models/estatus.dart';
import 'package:san_juan/screens/detalleCobroScreen.dart';
import 'package:san_juan/repositories/cobrosRepository.dart';
import 'package:san_juan/services/cobrosServices.dart';
import 'package:san_juan/widgets/cobroWidget.dart';

import '../repositories/dataService.dart';
// import 'package:san_juan/repositories/dataService.dart';

class CobrosScreen extends StatefulWidget {
  const CobrosScreen({Key? key}) : super(key: key);
  @override
  State<CobrosScreen> createState() => _CobrosScreenState();
}

class _CobrosScreenState extends State<CobrosScreen> {
  final DataService _dataService = DataService();
  List<Cobro>? _listaCobros;
  List<Cobro>? _listaCobrosLocal;
  var _cargandoDatos = false;
  final Dio dio = Dio();
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _getCobrosDeLocal();
  }

  void _getCobrosDeLocal() async {
    final idCobradorLogueado = await _dataService.getItem("idPersona");
    final repositorio = CobrosRepository();
    _listaCobrosLocal = await repositorio.leerCobros();
    if (_listaCobrosLocal != null) {
      setState(() {
        _cargandoDatos = false;
      });
      if (_listaCobrosLocal![0].idCobrador != int.parse(idCobradorLogueado!)) {
        ponerAlertaCobradores();
      }
    }
  }

  void _reordenarBaseLocal(listaNuevoOrden) async {
    final repositorio = CobrosRepository();

    for (final renglon in listaNuevoOrden) {
      final resultado = await repositorio.reordenar(renglon);
      print(resultado);
    }

    // if (resultado) {
    _listaCobrosLocal = await repositorio.leerCobros();
    // }
  }

  void ponerAlerta() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Alerta'),
        content: const Text(
            'Tiene registros por transferir al servidor. Primero transfieralos antes de recargar del servidor.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Regresar'),
          ),
        ],
      ),
    );
  }

  void ponerAlertaCobradores() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Alerta'),
        content: const Text(
            'Los registros almacenados en este celular corresponden a otro cobrador. Por favor verifique que todos los cobros efetuados sean subidos al servidor y obtenga su la lista de cobros.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Regresar'),
          ),
        ],
      ),
    );
  }

  Future<int> _getCobros() async {
    // validar si hay registros por transferir

    setState(() {
      _cargandoDatos = true;
    });
    final listaPorTransferir = await CobrosRepository().leerPagos();
    if (listaPorTransferir.isNotEmpty) {
      ponerAlerta();
    } else {
      _listaCobros = await CobrosServices().getCobros();
      final repositorio = CobrosRepository();
      if (_listaCobros != null) {
        final terminado = repositorio.ponerCobros(_listaCobros!);
        _listaCobrosLocal = await repositorio.leerCobros();

        // bajar fotos
        setState(() {});
        // print('bajado de fotos');
        if (await terminado) {
          String rutaCompleta =
              "https://www.dedalo.com.mx/sanJuan/storage/app/public/tmp/sinImagenIne.png";
          // print("sinIne");
          await saveFile(rutaCompleta, "sinImagenIne.png");
          rutaCompleta =
              "https://www.dedalo.com.mx/sanJuan/storage/app/public/tmp/sinFotoCasa.png";
          // print("sinFachada");
          await saveFile(rutaCompleta, "sinFotoCasa.png");
          if (_listaCobrosLocal!.isNotEmpty) {
            for (final cobro in _listaCobrosLocal!) {
              if (cobro.fotoFachada.isNotEmpty) {
                final rutaCompleta =
                    "https://www.dedalo.com.mx/sanJuan/storage/app/public/tmp/${cobro.fotoFachada}";
                // print(cobro.fotoFachada);
                await saveFile(rutaCompleta, cobro.fotoFachada);
              }
              if (cobro.fotoIdentificacion.isNotEmpty) {
                final rutaCompleta =
                    "https://www.dedalo.com.mx/sanJuan/storage/app/public/tmp/${cobro.fotoIdentificacion}";
                // print(cobro.fotoIdentificacion);
                await saveFile(rutaCompleta, cobro.fotoIdentificacion);
              }
            }
          }
          // print('fin de bajado de fotos');
          //final actualizado = repositorio.ponerCargado();
          setState(() {
            _cargandoDatos = false;
          });
          return 1;
        }
      }
    }
    return 0;
  }

  //funciones para bajar imagenes
  Future<bool> saveFile(String url, String fileName) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          /*String newPath = "";
          List<String> folders = directory!.path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/sanJuan";
          directory = Directory(newPath);
          print(directory.path);*/
          // /storage/emulated/0/Android/data/mx.com.dedalo.san_juan/files
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      /*if (!await directory!.exists()) {
        await directory.create(recursive: true);
      }*/

      if (await directory!.exists()) {
        File saveFile = File("${directory.path}/$fileName");
        await dio.download(url, saveFile.path,
            onReceiveProgress: (downloaded, totalSize) {
          setState(() {
            progress = downloaded / totalSize;
          });
        });
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  // _getImagenes() async {
  //   setState(() {
  //     _cargandoDatos = true;
  //   });
  //   //A-14221_FOTO_INE_CLIENTE.jpg
  //   // https://www.dedalo.com.mx/sanJuan/storage/app/public/tmp/A-14221_FOTO_INE_CLIENTE.jpg
  //   bool downloaded = await saveFile(
  //       "https://www.dedalo.com.mx/sanJuan/storage/app/public/tmp/A-14221_FOTO_INE_CLIENTE.jpg",
  //       "ensayo.jpg");
  //
  //   setState(() {
  //     _cargandoDatos = false;
  //   });
  // }
  //fin funciones para bajar imagenes

  void _seleccionarCobro(BuildContext context, Cobro cobro) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (ctx) => DetalleCobroScreen(
          cobro: cobro,
        ),
      ),
    )
        .then((_) {
      _getCobrosDeLocal();
    });
  }

  void reordenar(int viejoIndex, int nuevoIndex) {
    // copiar arreglo como esta ahorita
    List<Cobro>? listaInicial = [..._listaCobrosLocal!];

    // cambiar orden
    setState(() {
      if (viejoIndex < nuevoIndex) {
        nuevoIndex--;
      }
      final item = _listaCobrosLocal!.removeAt(viejoIndex);
      _listaCobrosLocal!.insert(nuevoIndex, item);
    });

    // hacer lista con noCta, ordenInicial y ordenFinal
    List<Orden> listaNuevoOrden = [];
    for (var index = 0; index < _listaCobrosLocal!.length; index++) {
      if (_listaCobrosLocal![index].orden != listaInicial[index].orden) {
        listaNuevoOrden.add(Orden(
            idCuenta: _listaCobrosLocal![index].idCuenta,
            ordenInicial: _listaCobrosLocal![index].orden,
            ordenFinal: listaInicial![index].orden,
            cliente: _listaCobrosLocal![index].nombreCliente));
      }
      // print(index);
      // print(listaInicial[index].orden);
      // print(_listaCobrosLocal![index].orden);
      // print('');
    }
    _reordenarBaseLocal(listaNuevoOrden);

    print('fin');
  }

  //
  // for (var cobro in _listaCobrosLocal!) {
  //   print(cobro.orden);
  //   // Orden item = new Orden(idCuenta: cobro.idCuenta,_cobro.idCuenta);
  //   // listaNuevoOrden.add(item);
  // }
  @override
  Widget build(BuildContext context) {
    return _cargandoDatos
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: ElevatedButton.icon(
                  onPressed: _getCobros,
                  icon: const Icon(Icons.cloud_download),
                  label: const Text('Recargar cobros'),
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              //   child: ElevatedButton.icon(
              //     onPressed: _getImagenes,
              //     icon: const Icon(Icons.cloud_download),
              //     label: const Text('Cargar imágenes'),
              //   ),
              // ),
              Expanded(
                child: _listaCobrosLocal == null
                    ? const Center(
                        child: Text("No se encontraron cobros por hacer"),
                      )
                    : ReorderableListView(
                        children: [
                            for (final cobro in _listaCobrosLocal!)
                              CobroWidget(
                                  key: ValueKey(cobro),
                                  cobro: cobro,
                                  onSeleccionarCobro: (cobro) {
                                    _seleccionarCobro(context, cobro);
                                  }),
                          ],
                        onReorder: (viejoIndex, nuevoIndex) =>
                            reordenar(viejoIndex, nuevoIndex)),

                // ListView.builder(
                //         itemCount: _listaCobrosLocal!.length,
                //         itemBuilder: (ctx, index) => CobroWidget(
                //           cobro: _listaCobrosLocal![index],
                //           onSeleccionarCobro: (cobro) {
                //             _seleccionarCobro(context, cobro);
                //           },
                //         ),
                //       ),
              ),
            ],
          );
  }
}
