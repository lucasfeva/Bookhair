import 'package:flutter/material.dart';
import '../models/barbershop.dart';
import 'barbershop_card.dart';

class BarbershopCarousel extends StatelessWidget {
  final List<Barbershop> barbershops;
  final void Function(Barbershop)? onTap;

  const BarbershopCarousel({super.key, required this.barbershops, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 277,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: barbershops.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final b = barbershops[index];
          return BarbershopCard(
            name: b.name,
            address: b.address,
            imageUrl: b.imageUrl,
            rating: b.rating,
            onReserve: () => onTap?.call(b),
          );
        },
      ),
    );
  }
}
