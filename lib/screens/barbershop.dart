import 'package:bookhair/models/barber.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/api_client.dart';
import '../services/service_service.dart';
import '../providers/service_provider.dart';
import '../services/professional_service.dart';
import '../providers/professional_provider.dart';

import '../data/constants/colors.dart';
import '../models/barbershop.dart';
import '../components/button.dart';
import '../components/service_item.dart';
import '../components/barber_carousel.dart';

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
          // capa + botão voltar
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

          // corpo branco arredondado
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 36, 20, 20),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome, endereço e avaliação
                      Text(
                        barbershop.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: AppColors.gray900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        barbershop.address,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.gray400,
                        ),
                      ),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 16),

                      // Ações: chat, ligar, mapa, compartilhar
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

                      // Serviços dinâmicos
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
                          ),
                        ),
                      const SizedBox(height: 24),

                      // Profissionais usando seu component BarberCarousel
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
