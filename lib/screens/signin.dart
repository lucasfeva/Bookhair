import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B749D), // Fundo azul degradê
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'BookHair',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Cadastre-se',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Preencha seus dados para criar uma conta',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),

                        _buildTextField(Icons.person, 'Nome Completo'),
                        _buildTextField(Icons.credit_card, 'CPF'),
                        _buildTextField(Icons.cake, 'Data de Nascimento'),
                        _buildTextField(Icons.home, 'Endereço'),
                        _buildTextField(Icons.phone, 'Telefone'),

                        const SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () {
                            // Ação ao cadastrar
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4B749D),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Cadastrar',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Já tem uma conta? '),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context); // Volta para o login
                              },
                              child: const Text(
                                'Entrar',
                                style: TextStyle(
                                  color: Color(0xFF4B749D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
    );
  }

  Widget _buildTextField(IconData icon, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
