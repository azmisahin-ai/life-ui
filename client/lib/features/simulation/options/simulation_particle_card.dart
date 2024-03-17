// features/simulation/options/simulation_particle_card.dart

import 'package:flutter/material.dart';
import 'package:ui/services/api_service.dart';

class SimulationParticleCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final ApiService apiService;

  const SimulationParticleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.apiService,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SimulationParticleCardState createState() => _SimulationParticleCardState();
}

class _SimulationParticleCardState extends State<SimulationParticleCard> {
  bool _isStarted = false;
  bool _isPaused = false;

  Future<void> _start() async {
    setState(() {
      _isStarted = true;
      _isPaused = false;
    });
  }

  Future<void> _pause() async {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  Future<void> _stop() async {
    setState(() {
      _isStarted = false;
      _isPaused = false;
    });
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
