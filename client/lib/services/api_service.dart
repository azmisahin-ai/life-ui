// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> fetchData(String path) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$path'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw ApiException(
            'Data not found. Status Code: ${response.statusCode}');
      } else {
        throw Exception(
            'Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw ApiException('Failed to load data. Error: $error');
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}
