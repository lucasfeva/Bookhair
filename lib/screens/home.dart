import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Padding horizontal padrão
  final EdgeInsets _padding = const EdgeInsets.symmetric(horizontal: 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // ─── HEADER ───────────────────────────────────────
            Padding(
              padding: _padding.copyWith(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Saudação + localização
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, Lucas Ferreira',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(
                            'Rio Claro, SP',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Menu
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.menu),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ─── SEARCH BAR ───────────────────────────────────
            Padding(
              padding: _padding,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Pesquisar',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const Icon(Icons.map, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ─── PROMO CARD ───────────────────────────────────
            Padding(
              padding: _padding,
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade300, Colors.blue.shade600],
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Barbearia exemplo',
                        style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Promo do dia',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '30%',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ganhe um desconto para cada pedido de serviço! Válido apenas por hoje!',
                      style: TextStyle(color: Colors.white70),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ─── CATEGORIAS ───────────────────────────────────
            Padding(
              padding: _padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _CategoryItem('Cabelo', 'assets/icons/hugeicons_shampoo.png'),
                  _CategoryItem('Barba', 'assets/icons/Vector.png'),
                  _CategoryItem('Sobrancelha', 'assets/icons/mingcute_eyebrow-fill.png'),
                  _CategoryItem('Química', 'assets/icons/tabler-icon-scissors.png'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ─── MEUS AGENDAMENTOS ────────────────────────────
            Padding(
              padding: _padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Meus agendamentos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Ver todos',
                      style: TextStyle(color: Colors.blue, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: _padding,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Placeholder de imagem
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            const Icon(Icons.image, size: 40, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      // Dados do agendamento
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('22 Feb 2025 • 10:00 AM',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            SizedBox(height: 4),
                            Text('Barbearia exemplo',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Av. 10a 105, Centro Rio Claro – SP',
                                style: TextStyle(fontSize: 12)),
                            SizedBox(height: 4),
                            Text('Serviços: Corte de cabelo + Barba',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      // Botões
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Mensagem'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ─── SEÇÃO HORIZONTAL (Próximos) ─────────────────
            const SectionHorizontal(title: 'Próximos'),

            const SizedBox(height: 24),

            // ─── SEÇÃO HORIZONTAL (Populares) ────────────────
            const SectionHorizontal(title: 'Populares'),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Widget de categoria com ícone
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

// Widget genérico para as seções horizontais
class SectionHorizontal extends StatelessWidget {
  final String title;

  const SectionHorizontal({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título da seção
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        // Lista horizontal de cards
        SizedBox(
          height: 200,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, __) => Container(
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Placeholder de imagem
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: const Icon(Icons.image, size: 40, color: Colors.white70),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Vintage Barber',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text('Avenida …', style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 8),
                        Center(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Reservar'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
