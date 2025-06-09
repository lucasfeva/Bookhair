class Barbershop {
  final int id;
  final String name;
  final String address;
  final String? imageUrl;
  final double rating;
  final int totalReviews;
  final String? phone;
  final String? email;
  final double? latitude;
  final double? longitude;

  Barbershop({
    required this.id,
    required this.name,
    required this.address,
    this.imageUrl,
    required this.rating,
    required this.totalReviews,
    this.phone,
    this.email,
    this.latitude,
    this.longitude,
  });

  factory Barbershop.fromJson(Map<String, dynamic> json) {
    return Barbershop(
      id: json['id'] ?? 0,
      name: json['nome'] ?? '',
      address: json['endereco'] ?? '',
      imageUrl: json['imagem_url'], // pode ser null
      rating: double.tryParse(json['nota_media']?.toString() ?? '0') ?? 0.0,
      totalReviews: json['total_avaliacoes'] ?? 0,
      phone: json['telefone'],
      email: json['email'],
      latitude: double.tryParse(json['latitude']?.toString() ?? '0'),
      longitude: double.tryParse(json['longitude']?.toString() ?? '0'),
    );
  }
}
