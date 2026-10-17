import 'package:flutter/material.dart';

import '../models/habito.dart';
import '../widgets/encabezado_app.dart';
import '../widgets/tarjeta_habito.dart';

/// StatefulWidget: administra los contadores.
///
/// ¿Qué dato cambia? -> el campo `contador` de cada Habito.
/// ¿Por qué necesita estado? -> porque cambia mientras la app se usa y la
/// pantalla debe reflejarlo de inmediato. Un StatelessWidget no puede
/// reconstruirse por sí mismo; un State sí, llamando a setState().
class PantallaHabitos extends StatefulWidget {
  const PantallaHabitos({super.key});

  @override
  State<PantallaHabitos> createState() => _PantallaHabitosState();
}

class _PantallaHabitosState extends State<PantallaHabitos> {
  // Colección genérica/tipada: solo acepta objetos Habito.
  final List<Habito> _habitos = [
    Habito(
      nombre: 'Hidratación',
      descripcion: 'Vasos de agua tomados hoy',
      icono: Icons.water_drop,
      color: Colors.blue,
      meta: 8,
    ),
    Habito(
      nombre: 'Estudiar Flutter',
      descripcion: 'Bloques de estudio de 30 minutos',
      icono: Icons.menu_book,
      color: Colors.deepPurple,
      meta: 4,
    ),
    Habito(
      nombre: 'Actividad física',
      descripcion: 'Sesiones de ejercicio de 15 minutos',
      icono: Icons.directions_run,
      color: Colors.orange,
      meta: 3,
    ),
  ];

  /// Incrementa el contador de un hábito y reconstruye la interfaz.
  void _registrar(Habito habito) {
    setState(() {
      habito.contador++;
    });

    // Mensaje solo en el momento exacto en que se alcanza la meta.
    if (habito.contador == habito.meta) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Meta cumplida en "${habito.nombre}"!')),
      );
    }
  }

  /// Coloca todos los contadores en cero y reconstruye la interfaz.
  void _reiniciar() {
    setState(() {
      for (final habito in _habitos) {
        habito.contador = 0;
      }
    });
  }

  int get _totalRegistros =>
      _habitos.fold<int>(0, (suma, h) => suma + h.contador);

  int get _metasCumplidas => _habitos.where((h) => h.metaCumplida).length;

  /// build() describe la interfaz con el estado ACTUAL. Flutter lo vuelve a
  /// ejecutar cada vez que se llama a setState().
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de hábitos'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const EncabezadoApp(
            titulo: 'Control de hábitos',
            subtitulo: 'Registra tus avances de hoy',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Registros: $_totalRegistros  •  Metas cumplidas: '
                '$_metasCumplidas/${_habitos.length}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _habitos.length,
              itemBuilder: (context, indice) {
                final habito = _habitos[indice];
                return TarjetaHabito(
                  habito: habito,
                  onRegistrar: () => _registrar(habito),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _reiniciar,
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reiniciar día'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
