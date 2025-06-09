import 'dart:convert';
import '../core/api_client.dart';
import '../models/professional.dart';

class ProfessionalService {
  final ApiClient _client;
  ProfessionalService(this._client);

  Future<List<Professional>> fetchByBarbershop(int barbeariaId) async {
    final response = await _client.get(
      '/api/v1/profissionais?barbearia_id=$barbeariaId',
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body) as List;
      return data
          .map((e) => Professional.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao carregar profissionais: ${response.statusCode}');
    }
  }
}
