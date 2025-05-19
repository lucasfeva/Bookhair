import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

/// Gerencia o estado de autenticação: user, loading e error.
class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  User? user;
  bool loading = false;
  String? error;

  AuthProvider(this._authService);

  /// Faz login e atualiza [user], [loading] e [error].
  Future<void> signIn(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      final result = await _authService.login(email: email, password: password);
      user = result['user'] as User;
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
