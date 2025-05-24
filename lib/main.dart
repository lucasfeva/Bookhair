import 'package:bookhair/data/constants/colors.dart';
import 'package:bookhair/screens/home.dart';
import 'package:bookhair/screens/signin.dart';
import 'package:bookhair/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/api_client.dart';
import 'providers/auth_provider.dart';
import 'services/auth_service.dart';

void main() {
  final apiClient = ApiClient(baseUrl: 'http://10.0.2.2:8000');
  final authService = AuthService(apiClient);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(authService),
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
        dialogTheme: DialogTheme(
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
      },
    );
  }
}
