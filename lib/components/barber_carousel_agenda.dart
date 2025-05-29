import 'package:flutter/material.dart';

class BarberCarouselAgenda extends StatelessWidget {
  final List<Map<String, dynamic>> barbeiros; // nome + imagem
  final int barbeiroSelecionado;
  final Function(int) onSelecionar;

  const BarberCarouselAgenda({
    Key? key,
    required this.barbeiros,
    required this.barbeiroSelecionado,
    required this.onSelecionar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: barbeiros.length,
        itemBuilder: (context, index) {
          final selecionado = index == barbeiroSelecionado;
          final barbeiro = barbeiros[index];
          final String nome = barbeiro['nome'];
          final String? imagem = barbeiro['imagem'];

          return GestureDetector(
            onTap: () => onSelecionar(index),
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selecionado ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey[200],
                      // Aqui decidimos se a imagem é local ou remota:
                      backgroundImage: _getImageProvider(imagem),
                      child:
                          imagem == null
                              ? Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.grey[600],
                              )
                              : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    nome,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ImageProvider? _getImageProvider(String? imagem) {
    if (imagem == null) {
      return null;
    }
    // Se começar com http, retorna NetworkImage
    if (imagem.startsWith('http')) {
      return NetworkImage(imagem);
    }
    // Caso contrário, assume que é uma imagem local no assets
    return AssetImage(imagem);
  }
}
