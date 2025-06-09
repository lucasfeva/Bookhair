class Professional {
  final int id;
  final String nome;
  final int barbeariaId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Professional({
    required this.id,
    required this.nome,
    required this.barbeariaId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: json['id'] as int,
      nome: json['nome'] as String,
      barbeariaId: json['barbearia_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
