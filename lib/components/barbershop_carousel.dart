import 'package:flutter/material.dart';
import 'barbershop_card.dart';
import '../models/barbershop.dart';

class BarbershopCarousel extends StatelessWidget {
  final List<Barbershop> barbershops;

  const BarbershopCarousel({super.key, required this.barbershops});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 277,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: barbershops.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final b = barbershops[index];
          return BarbershopCard(
            name: b.name,
            address: b.address,
            imageUrl: b.imageUrl,
            rating: b.rating,
            onReserve: () {
              print('Reservar ${b.name}');
            },
          );
        },
      ),
    );
  }
}
