// test/main_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/app/app.dart';

void main() {
  testWidgets('App should start successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(App), findsOneWidget);
  });
}
