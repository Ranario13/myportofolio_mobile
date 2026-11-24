import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;

  const ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  final http.Client _client;
  final String baseUrl;

  ApiClient({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      baseUrl = (baseUrl ?? apiBaseUrl).replaceFirst(RegExp(r'/$'), '');

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Future<dynamic> _decodeResponse(http.Response response) async {
    dynamic body;
    if (response.body.isNotEmpty) {
      try {
        body = jsonDecode(response.body);
      } on FormatException {
        body = response.body;
      }
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = body is Map<String, dynamic>
          ? body['detail']?.toString() ?? body.toString()
          : body?.toString() ?? 'Request failed';
      throw ApiException(response.statusCode, message);
    }
    return body;
  }

  Future<List<Project>> getProjects() async {
    final response = await _client.get(
      _uri('/api/v1/projects/'),
      headers: {'Accept': 'application/json'},
    );
    final body = await _decodeResponse(response);
    if (body is! List) {
      throw const ApiException(500, 'Invalid project response');
    }
    return body
        .map((item) => Project.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Project> createProject(
    Project project, {
    required String token,
  }) async {
    final payload = project.toJson()..remove('id');
    final response = await _client.post(
      _uri('/api/v1/projects/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(payload),
    );
    final body = await _decodeResponse(response);
    if (response.statusCode != 201 || body is! Map<String, dynamic>) {
      throw ApiException(response.statusCode, 'Project was not created');
    }
    return Project.fromJson(body);
  }

  Future<String> obtainToken(String username, String password) async {
    final response = await _client.post(
      _uri('/api/v1/auth/token/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );
    final body = await _decodeResponse(response);
    if (body is! Map<String, dynamic> || body['token'] is! String) {
      throw const ApiException(500, 'Invalid token response');
    }
    return body['token'] as String;
  }

  Future<void> logout({required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/auth/logout/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );
    await _decodeResponse(response);
  }
}
