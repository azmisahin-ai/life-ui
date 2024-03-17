// test/features/simulation/simulation_result_card_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/features/simulation/simulation_result_card.dart';

void main() {
  group('SimulationResultCard widget test', () {
    testWidgets('Widget creation test', (WidgetTester tester) async {
      // Build our widget and trigger a frame.
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SimulationResultCard(
              title: 'Test Title',
              icon: Icons.star,
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });
}
