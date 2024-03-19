// repository/simulation_repository.dart

import 'package:flutter/foundation.dart';
import 'package:ui/features/simulation/simulation_result.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/state/providers/simulation_data_provider.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SimulationRepository {
  final ApiService apiService;
  final SimulationDataProvider dataProvider;
  final StreamController<SimulationResult> _resultStreamController =
      StreamController<SimulationResult>.broadcast();

  SimulationRepository({required this.apiService, required this.dataProvider});

  Stream<SimulationResult> get resultStream => _resultStreamController.stream;

  Future<SimulationResult> startSimulation({
    required int? numberOfParticles,
    required double? timeStep,
  }) async {
    try {
      IO.Socket socket = IO.io(apiService.baseUrl);
      socket.onConnect((_) {
        if (kDebugMode) {
          print('socket connect');
        }
        socket.emit('get', '/api/v1/simulation_status');
      });
      socket.on(
          '/api/v1/simulation_status',
          (data) =>
              {_resultStreamController.add(_processSimulationResult(data))});
      socket.onDisconnect((_) {
        if (kDebugMode) {
          print('socket disconnect');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

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
        return simulationResult;
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
    final int numberOfParticlesResponse =
        apiResponse['number_of_particles'] as int;
    final double timeStepResponse = apiResponse['time_step'] as double;

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
      numberOfParticles: numberOfParticlesResponse,
      timeStep: timeStepResponse,
      particle: particle,
    );

    return simulationResult;
  }

  Future<SimulationResult> pauseSimulation() async {
    final SimulationResult simulationResult =
        await _fetchAndAddData('simulation_pause');
    return simulationResult;
  }

  Future<SimulationResult> continueSimulation() async {
    final SimulationResult simulationResult =
        await _fetchAndAddData('simulation_continue');
    return simulationResult;
  }

  Future<SimulationResult> stopSimulation() async {
    final SimulationResult simulationResult =
        await _fetchAndAddData('simulation_stop');
    return simulationResult;
  }

  Future<SimulationResult> _fetchAndAddData(String path) async {
    final Map<String, dynamic> apiResponse = await apiService.fetchData(path);
    final SimulationResult simulationResult =
        _processSimulationResult(apiResponse);
    dataProvider.setSimulationResult(simulationResult); // Yeni veriyi güncelle
    _resultStreamController.add(simulationResult); // Akışı güncelle
    return simulationResult;
  }

  void dispose() {
    _resultStreamController.close();
  }

  Future<SimulationResult>? getSimulationStatus() async {
    final SimulationResult simulationResult =
        await _fetchAndAddData('simulation_status');
    return simulationResult;
  }
}

class SimulationException implements Exception {
  final String message;

  SimulationException(this.message);

  @override
  String toString() => message;
}
