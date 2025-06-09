import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/api_client.dart';
import '../services/service_service.dart';
import '../providers/service_provider.dart';
import '../models/barbershop.dart';
import 'barbershop_card.dart';

class BarbershopCarousel extends StatelessWidget {
  final List<Barbershop> barbershops;
  final void Function(Barbershop)? onTap;

  const BarbershopCarousel({Key? key, required this.barbershops, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 277,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: barbershops.length,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemBuilder: (context, index) {
          final b = barbershops[index];
          return BarbershopCard(
            name: b.name,
            address: b.address,
            imageUrl: b.imageUrl ?? '', // default para evitar null
            rating: b.rating,
            onReserve: () => onTap?.call(b),
          );
        },
      ),
    );
  }
}
