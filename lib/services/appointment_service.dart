// lib/services/appointment_service.dart

import 'dart:convert';
import 'package:bookhair/models/appointment_model.dart';
import 'package:bookhair/utils/user_data.dart'; // Local onde você gerencia dados do usuário
import 'package:http/http.dart' as http;

/// Serviço responsável por todas as comunicações com a API relacionadas a agendamentos.
class AppointmentService {
  // !!! IMPORTANTE: Substitua pela URL base da sua API !!!
  // Para emulador Android, se a API estiver rodando localmente, use 'http://10.0.2.2:3000/api'
  // Para emulador iOS ou teste em dispositivo físico, use o IP da sua máquina na rede.
  final String _baseUrl = "http://SEU_IP_OU_DOMINIO:3000/api";
  //http://localhost:8000/?

  /// Busca a lista de agendamentos de um usuário específico na API.
  Future<List<AppointmentModel>> getUserAppointments(String userId) async {
    // Monta a URL completa para o endpoint correto.
    final url = Uri.parse('$_baseUrl/agendamentos/usuario/$userId');

    // Busca o token de autenticação salvo no dispositivo.
    // Este método precisa ser implementado por você para buscar o token salvo
    // (provavelmente via shared_preferences).
    final String? token = await UserData.getUserToken();

    if (token == null) {
      // Se não há token, o usuário não está logado.
      throw Exception('Usuário não autenticado. Faça o login novamente.');
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Envia o token JWT no cabeçalho, como exigido pela sua API.
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Usa utf8.decode para garantir o parse correto de caracteres especiais (acentos).
        final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
        
        // Mapeia a lista de JSONs para uma lista de objetos AppointmentModel.
        return body
            .map((jsonItem) => AppointmentModel.fromJson(jsonItem))
            .toList();
            
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // Trata erros de autenticação de forma específica.
        throw Exception('Sessão expirada. Por favor, faça o login novamente.');
      } else {
        // Trata outros erros do servidor.
        final errorBody = json.decode(response.body);
        throw Exception('Falha ao carregar agendamentos: ${errorBody['message']}');
      }
    } catch (e) {
      // Trata erros de conexão ou outros problemas inesperados.
      print(e); // Ajuda a debugar o erro no console.
      throw Exception('Não foi possível conectar ao servidor. Verifique sua internet.');
    }
  }
}