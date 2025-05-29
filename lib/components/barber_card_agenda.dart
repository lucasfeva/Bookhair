import 'package:flutter/material.dart';

class BarberCardAgenda extends StatelessWidget {
  final String nomeServico;
  final String preco;
  final String horario;
  final String barbeiro;

  const BarberCardAgenda({
    Key? key,
    required this.nomeServico,
    required this.preco,
    required this.horario,
    required this.barbeiro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nomeServico,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Horário: $horario'),
            Text('Barbeiro: $barbeiro'),
            Text('Preço: $preco'),
          ],
        ),
      ),
    );
  }
}
