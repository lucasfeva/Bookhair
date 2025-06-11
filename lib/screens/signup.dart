import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform, SocketException;
import 'dart:async';
import 'dart:html' as html;
import 'home.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  bool _showPassword = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  String _formatPhoneNumber(String phone) {
    // Remove todos os caracteres não numéricos
    String numbers = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    // Formata o número para o padrão (99) 99999-9999
    if (numbers.length == 11) {
      return '(${numbers.substring(0, 2)}) ${numbers.substring(2, 7)}-${numbers.substring(7)}';
    }
    return phone;
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Define a URL base dependendo da plataforma
    final baseUrl = _getBaseUrl();
    print('Tentando conectar em: $baseUrl/api/v1/auth/register');

    try {
      // Remove caracteres especiais do telefone para enviar apenas números
      final phoneNumbers = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
      print('Dados do formulário:');
      print('Nome: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Telefone: $phoneNumbers');
      print('Endereço: ${_addressController.text}');

      // Mostrar feedback de tentativa de conexão
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tentando conectar ao servidor...'),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.blue,
          ),
        );
      }

      print('Enviando requisição...');
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/auth/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'nome': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
          'password_confirmation': _confirmPasswordController.text,
          'telefone': phoneNumbers,
          'endereco': _addressController.text.trim(),
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('Timeout na requisição');
          throw TimeoutException('A conexão com o servidor demorou muito tempo.');
        },
      );

      print('Resposta recebida: ${response.statusCode}');
      print('Corpo da resposta: ${response.body}');

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        if (!mounted) return;
        
        print('Cadastro realizado com sucesso!');
        // Mostrar diálogo de sucesso
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sucesso!'),
              content: const Text('Cadastro realizado com sucesso!'),
              icon: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha o diálogo
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        String errorMessage = 'Erro ao realizar cadastro';
        if (responseData['message'] != null) {
          errorMessage = responseData['message'];
        }
        print('Erro no cadastro: $errorMessage');
        throw Exception(errorMessage);
      }
    } on TimeoutException catch (e) {
      print('Erro de timeout: $e');
      _showError('O servidor demorou muito para responder. Tente novamente.');
    } on SocketException catch (e) {
      print('Erro de socket: $e');
      _showError('Não foi possível conectar ao servidor. Verifique sua conexão com a internet.');
    } on http.ClientException catch (e) {
      print('Erro de cliente HTTP: $e');
      _showError('Erro de conexão. Verifique se o servidor está rodando.');
    } catch (e) {
      print('Erro não tratado: $e');
      _showError(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getBaseUrl() {
    try {
      // Tenta detectar se está rodando na web
      if (html.window.location.hostname == 'localhost' || 
          html.window.location.hostname == '127.0.0.1') {
        return 'http://localhost:8000';
      }
      // Se não estiver na web, tenta detectar Android
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:8000';
      }
    } catch (e) {
      // Se der erro ao acessar Platform, assume que está na web
      return 'http://localhost:8000';
    }
    // Fallback para localhost
    return 'http://localhost:8000';
  }

  void _showError(String message) {
    print('Mostrando erro: $message');
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade100,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Informe seu nome' : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu e-mail';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                    hintText: '(99) 99999-9999',
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    if (value.length == 11) {
                      _phoneController.text = _formatPhoneNumber(value);
                      _phoneController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _phoneController.text.length),
                      );
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu telefone';
                    }
                    // Remove todos os caracteres não numéricos para validação
                    String numbers = value.replaceAll(RegExp(r'[^\d]'), '');
                    if (numbers.length != 11) {
                      return 'Telefone deve ter 11 dígitos';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                    hintText: 'Rua, número, bairro, cidade',
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu endereço';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() => _showPassword = !_showPassword),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe sua senha';
                    }
                    if (value.length < 6) {
                      return 'Mínimo 6 caracteres';
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'Deve conter letra maiúscula';
                    }
                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Deve conter número';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_showPassword,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirme sua senha';
                    }
                    if (value != _passwordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                  child: const Text(
                    'Já possui conta? Faça login!',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}