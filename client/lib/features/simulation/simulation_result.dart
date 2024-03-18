// lib/features/simulation/simulation_result.dart
class SimulationResult {
  final String status;
  final int numberOfParticles;
  final double timeStep;
  final Particle? particle;

  SimulationResult({
    required this.status,
    required this.numberOfParticles,
    required this.timeStep,
    required this.particle,
  });

  factory SimulationResult.fromJson(Map<String, dynamic> json) {
    return SimulationResult(
      status: json['status'],
      numberOfParticles: json['number_of_particles'],
      timeStep: json['time_step'],
      particle: json.containsKey('particle')
          ? Particle.fromJson(json['particle'])
          : null,
    );
  }
}

class Particle {
  final String name;
  final double charge;
  final double mass;
  final double spin;
  final int lifetime;
  final double energy;
  final Vector position;
  final Vector velocity;
  final Vector momentum;

  Particle({
    required this.name,
    required this.charge,
    required this.mass,
    required this.spin,
    required this.lifetime,
    required this.energy,
    required this.position,
    required this.velocity,
    required this.momentum,
  });

  factory Particle.fromJson(Map<String, dynamic> json) {
    return Particle(
      name: json['name'],
      charge: json['charge'],
      mass: json['mass'],
      spin: json['spin'],
      lifetime: json['lifetime'],
      energy: json['energy'],
      position: Vector.fromJson(json['position']),
      velocity: Vector.fromJson(json['velocity']),
      momentum: Vector.fromJson(json['momentum']),
    );
  }
}

class Vector {
  final double x;
  final double y;
  final double z;

  Vector({
    required this.x,
    required this.y,
    required this.z,
  });

  factory Vector.fromJson(Map<String, dynamic> json) {
    return Vector(
      x: json['x'],
      y: json['y'],
      z: json['z'],
    );
  }
}
