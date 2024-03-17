// features/simulation/simulation_view.dart
//import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ui/features/simulation/simulation_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ui/features/simulation/simulation_result_card.dart';
import 'package:ui/services/api_service.dart';

class SimulationView extends StatefulWidget {
  const SimulationView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SimulationViewState createState() => _SimulationViewState();
}

class _SimulationViewState extends State<SimulationView> {
  late Future<ApiService> _apiServiceFuture;

  @override
  void initState() {
    super.initState();
    _apiServiceFuture = _initializeApiService();
  }

  Future<ApiService> _initializeApiService() async {
    await dotenv.load();
    final serverAddress =
        dotenv.env['REMOTE_SERVICE_ADDRESS'] ?? "127.0.0.1:8080";
    return ApiService(baseUrl: serverAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.simulation_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<ApiService>(
          future: _apiServiceFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Snapshot Error: ${snapshot.error}'),
              );
            } else {
              final apiService = snapshot.requireData;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: SimulationCard(
                      title:
                          AppLocalizations.of(context)!.simulation_card_title,
                      icon: Icons.keyboard_option_key,
                      apiService: apiService,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 7,
                    child: SimulationResultCard(
                      title: AppLocalizations.of(context)!
                          .simulation_result_card_title,
                      icon: Icons.show_chart,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
