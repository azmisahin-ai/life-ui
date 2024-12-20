import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;

serverAddress() {
  return "http://127.0.0.1:8281";
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Simulation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SocketIOPage(),
    );
  }
}

class SocketIOPage extends StatefulWidget {
  const SocketIOPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SocketIOPageState createState() => _SocketIOPageState();
}

class _SocketIOPageState extends State<SocketIOPage> {
  String status = '';
  String instance = '';
  String instanceCreated = '';
  String itemName = '';
  double lifeStartTime = 0.0;
  double elapsedLifespan = 0.0;

  double lifecycle = 0.0;
  double lifetimeSeconds = 0.0;
  double charge = 0.0;
  double mass = 0.0;
  double spin = 0.0;
  double energy = 0.0;
  Map<String, dynamic> position = {};
  Map<String, dynamic> velocity = {};
  Map<String, dynamic> momentum = {};
  Map<String, dynamic> waveFunction = {};
  String? simulationType = "Particles";
  int? numberOfInstance;
  double parseLifetimeSeconds(dynamic value) {
    if (value is String && value.toLowerCase() == "infinity") {
      return double.infinity;
    }
    return value is num ? value.toDouble() : 0.0;
  }

  late io.Socket socket;

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  void connectToSocket() {
    socket = io.io(serverAddress(), <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('simulation_status', (data) {
      setState(() {
        status = data['simulation_status'];
      });
    });

    socket.on('simulation_sampler_status', (data) {
      setState(() {
        instance = 'Number of instances: ${data['number_of_instance']}';
        instanceCreated =
            'instance created : ${data['number_of_instance_created']}';
      });
    });

    socket.on('simulation_instance_status', (data) {
      setState(() {
        itemName = data.containsKey('name') ? data['name'] : 'N/A';
        lifeStartTime =
            data.containsKey('life_start_time') ? data['life_start_time'] : 0.0;
        elapsedLifespan = data.containsKey('elapsed_lifespan')
            ? data['elapsed_lifespan']
            : 0.0;

        lifecycle = data.containsKey('lifecycle') ? data['lifecycle'] : 0.0;

        // lifetime_seconds değerini analiz etme
        lifetimeSeconds = parseLifetimeSeconds(data['lifetime_seconds']);
        charge = data.containsKey('charge') ? data['charge'] : 0.0;
        mass = data.containsKey('mass') ? data['mass'] : 0.0;
        spin = data.containsKey('spin') ? data['spin'] : 0.0;
        energy = data.containsKey('energy') ? data['energy'] : 0.0;
        position = data.containsKey('position') ? data['position'] : {};
        velocity = data.containsKey('velocity') ? data['velocity'] : {};
        momentum = data.containsKey('momentum') ? data['momentum'] : {};
        waveFunction =
            data.containsKey('wave_function') ? data['wave_function'] : {};
      });
    });
  }

  Future<void> startSimulation(
      String simulationType, int numberOfInstance) async {
    final response = await http.post(
      Uri.parse(serverAddress() + '/socket/v1/simulation/start'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "number_of_instance": numberOfInstance,
        // "lifetime_seconds": Null,
        "lifecycle": 60 / 1,
        "simulation_type": simulationType,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        status = 'Simulation started';
      });
    } else {
      setState(() {
        status = 'Failed to start simulation';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Simulation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Start Simulation'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Select Simulation Type:'),
                        DropdownButton<String>(
                          isExpanded: true, // Genişliği otomatik olarak ayarlar
                          value: simulationType, // default value
                          onChanged: (String? newValue) {
                            setState(() {
                              if (newValue != null) {
                                simulationType = newValue;
                              }
                            });
                          },
                          items: <String>['Particles', 'Core']
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 10),
                        const Text('Enter Number of Instances:'),
                        TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            numberOfInstance = int.tryParse(value) ?? 0;
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (simulationType != null &&
                              numberOfInstance != null) {
                            startSimulation(simulationType!, numberOfInstance!);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Start'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Start Simulation'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Simulation Status:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(status),
            const SizedBox(height: 20),
            const Text(
              'Simulation Instance:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(instance),
            const SizedBox(height: 10),
            Text(instanceCreated),
            const SizedBox(height: 20),
            const Text(
              'Simulation Item:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Name: $itemName'),
            Text('Life Start Time: $lifeStartTime'),
            Text('Elapsed Lifespan: $elapsedLifespan'),
            Text('Lifecycle: $lifecycle'),
            Text('Lifetime Seconds: $lifetimeSeconds'),
            Text('Charge: $charge'),
            Text('Mass: $mass'),
            Text('Spin: $spin'),
            Text('Energy: $energy'),
            Text('Position: $position'),
            Text('Velocity: $velocity'),
            Text('Momentum: $momentum'),
            Text('Wave Function: $waveFunction'),
          ],
        ),
      ),
    );
  }
}
