import 'package:flutter/material.dart';

import '../models/habito.dart';

/// StatelessWidget: dibuja UN hábito dentro de un Card.
/// No guarda el contador: lo recibe del padre (PantallaHabitos) y avisa
/// mediante el callback [onRegistrar] cuando se presiona el botón.
///
/// Árbol de widgets (padre -> hijo):
/// Card
///  └─ Padding
///      └─ Column
///          ├─ Row
///          │   ├─ CircleAvatar -> Icon
///          │   ├─ Expanded -> Column [Text nombre, Text descripción]
///          │   └─ Text contador "n / meta"
///          ├─ LinearProgressIndicator   (reto opcional)
///          └─ Align -> ElevatedButton.icon
class TarjetaHabito extends StatelessWidget {
  final Habito habito;
  final VoidCallback onRegistrar;

  const TarjetaHabito({
    super.key,
    required this.habito,
    required this.onRegistrar,
  });

  @override
  Widget build(BuildContext context) {
    final cumplida = habito.metaCumplida;

    return Card(
      elevation: cumplida ? 4 : 2,
      // Reto opcional: cambia el estilo visual al alcanzar la meta diaria.
      color: cumplida ? Colors.green.shade50 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: cumplida ? Colors.green : Colors.transparent,
          width: 2,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: habito.color,
                  child: Icon(habito.icono, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habito.nombre,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        habito.descripcion,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${habito.contador} / ${habito.meta}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cumplida ? Colors.green.shade700 : null,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: habito.progreso,
                minHeight: 8,
                color: cumplida ? Colors.green : habito.color,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: onRegistrar,
                icon: Icon(cumplida ? Icons.emoji_events : Icons.add),
                label: const Text('Registrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
