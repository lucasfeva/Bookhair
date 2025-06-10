import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/agendar_servico.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/constants/colors.dart';
import 'core/api_client.dart';
import 'providers/auth_provider.dart';
import 'services/auth_service.dart';
import 'services/barbershop_service.dart';
import 'providers/barbershop_provider.dart';
import 'screens/signin.dart';
import 'screens/signup.dart';
import 'screens/home.dart';

void main() {
  final apiClient = ApiClient(baseUrl: 'http://bookhair.calcularnota.com.br');
  final authService = AuthService(apiClient);
  final barbershopService = BarbershopService(apiClient);

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),

        ChangeNotifierProvider(create: (_) => AuthProvider(authService)),

        ChangeNotifierProvider(
          create: (_) => BarbershopProvider(barbershopService)..load(),
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
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
        dialogTheme: DialogThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SignInScreen(),
        '/signup': (_) => const SignUpScreen(title: 'Crie sua conta'),
        '/home': (_) => const HomeScreen(),
        '/agendar': (_) => AgendarServicoScreen(),
      },
    );
  }
}
