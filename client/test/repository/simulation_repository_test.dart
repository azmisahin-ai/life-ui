// test/repository/simulation_repository_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:ui/repository/simulation_repository.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/state/providers/simulation_data_provider.dart';

class MockApiService extends ApiService {
  MockApiService({required this.baseUrl}) : super(baseUrl: '');

  @override
  // ignore: overridden_fields
  final String baseUrl;

  @override
  Future<Map<String, dynamic>> fetchData(String path) async {
    return {'simulation_data': 'Simulation started'};
  }

  @override
  Future<Map<String, dynamic>> postData(
      String path, Map<String, dynamic> body) async {
    if (path == 'simulation_start') {
      return {
        'status': 'started',
        'number_of_particles': '10', // Mock number_of_particles
        'time_step': '0.1', // Mock time_step
        'particle': {
          // Mock Particle object
          'name': 'Mock Particle'
        }
      };
    } else {
      return {'simulation_data': 'Simulation started'};
    }
  }
}

void main() {
  test('SimulationRepository - startSimulation', () async {
    final mockApiService = MockApiService(baseUrl: 'https://example.com');
    final dataProvider = SimulationDataProvider();
    final simulationRepository = SimulationRepository(
        apiService: mockApiService, dataProvider: dataProvider);

    expect(simulationRepository.dataProvider, dataProvider);
  });
}
