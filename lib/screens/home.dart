import 'package:bookhair/components/appointment_card.dart';
import 'package:bookhair/components/barbershop_carousel.dart';
import 'package:bookhair/components/button.dart';
import 'package:bookhair/components/input.dart';
import 'package:bookhair/components/service_item.dart';
import 'package:bookhair/models/barbershop.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(height: 12),
              CustomInput(
                hintText: 'Pesquisar',
                icon: Icons.search,
                actionIcon: Icons.map,
                type: InputType.search,
                onActionPressed: () {
                  print('Mapa');
                },
              ),
              const SizedBox(height: 12),
              CustomInput(
                label: 'Usuário',
                hintText: 'E-mail',
                icon: Icons.mail_outline,
              ),
              const SizedBox(height: 12),
              CustomInput(
                label: 'Senha',
                hintText: 'Senha',
                icon: Icons.vpn_key_outlined,
                type: InputType.password,
              ),
              const SizedBox(height: 24),
              BarbershopCarousel(
                barbershops: [
                  Barbershop(
                    name: 'Vintage Barber',
                    address: 'Av. São Sebastião, 357...',
                    imageUrl: 'https://link-da-imagem.jpg',
                    rating: 4.8,
                  ),
                  Barbershop(
                    name: 'Vintage Barber',
                    address: 'Av. São Sebastião, 357...',
                    imageUrl: 'https://link-da-imagem.jpg',
                    rating: 4.8,
                  ),
                  Barbershop(
                    name: 'Vintage Barber',
                    address: 'Av. São Sebastião, 357...',
                    imageUrl: 'https://link-da-imagem.jpg',
                    rating: 4.8,
                  ),
                  Barbershop(
                    name: 'Vintage Barber',
                    address: 'Av. São Sebastião, 357...',
                    imageUrl: 'https://link-da-imagem.jpg',
                    rating: 4.8,
                  ),
                  Barbershop(
                    name: 'Vintage Barber',
                    address: 'Av. São Sebastião, 357...',
                    imageUrl: 'https://link-da-imagem.jpg',
                    rating: 4.8,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppointmentCard(
                dateTime: DateTime(2025, 2, 22, 10, 0),
                status: 'Concluído',
                barbershopName: 'Barbearia exemplo',
                address: '105 Av. 10a, Centro Rio Claro - SP',
                services: 'Corte de cabelo + Barba',
                imageUrl: 'https://link-da-imagem.jpg',
              ),
              const SizedBox(height: 12),
              AppointmentCard(
                dateTime: DateTime(2025, 2, 22, 10, 0),
                status: 'Cancelado',
                barbershopName: 'Barbearia exemplo',
                address: '105 Av. 10a, Centro Rio Claro - SP',
                services: 'Corte de cabelo + Barba',
                imageUrl: 'https://link-da-imagem.jpg',
              ),
              const SizedBox(height: 12),
              AppointmentCard(
                dateTime: DateTime(2025, 2, 22, 10, 0),
                status: 'Confirmado',
                barbershopName: 'Barbearia exemplo',
                address: '105 Av. 10a, Centro Rio Claro - SP',
                services: 'Corte de cabelo + Barba',
                imageUrl: 'https://link-da-imagem.jpg',
              ),
              const SizedBox(height: 12),
              AppointmentCard(
                dateTime: DateTime(2025, 4, 03, 18, 30),
                status: 'Confirmado',
                barbershopName: 'Barbearia exemplo',
                address: '105 Av. 10a, Centro Rio Claro - SP',
                services: 'Corte de cabelo + Barba',
                imageUrl: 'https://link-da-imagem.jpg',
                showActions: true, // ESSENCIAL
                onCancel: () => print('Cancelar agendamento'),
                onMessage: () => print('Abrir chat'),
              ),
              const SizedBox(height: 12),
              Column(
                children: const [
                  ServiceItem(name: 'Cabelo', price: 'R\$ 30,00'),
                  ServiceItem(name: 'Cabelo + Barba', price: 'R\$ 45,00'),
                  ServiceItem(name: 'Barba', price: 'R\$ 15,00'),
                  ServiceItem(name: 'Alisamento masculino', price: 'R\$ 60,00'),
                  ServiceItem(name: 'Raspado', price: 'R\$ 15,00'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
