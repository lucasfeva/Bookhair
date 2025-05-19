import 'dart:convert';
import '../core/api_client.dart';
import '../models/user.dart';

class AuthService {
  final ApiClient _client;

  AuthService(this._client);

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final resp = await _client.post('/api/v1/auth/login', {
      'email': email,
      'password': password,
    });

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final user = User.fromJson(data['user'] as Map<String, dynamic>);
      final token = data['token'] as String;
      _client.setToken(token);
      return {'user': user, 'token': token};
    } else {
      throw Exception('Erro ${resp.statusCode}: ${resp.body}');
    }
  }
}
