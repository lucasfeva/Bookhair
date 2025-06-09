class User {
  final int id;
  final String nome;
  final String email;
  final String? telefone;
  final String? endereco;

  User({
    required this.id,
    required this.nome,
    required this.email,
    this.telefone,
    this.endereco,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      telefone: json['telefone'],
      endereco: json['endereco'],
    );
  }
}
