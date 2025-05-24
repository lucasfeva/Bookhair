import 'package:bookhair/components/input.dart';
import 'package:bookhair/data/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Olá, Lucas Ferreira',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: AppColors.slate500,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Rio Claro, SP',
                          style: TextStyle(color: AppColors.gray50),
                        ),
                      ],
                    ),
                  ],
                ),

                Builder(
                  builder:
                      (context) => Material(
                        color: Colors.transparent,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => Scaffold.of(context).openEndDrawer(),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.gray800,
                            ),
                            child: Image.asset(
                              'assets/icons/menu.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            CustomInput(
              hintText: 'Pesquisar',
              icon: Icons.search,
              actionIcon: Icons.map,
              type: InputType.search,
              onActionPressed: () {
                print('Mapa');
              },
            ),
          ],
        ),
      ),
    );
  }
}
