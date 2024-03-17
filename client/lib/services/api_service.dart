// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final int? apiVersion;

  ApiService({required this.baseUrl, this.apiVersion});

  Future<Map<String, dynamic>> fetchData(String path) async {
    try {
      final url = apiVersion != null
          ? '$baseUrl/api/v$apiVersion/$path'
          : '$baseUrl/$path';

      final response = await http.get(Uri.parse(url));

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

  Future<Map<String, dynamic>> postData(
      String path, Map<String, dynamic> body) async {
    try {
      final url = apiVersion != null
          ? '$baseUrl/api/v$apiVersion/$path'
          : '$baseUrl/$path';

      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to send data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw ApiException('Failed to send data. Error: $error');
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}
