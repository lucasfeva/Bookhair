import 'package:bookhair/components/button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              text: 'Primario',
              variant: ButtonVariant.primary,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            Button(
              text: 'Outline',
              variant: ButtonVariant.outline,
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            Button(
              text: '',
              variant: ButtonVariant.ghost,
              icon: Icons.message_outlined,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
