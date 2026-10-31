import 'package:flutter/material.dart';
import 'presentation/juego_screen.dart';

// Aquí arranca la app y abre la pantalla del juego
void main() => runApp(const Nieves2048App());

class Nieves2048App extends StatelessWidget {
  const Nieves2048App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // quita la cinta roja de DEBUG
      title: 'Nieves 2048',
      theme: ThemeData(primarySwatch: Colors.pink, useMaterial3: true),
      home: const JuegoScreen(),
    );
  }
}