import 'package:flutter/material.dart';
import '../models/barber.dart';
import 'barber_card.dart';

class BarberCarousel extends StatelessWidget {
  final List<Barber> barbers;
  final BarberCardVariant variant;
  final void Function(Barber)? onSelect;

  const BarberCarousel({
    super.key,
    required this.barbers,
    this.variant = BarberCardVariant.showcase,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: variant == BarberCardVariant.showcase ? 170 : 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: barbers.length,
        itemBuilder: (context, index) {
          final barber = barbers[index];
          final isFirst = index == 0;
          final isLast = index == barbers.length - 1;

          return Padding(
            padding: EdgeInsets.only(
              left: isFirst ? 16 : 0,
              right: isLast ? 16 : 8,
            ),
            child: BarberCard(
              name: barber.name,
              role: barber.role,
              imageUrl: barber.imageUrl,
              backgroundColor: barber.backgroundColor,
              variant: variant,
              onTap:
                  variant == BarberCardVariant.selectable && onSelect != null
                      ? () => onSelect!(barber)
                      : null,
            ),
          );
        },
      ),
    );
  }
}
