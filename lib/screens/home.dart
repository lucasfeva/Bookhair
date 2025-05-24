import 'package:bookhair/data/constants/colors.dart';
import 'package:bookhair/screens/barbershop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/home_top_bar.dart';
import '../components/service_categories.dart';
import '../components/appointment_card.dart';
import '../components/barbershop_carousel.dart';
import '../providers/barbershop_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final barbershopProv = context.watch<BarbershopProvider>();

    return Scaffold(
      backgroundColor: AppColors.gray900,
      endDrawer: Drawer(
        backgroundColor: AppColors.gray900,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.gray900),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text(
                'Início',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                'Perfil',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pushNamed(context, '/perfil'),
            ),
          ],
        ),
      ),
      body:
          barbershopProv.loading
              ? const Center(child: CircularProgressIndicator())
              : barbershopProv.error != null
              ? Center(child: Text(barbershopProv.error!))
              : SingleChildScrollView(
                child: Column(
                  children: [const HomeTopBar(), const _WhiteBody()],
                ),
              ),
    );
  }
}

class _WhiteBody extends StatelessWidget {
  const _WhiteBody();

  @override
  Widget build(BuildContext context) {
    final barbershopProv = context.read<BarbershopProvider>();
    final barbershopList = barbershopProv.barbershops;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const ServiceCategories(),
          const SizedBox(height: 32),

          // Meus agendamentos
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Meus agendamentos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gray950,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Ver todos',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.slate500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppointmentCard(
                  dateTime: DateTime(2025, 4, 3, 18, 30),
                  status: 'Confirmado',
                  barbershopName: 'Barbearia Exemplo',
                  address: '105 Av. 10a, Centro Rio Claro - SP',
                  services: 'Corte de cabelo + Barba',
                  imageUrl: 'assets/images/barbershop_example.png',
                  showActions: true,
                  onCancel: () {},
                  onMessage: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Próximos
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: const Text(
              'Próximos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.gray950,
              ),
            ),
          ),
          const SizedBox(height: 16),
          BarbershopCarousel(
            barbershops: barbershopList,
            onTap: (barbershop) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BarbershopScreen(barbershop: barbershop),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // Populares
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: const Text(
              'Populares',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.gray950,
              ),
            ),
          ),
          const SizedBox(height: 16),
          BarbershopCarousel(barbershops: barbershopList),
        ],
      ),
    );
  }
}
