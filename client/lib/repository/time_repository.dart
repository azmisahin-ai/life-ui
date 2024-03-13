// repository/time_repository.dart
import 'package:flutter/foundation.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/state/providers/data_provider.dart';

class TimeRepository {
  final ApiService apiService;
  final DataProvider dataProvider;

  TimeRepository({required this.apiService, required this.dataProvider});

  Future<String> getCurrentTime() async {
    try {
      final Map<String, dynamic> apiResponse =
          await apiService.fetchData('api/v1/time');

      final String currentTime = apiResponse['current_time'];

      dataProvider.data.addData(currentTime);

      return currentTime;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return "e";
  }
}
