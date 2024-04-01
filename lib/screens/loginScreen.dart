import 'package:flutter/material.dart';
import 'package:san_juan/screens/tabScreen.dart';
import 'package:san_juan/models/loginData.dart';
import 'package:san_juan/services/logServices.dart';
import 'package:san_juan/repositories/dataService.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _usuarioAnotado;
  String? _claveAnotada;
  LoginData? _datosUsuario;
  bool hidePassword = true;
  final DataService _dataService = DataService();
  bool _logueado = false;

  void _validarLogin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final usuario = _usuarioAnotado.toString();
    final password = _claveAnotada.toString();

    // final usuario = "carlos";
    // final password = "15Pericos";

    var respuestaLogin = await LogServices().login(usuario, password);
    if (respuestaLogin != null) {
      setState(() {
        _datosUsuario = respuestaLogin;
        _logueado = true;
      });
      await _dataService.addItem("token", _datosUsuario!.token);
      await _dataService.addItem(
          "idPersona", _datosUsuario!.idPersona.toString());
      _definirPantalla();
    } else {
      ponerAlerta();
    }
  }

  void ponerAlerta() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: const Text(
            'Los datos indicados no son válidos. Por favor vuelva a intentarlo'),
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

  void _definirPantalla() {
    if (_logueado) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const TabScreen()));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Usuario Invalido'),
          content: const Text(
              'Verifique su usuario y clave con el administrador y vuenva a intentar.'),
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
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final alto = h * 1;
    final ancho = w * 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        height: alto,
        width: ancho,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 125, 125, 125),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Image.asset(
                'assets/images/LSJ.png',
                height: 80,
              ),
              const SizedBox(
                height: 25,
              ),
              Opacity(
                opacity: 0.7,
                child: Card(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Login",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              fontFamily: "Verdana",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _usuarioAnotado = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Nombre de usuario",
                              hintStyle: const TextStyle(
                                fontFamily: "Verdana",
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                color: Colors.grey,
                              ),
                              disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 0.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: hidePassword,
                            style: const TextStyle(
                              fontFamily: "Verdana",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _claveAnotada = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Clave",
                              hintStyle: const TextStyle(
                                fontFamily: "Verdana",
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                color: Colors.grey,
                              ),
                              disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.password,
                                color: Colors.black54,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: Colors.black54,
                                icon: Icon(hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 100, // <-- Your width
                          height: 30, // <-- Your height
                          child: ElevatedButton(
                            onPressed: () {
                              _validarLogin();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            child: const Text(
                              "Login",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
