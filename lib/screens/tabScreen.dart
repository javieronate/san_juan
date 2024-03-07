import 'package:flutter/material.dart';
import 'package:san_juan/screens/loginScreen.dart';
import 'package:san_juan/screens/cobrosScreen.dart';
import 'package:san_juan/screens/buscarScreen.dart';
import 'package:san_juan/screens/reporteScreen.dart';
import 'package:san_juan/screens/recibos2Screen.dart';
import 'package:san_juan/screens/sincronizarScreen.dart';
import 'package:san_juan/repositories/dataService.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _indexPaginaSeleccionada = 0;
  var _tituloPaginaSeleccionada = "Home";
  //var _isGetingLocation = false;
  final DataService _dataService = DataService();

  void _logOut() {
    _dataService.deleteItem("token");
    _dataService.deleteItem("idPersona");
    // _dataService.deleteItem("nombreUsuario");
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  void initState() {
    super.initState();
  }

  //void _seleccionarCategorias(String identificador) {}

  void _seleccionarPagina(int index) {
    setState(() {
      _indexPaginaSeleccionada = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget paginaActiva = const CobrosScreen();
    if (_indexPaginaSeleccionada == 0) {
      paginaActiva = const CobrosScreen();
      setState(() {
        _tituloPaginaSeleccionada = "Cobros";
      });
    } else if (_indexPaginaSeleccionada == 1) {
      paginaActiva = const BuscarScreen();
      setState(() {
        _tituloPaginaSeleccionada = "Buscar";
      });
    } else if (_indexPaginaSeleccionada == 2) {
      paginaActiva = const ReporteScreen();
      setState(() {
        _tituloPaginaSeleccionada = "Reporte";
      });
    } else if (_indexPaginaSeleccionada == 3) {
      paginaActiva = const Recibos2Screen();
      setState(() {
        _tituloPaginaSeleccionada = "Recibos";
      });
    } else if (_indexPaginaSeleccionada == 4) {
      paginaActiva = const SincronizarScreen();
      setState(() {
        _tituloPaginaSeleccionada = "Sincronizar";
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloPaginaSeleccionada),
        actions: [
          IconButton(onPressed: _logOut, icon: const Icon(Icons.logout))
        ],
      ),
      // drawer: CategoriasDrawer(alSeleccionarCategoria: _seleccionarCategorias),
      body: paginaActiva,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black87,
        onTap: _seleccionarPagina,
        currentIndex: _indexPaginaSeleccionada,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: 'Cobros',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Reporte',
            backgroundColor: Colors.black87,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.receipt),
          //   label: 'Recibos',
          //   backgroundColor: Colors.black87,
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.sync),
          //   label: 'Sincronizar',
          //   backgroundColor: Colors.black87,
          // ),
        ],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white54,
        showUnselectedLabels: true,
      ),
    );
  }
}
