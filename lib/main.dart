import 'package:bookhair/screens/home.dart';
import 'package:bookhair/screens/signin.dart';
import 'package:bookhair/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/api_client.dart';
import 'services/auth_service.dart';
import 'providers/auth_provider.dart';

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
      initialRoute: '/',
      routes: {
        '/': (_) => const SignInScreen(),
        '/signup': (_) => const SignUpScreen(title: 'Crie sua conta'),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
