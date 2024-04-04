// features/simulation/simulation_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ui/features/simulation/simulation_card.dart';
import 'package:ui/features/simulation/simulation_result_card.dart';
import 'package:ui/repository/simulation_repository.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/state/providers/simulation_data_provider.dart';

class SimulationView extends StatefulWidget {
  const SimulationView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SimulationViewState createState() => _SimulationViewState();
}

class _SimulationViewState extends State<SimulationView> {
  late Future<SimulationRepository> _simulationRepositoryFuture;
  late ApiService _apiService;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeSimulationRepository();
  }

  Future<void> _initializeSimulationRepository() async {
    await _initializeApiService();
    final simulationRepository = SimulationRepository(
      apiService: _apiService,
      dataProvider: SimulationDataProvider(),
    );
    setState(() {
      _simulationRepositoryFuture = Future.value(simulationRepository);
      _isInitialized = true;
    });
  }

  Future<void> _initializeApiService() async {
    await dotenv.load();
    final serverAddress =
        dotenv.env['REMOTE_SERVICE_ADDRESS'] ?? "127.0.0.1:8080";
    final apiVersion = int.parse(dotenv.env['API_VERSION'] ?? '1');

    _apiService = ApiService(baseUrl: serverAddress, apiVersion: apiVersion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.simulation_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isInitialized
            ? _buildSimulationView()
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildSimulationView() {
    return FutureBuilder<SimulationRepository>(
      future: _simulationRepositoryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Snapshot Error: ${snapshot.error}'));
        } else {
          final simulationRepository = snapshot.requireData;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: SimulationCard(
                  title: AppLocalizations.of(context)!.simulation_card_title,
                  icon: Icons.keyboard_option_key,
                  simulationRepository: simulationRepository,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 7,
                child: SimulationResultCard(
                  title: AppLocalizations.of(context)!
                      .simulation_result_card_title,
                  icon: Icons.show_chart,
                  simulationRepository: simulationRepository,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
