// test/features/dashboard/dashboard_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/features/dashboard/dashboard_card.dart';

void main() {
  testWidgets('DashboardCard widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DashboardCard(
            title: 'Test Title',
            icon: Icons.star,
          ),
        ),
      ),
    );

    expect(find.byType(DashboardCard), findsOneWidget);
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(
      tester
          .widget<InkWell>(
            find.descendant(
              of: find.byType(DashboardCard),
              matching: find.byType(InkWell),
            ),
          )
          .onTap,
      isNotNull,
    );

    await tester.tap(find.byType(DashboardCard));
    await tester.pump();
  });
}
