// repository/simulation_repository.dart

import 'package:flutter/foundation.dart';
import 'package:ui/features/simulation/simulation_result.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/state/providers/simulation_data_provider.dart';
import 'dart:async';

class SimulationRepository {
  final ApiService apiService;
  final SimulationDataProvider dataProvider;
  final StreamController<SimulationResult> _resultStreamController =
      StreamController<SimulationResult>.broadcast();

  SimulationRepository({required this.apiService, required this.dataProvider});

  Stream<SimulationResult> get resultStream => _resultStreamController.stream;

  Future<void> startSimulation({
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

      final String? status = apiResponse['status'];
      if (status != null && status == 'started') {
        final SimulationResult simulationResult =
            _processSimulationResult(apiResponse);
        dataProvider
            .setSimulationResult(simulationResult); // Yeni veriyi güncelle
        _resultStreamController.add(simulationResult); // Akışı güncelle
      } else {
        throw SimulationException('Failed to start simulation: Invalid status');
      }
    } catch (e) {
      final errorMessage = 'Failed to start simulation. Error: $e';
      if (kDebugMode) {
        print(errorMessage);
      }
      throw SimulationException(errorMessage);
    }
  }

  SimulationResult _processSimulationResult(Map<String, dynamic> apiResponse) {
    final String numberOfParticlesResponse =
        apiResponse['number_of_particles'] ?? '';
    final String timeStepResponse = apiResponse['time_step'] ?? '';

    // Particle nesnesini oluşturmadan önce kontrol ediyoruz
    Particle? particle;
    if (apiResponse.containsKey('particle')) {
      particle = Particle.fromJson(apiResponse['particle']);
    }

    if (kDebugMode) {
      print(
          'Simulation started with $numberOfParticlesResponse particles and $timeStepResponse time step');
    }

    // status alanının null olup olmadığını kontrol ediyoruz
    final String status = apiResponse['status'] ?? 'unknown';

    final SimulationResult simulationResult = SimulationResult(
      status: status,
      numberOfParticles: int.tryParse(numberOfParticlesResponse) ??
          0, // Dönüşüm hatası durumunda 0 olarak ayarlanıyor
      timeStep: double.tryParse(timeStepResponse) ??
          0.0, // Dönüşüm hatası durumunda 0.0 olarak ayarlanıyor
      particle: particle,
    );

    return simulationResult;
  }

  Future<void> pauseSimulation() async {
    await _fetchAndAddData('simulation_pause');
  }

  Future<void> continueSimulation() async {
    await _fetchAndAddData('simulation_continue');
  }

  Future<void> stopSimulation() async {
    await _fetchAndAddData('simulation_stop');
  }

  Future<void> _fetchAndAddData(String path) async {
  }

  void dispose() {
    _resultStreamController.close();
  }
}

class SimulationException implements Exception {
  final String message;

  SimulationException(this.message);

  @override
  String toString() => message;
}
