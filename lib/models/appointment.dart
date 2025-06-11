class Appointment {
  final int id;
  final int clienteId;
  final int profissionalId;
  final int servicoId;
  final int barbeariaId;
  final DateTime dateHora;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Appointment({
    required this.id,
    required this.clienteId,
    required this.profissionalId,
    required this.servicoId,
    required this.barbeariaId,
    required this.dateHora,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    // A API usa "2025-06-20 22:53:43" sem o 'T', então substituímos o espaço
    final raw = (json['data_hora'] as String).replaceFirst(' ', 'T');
    return Appointment(
      id: json['id'] as int,
      clienteId: json['cliente_id'] as int,
      profissionalId: json['profissional_id'] as int,
      servicoId: json['servico_id'] as int,
      barbeariaId: json['barbearia_id'] as int,
      dateHora: DateTime.parse(raw),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
