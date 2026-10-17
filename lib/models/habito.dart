import 'package:flutter/material.dart';

/// Modelo de datos de un hábito diario.
///
/// Al usar una clase propia (en lugar de Map<String, dynamic>) la colección
/// queda TIPADA: List<Habito>. El compilador sabe qué campos existe y de qué
/// tipo es cada uno, lo que evita errores de escritura y de tipos en tiempo
/// de ejecución.
class Habito {
  final String nombre;
  final String descripcion;
  final IconData icono;
  final Color color;
  final int meta; // veces que se desea cumplir el hábito en el día
  int contador; // ESTE es el dato que cambia -> necesita estado

  Habito({
    required this.nombre,
    required this.descripcion,
    required this.icono,
    required this.color,
    required this.meta,
    this.contador = 0,
  });

  /// true cuando el contador alcanzó o superó la meta diaria.
  bool get metaCumplida => contador >= meta;

  /// Valor entre 0.0 y 1.0 para la barra de progreso.
  double get progreso => meta == 0 ? 0.0 : (contador / meta).clamp(0.0, 1.0);
}
