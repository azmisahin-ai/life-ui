// repository/simulation_repository.dart
import 'package:flutter/foundation.dart';
import 'package:ui/features/simulation/simulation_result.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/state/providers/data_provider.dart';

class SimulationRepository {
  final ApiService apiService;
  final DataProvider dataProvider;

  SimulationRepository({required this.apiService, required this.dataProvider});

  Future<SimulationResult> startSimulation({
    required String numberOfParticles,
    required String timeStep,
  }) async {
    try {
      final Map<String, dynamic> requestData = {
        'number_of_particles': numberOfParticles,
        'time_step': timeStep,
      };

      final Map<String, dynamic> apiResponse = await apiService.postData(
        'simulation_start',
        requestData,
      );

      final String status = apiResponse['status'];
      final String numberOfParticlesResponse =
          apiResponse['number_of_particles'];
      final String timeStepResponse = apiResponse['time_step'];

      if (status == 'started') {
        print(
            'Simulation started with $numberOfParticlesResponse particles and $timeStepResponse time step');

        final Particle particle = Particle.fromJson(apiResponse['particle']);
        final simulationResult = SimulationResult(
          status: status,
          numberOfParticles: int.parse(numberOfParticlesResponse),
          timeStep: double.parse(timeStepResponse),
          particle: particle,
        );
        return simulationResult;
      } else {
        throw SimulationException('Failed to start simulation');
      }
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
