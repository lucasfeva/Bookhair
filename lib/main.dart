import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/constants/colors.dart';
import 'core/api_client.dart';
import 'providers/auth_provider.dart';
import 'services/auth_service.dart';

import 'services/barbershop_service.dart';
import 'providers/barbershop_provider.dart';

import 'services/appointment_service.dart';
import 'services/service_service.dart';
import 'providers/appointment_provider.dart';

import 'screens/signin.dart';
import 'screens/signup.dart';
import 'screens/home.dart';

void main() {
  // Cria UMA instância única do ApiClient com o host completo
  final apiClient = ApiClient(baseUrl: 'http://bookhair.calcularnota.com.br');

  // Cria cada serviço usando exatamente a mesma instância
  final authService = AuthService(apiClient);
  final barbershopService = BarbershopService(apiClient);
  final appointmentService = AppointmentService(apiClient);
  final serviceService = ServiceService(apiClient);

  runApp(
    MultiProvider(
      providers: [
        // Expõe ApiClient para todo o app
        Provider<ApiClient>.value(value: apiClient),

        // Gerenciador de autenticação
        ChangeNotifierProvider(create: (_) => AuthProvider(authService)),

        // Gerenciador de barbearias (já carrega automaticamente)
        ChangeNotifierProvider(
          create: (_) => BarbershopProvider(barbershopService)..load(),
        ),

        // Gerenciador de agendamentos (recebe 3 serviços)
        ChangeNotifierProvider(
          create:
              (_) => AppointmentProvider(
                appointmentService,
                barbershopService,
                serviceService,
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookHair',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.slate500),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.slate500),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.slate500),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SignInScreen(),
        '/signup': (_) => const SignUpScreen(title: 'Crie sua conta'),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
