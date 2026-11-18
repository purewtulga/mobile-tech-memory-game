import 'package:flutter_test/flutter_test.dart';
import 'package:memory_game/main.dart';

void main() {
  testWidgets('нүүр дэлгэц гарна, түвшин сонгох руу орно', (tester) async {
    await tester.pumpWidget(const MemoryGameApp());

    expect(find.text('Memory Game'), findsOneWidget);

    await tester.tap(find.text('Тоглох'));
    await tester.pumpAndSettle();

    expect(find.text('Түвшин сонгох'), findsOneWidget);
    expect(find.text('Хялбар'), findsOneWidget);
  });
}
