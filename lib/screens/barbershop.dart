import 'package:bookhair/data/constants/colors.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/service_item.dart';
import '../models/barbershop.dart';

class BarbershopScreen extends StatelessWidget {
  final Barbershop barbershop;

  const BarbershopScreen({super.key, required this.barbershop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // Imagem de capa + botão de voltar
          Stack(
            children: [
              ClipRRect(
                child: Image.network(
                  barbershop.imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 300,
                      color: AppColors.gray200,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: AppColors.gray500,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 12,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          // Conteúdo da barbearia com borda arredondada e translate
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 36, 20, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome e status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              barbershop.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.gray950,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // refazer
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Aberto',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Endereço
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: AppColors.slate500,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              barbershop.address,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.gray400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Avaliação
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: AppColors.slate500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${barbershop.rating} (3.279 Avaliações)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.gray400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Ações
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Button(
                            icon: Icons.chat_bubble_outline,
                            iconSize: 24,
                            text: '',
                            variant: ButtonVariant.ghost,
                          ),
                          Button(
                            icon: Icons.phone_outlined,
                            iconSize: 24,
                            text: '',
                            variant: ButtonVariant.ghost,
                          ),
                          Button(
                            icon: Icons.location_on_outlined,
                            iconSize: 24,
                            text: '',
                            variant: ButtonVariant.ghost,
                          ),
                          Button(
                            icon: Icons.share_outlined,
                            iconSize: 24,
                            text: '',
                            variant: ButtonVariant.ghost,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 8),

                      // Título serviços
                      const Text(
                        'Serviços',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.gray900,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Lista de serviços
                      const ServiceItem(name: 'Cabelo', price: 'R\$ 30,00'),
                      const ServiceItem(
                        name: 'Cabelo + Barba',
                        price: 'R\$ 45,00',
                      ),
                      const ServiceItem(name: 'Barba', price: 'R\$ 15,00'),
                      const ServiceItem(name: 'Raspado', price: 'R\$ 15,00'),
                      const ServiceItem(
                        name: 'Alisamento masculino',
                        price: 'R\$ 60,00',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
