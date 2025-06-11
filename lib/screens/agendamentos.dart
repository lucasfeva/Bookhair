import 'package:flutter/material.dart';

class AgendamentosScreen extends StatelessWidget {
  const AgendamentosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Agendamentos')),
      body: const Center(
        child: Text(
          'Aqui será exibida a lista de agendamentos do usuário.\n\n(Em breve, tela completa!)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
