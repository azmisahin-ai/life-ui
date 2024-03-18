// features/simulation/simulation_result_card.dart

import 'package:flutter/material.dart';
import 'package:ui/features/simulation/simulation_result.dart';
import 'package:ui/repository/simulation_repository.dart';
import 'dart:async';

class SimulationResultCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final SimulationRepository simulationRepository;

  const SimulationResultCard({
    super.key,
    required this.title,
    required this.icon,
    required this.simulationRepository,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SimulationResultCardState createState() => _SimulationResultCardState();
}

class _SimulationResultCardState extends State<SimulationResultCard> {
  late StreamSubscription<SimulationResult> _resultSubscription;
  SimulationResult? _currentResult;

  @override
  void initState() {
    super.initState();
    _resultSubscription =
        widget.simulationRepository.resultStream.listen((result) {
      setState(() {
        _currentResult = result;
      });
    });
  }

  @override
  void dispose() {
    _resultSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon),
      title: Text(widget.title),
      subtitle:
          _currentResult != null ? _buildResultSubtitle() : const Text('No result'),
      onTap: () {},
    );
  }

  Widget _buildResultSubtitle() {
    final result = _currentResult!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status: ${result.status}'),
        Text('Number of Particles: ${result.numberOfParticles}'),
        Text('Time Step: ${result.timeStep}'),
        if (result.particle != null) ...[
          Text('Particle Name: ${result.particle!.name}'),
          Text('Particle Charge: ${result.particle!.charge}'),
          Text('Particle Mass: ${result.particle!.mass}'),
          // Diğer tüm özellikleri de buraya ekleyebilirsiniz
        ],
      ],
    );
  }
}
