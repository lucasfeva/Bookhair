import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: services.map((service) {
          return Column(
            children: [
              Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEF3F8), 
                      shape: BoxShape.circle,
                      
                    ),
                    child: Image.asset(
                      service['icon']!,
                      width: 24,
                      height: 24,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                service['label']!,
                style: const TextStyle(color: Colors.black87, fontSize: 12),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
