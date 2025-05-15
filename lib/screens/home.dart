import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final _padding = const EdgeInsets.symmetric(horizontal: 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // ... cabeçalho, busca, promo, etc.

            // CATEGORIAS
            Padding(
              padding: _padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CategoryItem('Cabelo', 'assets/icons/hugeicons_shampoo.png'),
                  _CategoryItem('Barba', 'assets/icons/Vector.png'),
                  _CategoryItem('Sobrancelha', 'assets/icons/mingcute_eyebrow-fill.png'),
                  _CategoryItem('Química', 'assets/icons/tabler-icon-scissors.png'),
                ],
              ),
            ),

            // ... resto da tela
          ],
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String label;
  final String assetPath;
  const _CategoryItem(this.label, this.assetPath);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(assetPath),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
