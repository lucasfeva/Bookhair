class Service {
  final int id;
  final int barbershopId;
  final String name;
  final String description;
  final int durationMinutes;
  final double price;

  Service({
    required this.id,
    required this.barbershopId,
    required this.name,
    required this.description,
    required this.durationMinutes,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? 0,
      barbershopId: json['barbearia_id'] ?? 0,
      name: json['nome'] ?? '',
      description: json['descricao'] ?? '',
      durationMinutes: json['duracao_minutos'] ?? 0,
      price: double.tryParse(json['preco']?.toString() ?? '0') ?? 0.0,
    );
  }

  String get formattedPrice =>
      'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}';
}
