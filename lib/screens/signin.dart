import 'package:bookhair/components/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:bookhair/data/constants/colors.dart';
import '../components/button.dart';
import '../core/api_client.dart';
import '../services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final AuthService _authService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(ApiClient(baseUrl: 'http://10.0.2.2:8000'));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      _showError('Preencha email e senha.');
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.login(email: email, password: password);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _showError('Falha ao autenticar: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Erro'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final statusBar = MediaQuery.of(context).padding.top;
    final headerHeight = size.height * 0.35 + statusBar;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Gradiente no topo com o título
          Container(
            width: double.infinity,
            height: headerHeight,
            padding: EdgeInsets.only(top: statusBar),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.slate700, AppColors.slate500],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'BookHair',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Cartão branco sobreposto
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bem Vindo',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Por favor, insira suas informações de login abaixo para acessar sua conta',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.gray700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomInput(
                        controller: _emailController,
                        label: 'Usuário',
                        hintText: 'E-mail',
                        icon: Icons.email,
                        type: InputType.text,
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        controller: _passwordController,
                        label: 'Senha',
                        hintText: 'Senha',
                        icon: Icons.key,
                        type: InputType.password,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Esqueceu a senha?'),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Button(
                        text: _isLoading ? 'Entrando...' : 'Login',
                        onPressed: _isLoading ? null : _onSignIn,
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Não tem uma conta? ',
                            style: const TextStyle(color: AppColors.gray700),
                            children: [
                              TextSpan(
                                text: 'Registre-se',
                                style: const TextStyle(
                                  color: AppColors.slate600,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () => Navigator.pushNamed(
                                            context,
                                            '/signup',
                                          ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
