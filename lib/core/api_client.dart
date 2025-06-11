import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  String? _token;

  ApiClient({required this.baseUrl});

  void setToken(String token) => _token = token;
  String? get token => _token;

  Map<String, String> get _headers {
    final h = {'Content-Type': 'application/json'};
    if (_token != null) h['Authorization'] = 'Bearer $_token';
    return h;
  }

  Future<http.Response> get(String path) {
    final uri = Uri.parse('$baseUrl$path');
    return http.get(uri, headers: _headers);
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) {
    final uri = Uri.parse('$baseUrl$path');
    return http.post(uri, headers: _headers, body: jsonEncode(body));
  }
}
