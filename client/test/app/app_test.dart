// test/app/app_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/app/app.dart';
import 'package:ui/screen/main_screen.dart';

void main() {
  testWidgets('App widget should build', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(App), findsOneWidget);
    expect(find.byType(MainScreen), findsOneWidget);
  });
}
