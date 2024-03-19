// test/features/simulation/cards/simulation_particle_card_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/features/simulation/cards/simulation_particle_card.dart';
import 'package:ui/repository/simulation_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Mock class for SimulationRepository
class MockSimulationRepository extends Mock implements SimulationRepository {}

void main() {
  group('SimulationParticleCard widget test', () {
    late MockSimulationRepository mockRepository;

    setUp(() {
      mockRepository = MockSimulationRepository();
    });

    testWidgets('Widget creation test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Localizations(
              locale: const Locale('en'),
              delegates: AppLocalizations.localizationsDelegates,
              child: SimulationParticleCard(
                title: 'Test Title',
                icon: Icons.star,
                simulationRepository: mockRepository,
              ),
            ),
          ),
        ),
      );

      // Verify if the widgets are correctly rendered
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });
}
