// test/services/api_service_test.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/services/api_service.dart';

void main() {
  test('ApiService fetchData should throw an exception for an invalid request',
      () async {
    final apiService = ApiService(baseUrl: 'https://example.com/api');
    const path = 'invalid_path';

    expect(() async => await apiService.fetchData(path), throwsException);
  });

  test('ApiService fetchData should throw ApiException for a 404 request',
      () async {
    final apiService = ApiService(baseUrl: 'https://example.com/api');
    const path = 'not_found_path';

    try {
      await apiService.fetchData(path);
      fail('Exception expected but not thrown');
    } catch (error) {
      if (kDebugMode) {
        print('Caught error: $error');
      }
      expect(error, isA<ApiException>());
    }
  });

  test('ApiService postData should throw an exception for an invalid request',
      () async {
    final apiService = ApiService(baseUrl: 'https://example.com/api');
    const path = 'invalid_path';
    final body = {'key': 'value'};

    expect(() async => await apiService.postData(path, body), throwsException);
  });

  test('ApiService postData should throw ApiException for a 404 request',
      () async {
    final apiService = ApiService(baseUrl: 'https://example.com/api');
    const path = 'not_found_path';
    final body = {'key': 'value'};

    try {
      await apiService.postData(path, body);
      fail('Exception expected but not thrown');
    } catch (error) {
      if (kDebugMode) {
        print('Caught error: $error');
      }
      expect(error, isA<ApiException>());
    }
  });

  test('ApiService postData should throw ApiException for a failed request',
      () async {
    final apiService = ApiService(baseUrl: 'https://example.com/api');
    const path = 'failed_request';
    final body = {'key': 'value'};

    try {
      await apiService.postData(path, body);
      fail('Exception expected but not thrown');
    } catch (error) {
      if (kDebugMode) {
        print('Caught error: $error');
      }
      expect(error, isA<ApiException>());
    }
  });
}
