// repository/simulation_repository.dart
import 'package:flutter/foundation.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/state/providers/data_provider.dart';

class SimulationRepository {
  final ApiService apiService;
  final DataProvider dataProvider;

  SimulationRepository({required this.apiService, required this.dataProvider});

  Future<void> startSimulation() async {
    try {
      final Map<String, dynamic> apiResponse =
          await apiService.fetchData('simulation_start');
      final String simulationData = apiResponse['simulation_data'];
      dataProvider.data.addData(simulationData);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw SimulationException('Failed to start simulation. Error: $e');
    }
  }

  Future<void> pauseSimulation() async {
    final Map<String, dynamic> apiResponse =
        await apiService.fetchData('simulation_pause');
    final String simulationData = apiResponse['simulation_data'];
    dataProvider.data.addData(simulationData);
  }

  Future<void> continueSimulation() async {
    final Map<String, dynamic> apiResponse =
        await apiService.fetchData('simulation_continue');
    final String simulationData = apiResponse['simulation_data'];
    dataProvider.data.addData(simulationData);
  }

  Future<void> stopSimulation() async {
    final Map<String, dynamic> apiResponse =
        await apiService.fetchData('simulation_stop');
    final String simulationData = apiResponse['simulation_data'];
    dataProvider.data.addData(simulationData);
  }
}

class SimulationException implements Exception {
  final String message;

  SimulationException(this.message);

  @override
  String toString() => message;
}
