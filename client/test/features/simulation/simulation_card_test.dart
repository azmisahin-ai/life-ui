// test/features/simulation/simulation_card_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/repository/simulation_repository.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/state/providers/simulation_data_provider.dart';

// Mock class for SimulationRepository
class MockSimulationRepository extends Mock implements SimulationRepository {}

class MockApiService extends Mock implements ApiService {}

void main() {
  group('SimulationCard widget test', () {
    late MockSimulationRepository mockRepository;

    setUp(() {
      mockRepository = MockSimulationRepository();
    });

    test('creation test', () async {});
    expect(
        mockRepository,
        SimulationRepository(
            apiService: MockApiService(),
            dataProvider: SimulationDataProvider()));
  });
}
