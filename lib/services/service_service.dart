import 'dart:convert';
import '../core/api_client.dart';
import '../models/service.dart';

class ServiceService {
  final ApiClient _client;

  ServiceService(this._client);

  /// Lista todos os serviços de uma barbearia
  Future<List<Service>> fetchByBarbershop(int barbeariaId) async {
    final resp = await _client.get('/api/v1/barbearias/$barbeariaId/servicos');
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Service.fromJson(e)).toList();
    }
    throw Exception('Erro ${resp.statusCode}');
  }

  /// Busca um serviço específico pelo seu ID
  Future<Service> fetchById(int id) async {
    final resp = await _client.get('/api/v1/servicos/$id');
    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      return Service.fromJson(json);
    }
    throw Exception('Erro ${resp.statusCode}');
  }
}
