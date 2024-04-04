// test/main_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ui/state/providers/theme_provider.dart';
import 'package:ui/app/app.dart';

void main() {
  testWidgets('App should start successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
        child: const App(),
      ),
    );

    expect(find.byType(App), findsOneWidget);
  });
}
