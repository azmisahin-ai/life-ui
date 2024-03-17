// test/repository/simulation_repository_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:ui/repository/simulation_repository.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/state/providers/data_provider.dart';

class MockApiService extends ApiService {
  MockApiService({required super.baseUrl});

  @override
  Future<Map<String, dynamic>> fetchData(String path) async {
    return {'simulation_data': 'Simulation started'};
  }

  @override
  Future<Map<String, dynamic>> postData(
      String path, Map<String, dynamic> body) async {
    return {'simulation_data': 'Simulation started'};
  }
}

void main() {
  test('SimulationRepository - startSimulation', () async {
    final mockApiService = MockApiService(baseUrl: 'https://example.com');
    final dataProvider = DataProvider();
    final simulationRepository = SimulationRepository(
        apiService: mockApiService, dataProvider: dataProvider);

    await simulationRepository.startSimulation(
      numberOfParticles: '10',
      timeStep: '0.1',
    );

    expect(dataProvider.data.source, ['Simulation started']);
  });
}
