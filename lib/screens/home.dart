import 'package:flutter/material.dart';
import '../components/home_top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeTopBar(),

            // Aqui você pode incluir:
            // CategorySection(),
            // BarbershopCarousel(),
            // AppointmentCardList(),
          ],
        ),
      ),
    );
  }
}
