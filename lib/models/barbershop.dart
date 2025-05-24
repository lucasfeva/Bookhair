class Barbershop {
  final int id;
  final String name;
  final String address;
  final String imageUrl;
  final double rating;

  Barbershop({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.rating,
  });

  // Cria um objeto a partir do JSON da API
  factory Barbershop.fromJson(Map<String, dynamic> json) {
    return Barbershop(
      id: json['id'] as int,
      name: json['nome'] as String,
      address: json['endereco'] as String,
      imageUrl: 'assets/images/barbershop_placeholder.png',
      rating: 0.0,
    );
  }
}
