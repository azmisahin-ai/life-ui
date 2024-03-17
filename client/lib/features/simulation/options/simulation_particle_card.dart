// features/simulation/options/simulation_particle_card.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/repository/simulation_repository.dart';

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

  Future<void> _start() async {
    try {
      await widget.simulationRepository.startSimulation();
      setState(() {
        _isStarted = true;
        _isPaused = false;
      });
    } catch (e) {
      if (kDebugMode) {
        // ignore: use_build_context_synchronously
        _showErrorSnackbar(context, '$e');
      } else {
        // ignore: use_build_context_synchronously
        _showErrorSnackbar(context, 'Failed to start simulation');
      }
    }
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
        // ignore: use_build_context_synchronously
        _showErrorSnackbar(context, 'Failed to pause simulation');
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
        // ignore: use_build_context_synchronously
        _showErrorSnackbar(context, 'Failed to stop simulation');
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
    return ExpansionTile(
      leading: Icon(widget.icon),
      title: Text(widget.title),
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Number of particles',
            hintText: 'Enter number of particles',
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Time step',
            hintText: 'Enter cycle rate of main life time',
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isStarted ? (_isPaused ? _start : _pause) : _start,
          child:
              Text(_isPaused ? 'Continue' : (_isStarted ? 'Pause' : 'Start')),
        ),
        ElevatedButton(
          onPressed: _stop,
          child: const Text('Stop'),
        ),
      ],
    );
  }
}
