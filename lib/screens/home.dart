import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookHair'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.blue),
                title: const Text('Próximo agendamento'),
                subtitle: const Text('Corte com João às 14:00h'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Barbearias Populares',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBarbeariaTile(
              context,
              nome: 'Barbearia do Zé',
              endereco: 'Av. Central, 234 - Centro',
              imagem: 'https://i.pravatar.cc/150?img=10',
            ),
            _buildBarbeariaTile(
              context,
              nome: 'Top Fade Barber',
              endereco: 'Rua das Flores, 120',
              imagem: 'https://i.pravatar.cc/150?img=12',
            ),
            _buildBarbeariaTile(
              context,
              nome: 'Barbearia Estilo',
              endereco: 'Praça da Liberdade, 89',
              imagem: 'https://i.pravatar.cc/150?img=13',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarbeariaTile(BuildContext context,
      {required String nome, required String endereco, required String imagem}) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imagem),
          ),
          title: Text(nome),
          subtitle: Text(endereco),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Ação ao tocar na barbearia
          },
        ),
        const Divider(),
      ],
    );
  }
}
