import 'package:flutter/material.dart';

import 'screens/pantalla_habitos.dart';

void main() {
  runApp(const ControlHabitosApp());
}

/// Widget raíz. No cambia, por eso es StatelessWidget.
class ControlHabitosApp extends StatelessWidget {
  const ControlHabitosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de hábitos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PantallaHabitos(),
    );
  }
}
