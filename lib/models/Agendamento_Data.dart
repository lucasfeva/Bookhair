class AgendamentoData {
  final String nomeServico;
  final double preco;
  final String nomeBarbeiro;
  final String fotoBarbeiroUrl;
  final List<String> horariosDisponiveis;

  AgendamentoData({
    required this.nomeServico,
    required this.preco,
    required this.nomeBarbeiro,
    required this.fotoBarbeiroUrl,
    required this.horariosDisponiveis,
  });
}
