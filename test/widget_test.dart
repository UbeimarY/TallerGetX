import 'package:flutter_test/flutter_test.dart';
import 'package:global_status/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Cursos Disponibles'), findsOneWidget);
  });
}
