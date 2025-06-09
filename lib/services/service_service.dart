import 'dart:convert';
import '../core/api_client.dart';
import '../models/service.dart';

class ServiceService {
  final ApiClient _client;
  ServiceService(this._client);

  Future<List<Service>> fetchByBarbershop(int barbershopId) async {
    final resp = await _client.get('/api/v1/barbearias/$barbershopId/servicos');
    if (resp.statusCode == 200) {
      final List data = jsonDecode(resp.body) as List;
      return data
          .map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao carregar serviços: ${resp.statusCode}');
    }
  }
}
