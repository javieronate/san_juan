import 'dart:convert';
import 'package:flutter/material.dart';

class SincronizarScreen extends StatefulWidget {
  const SincronizarScreen({Key? key}) : super(key: key);

  @override
  State<SincronizarScreen> createState() => _SincronizarScreenState();
}

class _SincronizarScreenState extends State<SincronizarScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Text('Sincronizar'),
          // child: Image.network(
          //   locationImage,
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,
          // ),
        ),
      ],
    );
  }
}
