// lib/models/appointment_model.dart

/// Representa o modelo de dados de um agendamento, alinhado com a resposta da API.
class AppointmentModel {
  final String id;
  final DateTime date;
  final String status;
  final String serviceName;
  final String salonName;

  AppointmentModel({
    required this.id,
    required this.date,
    required this.status,
    required this.serviceName,
    required this.salonName,
  });

  /// Construtor de fábrica para criar uma instância de AppointmentModel a partir de um JSON.
  /// Este método é crucial para converter a resposta da API em um objeto Dart.
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    // Validações para garantir que os objetos aninhados não são nulos antes de acessá-los.
    final serviceData = json['servico'] as Map<String, dynamic>? ?? {};
    final salonData = json['estabelecimento'] as Map<String, dynamic>? ?? {};
    
    return AppointmentModel(
      // A API usa '_id' para o identificador do documento.
      id: json['_id'],

      // A API envia a data como uma String no formato ISO 8601.
      // DateTime.parse() a converte para um objeto DateTime.
      date: DateTime.parse(json['data']),

      // O status vem diretamente da API (ex: 'Agendado', 'Concluido').
      status: json['status'],

      // Acessa o nome do serviço que está dentro do objeto 'servico'.
      serviceName: serviceData['nome'] ?? 'Serviço não informado',

      // Acessa o nome do salão que está dentro do objeto 'estabelecimento'.
      salonName: salonData['nome'] ?? 'Salão não informado',
    );
  }
}