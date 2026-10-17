import 'package:flutter_test/flutter_test.dart';

import 'package:control_habitos/main.dart';

void main() {
  testWidgets('Registrar incrementa y Reiniciar día deja todo en cero',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ControlHabitosApp());

    // Estado inicial: contadores en cero.
    expect(find.text('0 / 8'), findsOneWidget);
    expect(find.text('0 / 4'), findsOneWidget);
    expect(find.text('0 / 3'), findsOneWidget);

    // Registrar el primer hábito dos veces.
    await tester.tap(find.text('Registrar').first);
    await tester.pump();
    await tester.tap(find.text('Registrar').first);
    await tester.pump();
    expect(find.text('2 / 8'), findsOneWidget);

    // Reiniciar.
    await tester.tap(find.text('Reiniciar día'));
    await tester.pump();
    expect(find.text('0 / 8'), findsOneWidget);
    expect(find.text('2 / 8'), findsNothing);
  });
}
