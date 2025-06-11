import 'dart:convert';
import '../core/api_client.dart';
import '../models/appointment.dart';

class AppointmentService {
  final ApiClient _client;
  AppointmentService(this._client);

  Future<List<Appointment>> fetchHistory(int clienteId) async {
    final resp = await _client.get('/api/v1/agendamentos/history/$clienteId');
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Appointment.fromJson(e)).toList();
    } else {
      throw Exception('Erro ${resp.statusCode}: ${resp.body}');
    }
  }
}
