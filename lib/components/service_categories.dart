import 'package:flutter/material.dart';
import 'package:bookhair/components/button.dart';

class ServiceCategories extends StatelessWidget {
  const ServiceCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'icon': 'assets/icons/hair.png', 'label': 'Cabelo'},
      {'icon': 'assets/icons/beard.png', 'label': 'Barba'},
      {'icon': 'assets/icons/eyebrow.png', 'label': 'Sobrancelha'},
      {'icon': 'assets/icons/chemistry.png', 'label': 'Química'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            services.map((service) {
              return Button(
                variant: ButtonVariant.ghost,
                onPressed: () {
                  // TODO: filtrar pelo serviço
                },
                assetIcon: service['icon'] as String,
                text: '',
                iconSize: 32,
              );
            }).toList(),
      ),
    );
  }
}
