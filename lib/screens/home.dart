import 'package:flutter/material.dart';
import '../components/home_top_bar.dart';
import '../components/service_categories.dart';
import '../components/appointment_card.dart';
import '../components/barbershop_carousel.dart';
import '../models/barbershop.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141416),

      endDrawer: Drawer(
        backgroundColor: const Color(0xFF141416),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF141416)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Início', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Perfil', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pushNamed(context, '/perfil'),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeTopBar(),
            _WhiteBody(),
          ],
        ),
      ),
    );
  }
}

class _WhiteBody extends StatelessWidget {
  const _WhiteBody();

  @override
  Widget build(BuildContext context) {
    final barbershopList = List.generate(10, (index) {
      return Barbershop(
        name: 'Vintage Barber',
        address: 'Avenida São Sebastião, 357...',
        imageUrl: 'assets/images/barbershop_2.png',
        rating: 4.7,
      );
    });

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const ServiceCategories(),
          const SizedBox(height: 30),

          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Meus agendamentos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
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
                          color: Colors.blueAccent,
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

          const SizedBox(height: 32),

          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Próximos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          BarbershopCarousel(barbershops: barbershopList),

          const SizedBox(height: 32),

          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Populares',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
