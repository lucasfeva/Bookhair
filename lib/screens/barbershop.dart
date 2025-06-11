import 'package:bookhair/components/barber_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/api_client.dart';
import '../services/service_service.dart';
import '../providers/service_provider.dart';
import '../services/professional_service.dart';
import '../providers/professional_provider.dart';
import '../screens/agendarservico.dart';

import '../components/service_item.dart';
import '../components/button.dart';
import '../components/barber_carousel.dart';
import '../data/constants/colors.dart';
import '../models/barbershop.dart';
import '../models/barber.dart';

/// Tela de detalhes de uma barbearia, com serviços e profissionais carregados dinamicamente
class BarbershopScreen extends StatelessWidget {
  final Barbershop barbershop;

  const BarbershopScreen({Key? key, required this.barbershop})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ApiClient>(context, listen: false);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ServiceProvider>(
          create: (_) {
            final prov = ServiceProvider(ServiceService(client));
            prov.load(barbershop.id);
            return prov;
          },
        ),
        ChangeNotifierProvider<ProfessionalProvider>(
          create: (_) {
            final prov = ProfessionalProvider(ProfessionalService(client));
            prov.load(barbershop.id);
            return prov;
          },
        ),
      ],
      child: _BarbershopView(barbershop: barbershop),
    );
  }
}

class _BarbershopView extends StatelessWidget {
  final Barbershop barbershop;

  const _BarbershopView({Key? key, required this.barbershop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final svcProv = context.watch<ServiceProvider>();
    final profProv = context.watch<ProfessionalProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // Imagem de capa + botão de voltar
          Stack(
            children: [
              Image.network(
                barbershop.imageUrl ?? '',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      width: double.infinity,
                      height: 300,
                      color: AppColors.gray200,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 60,
                        color: AppColors.gray500,
                      ),
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

          // Conteúdo branco com borda arredondada
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                width: double.infinity,
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
                      // Nome + status
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
                            '${barbershop.rating.toStringAsFixed(1)} '
                            '(${barbershop.totalReviews} avaliações)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.gray400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

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
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),

                      // Serviços
                      const Text(
                        'Serviços',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.gray900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (svcProv.loading)
                        const Center(child: CircularProgressIndicator())
                      else if (svcProv.error != null)
                        Center(child: Text(svcProv.error!))
                      else
                        ...svcProv.items.map(
                          (s) => ServiceItem(
                            name: s.name,
                            price: s.formattedPrice,
                            serviceId: s.id,
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Profissionais
                      const Text(
                        'Profissionais',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.gray900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (profProv.loading)
                        const Center(child: CircularProgressIndicator())
                      else if (profProv.error != null)
                        Center(child: Text(profProv.error!))
                      else
                        BarberCarousel(
                          barbers:
                              profProv.professionals
                                  .map(
                                    (p) => Barber(
                                      name: p.nome,
                                      role: null,
                                      imageUrl: null,
                                      backgroundColor: AppColors.gray200,
                                    ),
                                  )
                                  .toList(),
                          variant: BarberCardVariant.showcase,
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
