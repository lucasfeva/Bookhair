import 'dart:convert';
import '../core/api_client.dart';
import '../models/barbershop.dart';

class BarbershopService {
  final ApiClient _client;

  BarbershopService(this._client);

  /// Busca todas as barbearias (ou pesquisa, se quiser passar q)
  Future<List<Barbershop>> fetchAll({String query = ''}) async {
    final resp = await _client.get('/api/v1/barbearias/search?q=$query');
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body) as List;
      return data
          .map((e) => Barbershop.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao carregar barbearias: ${resp.statusCode}');
    }
  }
}
