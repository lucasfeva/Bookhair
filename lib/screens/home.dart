import 'package:bookhair/data/constants/colors.dart';
import 'package:bookhair/screens/barbershop.dart';
import 'package:bookhair/components/appointment_card.dart';
import 'package:bookhair/components/barbershop_carousel.dart';
import 'package:bookhair/components/home_top_bar.dart';
import 'package:bookhair/components/service_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/appointment_detail.dart';
import '../models/barbershop.dart';
import '../providers/barbershop_provider.dart';
import '../providers/appointment_provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final authProv = context.read<AuthProvider>();
    final apptProv = context.read<AppointmentProvider>();
    apptProv.loadHistory(authProv.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    final barProv = context.watch<BarbershopProvider>();
    final apptProv = context.watch<AppointmentProvider>();

    return Scaffold(
      backgroundColor: AppColors.gray900,
      endDrawer: _buildDrawer(context),
      body:
          barProv.loading
              ? const Center(child: CircularProgressIndicator())
              : barProv.error != null
              ? Center(child: Text(barProv.error!))
              : SingleChildScrollView(
                child: Column(
                  children: [
                    const HomeTopBar(),
                    _WhiteBody(
                      barbershops: barProv.barbershops,
                      nextAppointment: apptProv.nextAppointment,
                      isLoadingAppointment: apptProv.loading,
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildDrawer(BuildContext ctx) => Drawer(/* ... */);
}

class _WhiteBody extends StatelessWidget {
  final List<Barbershop> barbershops;
  final AppointmentDetail? nextAppointment;
  final bool isLoadingAppointment;

  const _WhiteBody({
    super.key,
    required this.barbershops,
    this.nextAppointment,
    required this.isLoadingAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      onPressed:
                          () => Navigator.pushNamed(context, '/appointments'),
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
                if (isLoadingAppointment)
                  const Center(child: CircularProgressIndicator())
                else if (nextAppointment == null)
                  const Text('Nenhum agendamento futuro')
                else
                  AppointmentCard(
                    dateTime: nextAppointment!.dateTime,
                    status: nextAppointment!.status,
                    barbershopName: nextAppointment!.barbershopName,
                    address: nextAppointment!.address,
                    services: nextAppointment!.servicesLabel,
                    imageUrl: nextAppointment!.imageUrl,
                    showActions: true,
                    onCancel: () {},
                    onMessage: () {},
                  ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Populares (lista de barbearias)
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
          BarbershopCarousel(
            barbershops: barbershops,
            onTap:
                (b) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BarbershopScreen(barbershop: b),
                  ),
                ),
          ),
          const SizedBox(height: 24),

          // Populares (lista de barbearias)
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
          BarbershopCarousel(
            barbershops: barbershops,
            onTap:
                (b) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BarbershopScreen(barbershop: b),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
