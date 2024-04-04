// features/simulation/cards/simulation_particle_card.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/features/simulation/simulation_result.dart';
import 'package:ui/repository/simulation_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SimulationParticleCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final SimulationRepository simulationRepository;

  const SimulationParticleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.simulationRepository,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SimulationParticleCardState createState() => _SimulationParticleCardState();
}

class _SimulationParticleCardState extends State<SimulationParticleCard> {
  bool _isStarted = false;
  bool _isPaused = false;

  final TextEditingController _numberOfParticlesController =
      TextEditingController();
  final TextEditingController _timeStepController = TextEditingController();

  Future<SimulationResult>? _simulationResult;

  Future<void> _start() async {
    if (_validateFields()) {
      final int? numberOfParticles =
          int.tryParse(_numberOfParticlesController.text);
      final double? timeStep = double.tryParse(_timeStepController.text);

      try {
        _simulationResult = widget.simulationRepository.startSimulation(
          numberOfParticles: numberOfParticles,
          timeStep: timeStep,
        );

        _simulationResult?.then((value) {
          if (value.status == "started") {
            setState(() {
              _isStarted = true;
              _isPaused = false;
            });
          }
        }).catchError((error) {
          if (kDebugMode) {
            print('Error in starting simulation: $error');
          }
          _showErrorSnackbar(
              context, 'Failed to start simulation. Error: $error');
        });
      } catch (e) {
        if (kDebugMode) {
          _showErrorSnackbar(context, '$e');
        } else {
          _showErrorSnackbar(
            context,
            AppLocalizations.of(context)!.simulation_particle_start_failed,
          );
        }
      }
    }
  }

  bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  bool isFloat(String str) {
    return double.tryParse(str) != null;
  }

  Future<void> _pause() async {
    try {
      _simulationResult = widget.simulationRepository.pauseSimulation();

      _simulationResult?.then((value) {
        if (value.status == "paused") {
          setState(() {
            _isPaused = !_isPaused;
          });
        }
      });
    } catch (e) {
      if (kDebugMode) {
        // ignore: use_build_context_synchronously
        _showErrorSnackbar(context, '$e');
      } else {
        _showErrorSnackbar(
          // ignore: use_build_context_synchronously
          context,
          // ignore: use_build_context_synchronously
          AppLocalizations.of(context)!.simulation_particle_pause_failed,
        );
      }
    }
  }

  Future<void> _stop() async {
    if (_isStarted) {
      try {
        _simulationResult = widget.simulationRepository.stopSimulation();

        _simulationResult?.then((value) {
          if (value.status == "stopped") {
            setState(() {
              _isStarted = false;
              _isPaused = false;
            });
            // Text alanlarının kilidini aç
            _numberOfParticlesController.clear();
            _timeStepController.clear();
          }
        });
      } catch (e) {
        if (kDebugMode) {
          _showErrorSnackbar(context, '$e');
        } else {
          _showErrorSnackbar(
            context,
            AppLocalizations.of(context)!.simulation_particle_stop_failed,
          );
        }
      }
    }
  }

  bool _validateFields() {
    if (_numberOfParticlesController.text.isEmpty ||
        _timeStepController.text.isEmpty) {
      _showErrorSnackbar(context, 'Fields cannot be empty');
      return false;
    } else if (!isNumeric(_numberOfParticlesController.text) ||
        !isFloat(_timeStepController.text)) {
      _showErrorSnackbar(context, 'Invalid input format');
      return false;
    }
    return true;
  }

  Future<void> _getStatus() async {
    try {
      _simulationResult = widget.simulationRepository.getSimulationStatus();

      _simulationResult?.then((value) {
        if (value.status == "continues") {
          setState(() {
            _isStarted = true;
            _isPaused = false;
          });

          _timeStepController.value =
              TextEditingValue(text: value.timeStep.toString());
          _numberOfParticlesController.value =
              TextEditingValue(text: value.numberOfParticles.toString());
        }

        if (value.status == "stopped") {
          setState(() {
            _isStarted = false;
            _isPaused = false;
          });
        }

        if (value.status == "paused") {
          setState(() {
            _isPaused = !_isPaused;
          });
        }

        if (value.status == "started") {
          setState(() {
            _isStarted = true;
            _isPaused = false;
          });
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get simulation status: $e');
      }
    }
  }

  void _showErrorSnackbar(BuildContext context, String errorMessage) {
    final snackBar = SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(widget.icon),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _numberOfParticlesController,
              decoration: InputDecoration(
                labelText:
                    localizations.simulation_particle_number_Of_particles_label,
                hintText: '###',
                prefixIcon: const Icon(Icons.scatter_plot),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _timeStepController,
              decoration: InputDecoration(
                labelText: localizations.simulation_particle_time_step_label,
                hintText: '#.##',
                prefixIcon: const Icon(Icons.timelapse),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isStarted ? (_isPaused ? _start : _pause) : _start,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                _isPaused
                    ? localizations.simulation_particle_continue_button
                    : (_isStarted
                        ? localizations.simulation_particle_pause_button
                        : localizations.simulation_particle_start_button),
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isStarted ? _stop : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                localizations.simulation_particle_stop_button,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _getStatus,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                localizations.simulation_particle_get_status_button,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
