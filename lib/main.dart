import 'package:flutter/material.dart';
import 'package:san_juan/screens/loginScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontFamily: "Verdana",
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
            titleMedium: TextStyle(
              fontFamily: "Verdana",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
            titleSmall: TextStyle(
              fontFamily: "Verdana",
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.black54,
            ),
            bodyLarge: TextStyle(
              fontFamily: "Verdana",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
            bodyMedium: TextStyle(
              fontFamily: "Verdana",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
            bodySmall: TextStyle(
              fontFamily: "Verdana",
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
            labelMedium: TextStyle(
              fontFamily: "Verdana",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
            displayLarge: TextStyle(
              fontFamily: "Verdana",
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            )),
      ),
      home: const LoginScreen(),
    );
  }
}
