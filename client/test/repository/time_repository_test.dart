// test/repository/time_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/repository/time_repository.dart';
import 'package:ui/services/api_service.dart';
import 'package:ui/state/providers/data_provider.dart';

class MockApiService extends ApiService {
  MockApiService({required super.baseUrl});

  @override
  Future<Map<String, dynamic>> fetchData(String path) async {
    return {'current_time': '2024-03-12T09:23:54.558Z'};
  }
}

void main() {
  test('TimeRepository - getCurrentTime', () async {
    final mockApiService = MockApiService(baseUrl: 'https://example.com');
    final dataProvider = DataProvider();
    final timeRepository =
        TimeRepository(apiService: mockApiService, dataProvider: dataProvider);
    final currentTime = await timeRepository.getCurrentTime();

    expect(currentTime, '2024-03-12T09:23:54.558Z');
    expect(dataProvider.data.source, ['2024-03-12T09:23:54.558Z']);
  });
}
