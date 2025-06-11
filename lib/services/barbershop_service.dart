import 'dart:convert';
import '../core/api_client.dart';
import '../models/barbershop.dart';

class BarbershopService {
  final ApiClient _client;

  BarbershopService(this._client);

  /// Busca a lista paginada de barbearias
  Future<List<Barbershop>> fetchAll({String query = ''}) async {
    final resp = await _client.get('/api/v1/barbearias/search?q=$query');
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Barbershop.fromJson(e)).toList();
    }
    throw Exception('Erro ${resp.statusCode}');
  }

  /// Busca os detalhes de uma barbearia pelo ID
  Future<Barbershop> fetchById(int id) async {
    final resp = await _client.get('/api/v1/barbearias/$id');
    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      return Barbershop.fromJson(json);
    }
    throw Exception('Erro ${resp.statusCode}');
  }
}
