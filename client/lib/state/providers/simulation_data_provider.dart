// state/providers/simulation_data_provider.dart
import 'package:flutter/material.dart';
import 'package:ui/features/simulation/simulation_result.dart'; // SimulationResult sınıfının tanımlandığı dosya

class SimulationDataProvider with ChangeNotifier {
  SimulationResult? _simulationResult;

  SimulationResult? get simulationResult => _simulationResult;

  void setSimulationResult(SimulationResult result) {
    _simulationResult = result;
    notifyListeners();
  }
}
