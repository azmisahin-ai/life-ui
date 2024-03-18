// features/simulation/cards/simulation_particle_card.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    final numberOfParticles = _numberOfParticlesController.text;
    final timeStep = _timeStepController.text;

    if (numberOfParticles.isEmpty || timeStep.isEmpty) {
      _showErrorSnackbar(
          context,
          AppLocalizations.of(context)!
              .simulation_particle_numberOf_particles_is_empty);
      return;
    }

    if (!isNumeric(numberOfParticles) || !isFloat(timeStep)) {
      _showErrorSnackbar(
          context,
          AppLocalizations.of(context)!
              .simulation_particle_numberOf_Particles_is_numeric);
      return;
    }

    try {
      _simulationResult = widget.simulationRepository.startSimulation(
        numberOfParticles: numberOfParticles,
        timeStep: timeStep,
      ) as Future<SimulationResult>?;

      _simulationResult?.then((value) {
        setState(() {
          _isStarted = true;
          _isPaused = false;
        });
      }).catchError((error) {
        // Hata durumunu ele almak için gerekirse catchError ekleyebilirsiniz.
        if (kDebugMode) {
          print('Error in starting simulation: $error');
        }
        _showErrorSnackbar(
            context, 'Failed to start simulation. Error: $error');
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
          AppLocalizations.of(context)!.simulation_particle_start_failed,
        );
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
      await widget.simulationRepository.pauseSimulation();
      setState(() {
        _isPaused = !_isPaused;
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
    try {
      await widget.simulationRepository.stopSimulation();
      setState(() {
        _isStarted = false;
        _isPaused = false;
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
          AppLocalizations.of(context)!.simulation_particle_stop_failed,
        );
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

    return ExpansionTile(
      leading: Icon(widget.icon),
      title: Text(widget.title),
      children: [
        TextFormField(
          controller: _numberOfParticlesController,
          decoration: InputDecoration(
            labelText:
                localizations.simulation_particle_number_Of_particles_label,
            hintText: localizations
                .simulation_particle_enter_number_Of_particles_hint,
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: _timeStepController,
          decoration: InputDecoration(
            labelText: localizations.simulation_particle_time_step_label,
            hintText: localizations
                .simulation_particle_enter_cycle_rate_Of_main_lifetime_hint,
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isStarted ? (_isPaused ? _start : _pause) : _start,
          child: Text(
            _isPaused
                ? localizations.simulation_particle_continue_button
                : (_isStarted
                    ? localizations.simulation_particle_pause_button
                    : localizations.simulation_particle_start_button),
          ),
        ),
        ElevatedButton(
          onPressed: _stop,
          child: Text(localizations.simulation_particle_stop_button),
        ),
      ],
    );
  }
}
