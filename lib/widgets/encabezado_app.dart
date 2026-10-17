import 'package:flutter/material.dart';

/// StatelessWidget: contenido que NO cambia por interacción del usuario.
/// Solo muestra un título, un subtítulo y la fecha. No tiene estado propio:
/// recibe todo por el constructor y su build() siempre dibuja lo mismo
/// para los mismos datos.
class EncabezadoApp extends StatelessWidget {
  final String titulo;
  final String subtitulo;

  const EncabezadoApp({
    super.key,
    required this.titulo,
    required this.subtitulo,
  });

  static const List<String> _dias = [
    'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'
  ];
  static const List<String> _meses = [
    'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio',
    'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
  ];

  String _fechaHoy() {
    final ahora = DateTime.now();
    final dia = _dias[ahora.weekday - 1];
    final mes = _meses[ahora.month - 1];
    return '$dia, ${ahora.day} de $mes de ${ahora.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.track_changes, size: 32),
              const SizedBox(width: 8),
              Text(
                titulo,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitulo, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            _fechaHoy(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[700],
                ),
          ),
        ],
      ),
    );
  }
}
