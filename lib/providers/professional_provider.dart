import 'package:flutter/foundation.dart';
import '../models/professional.dart';
import '../services/professional_service.dart';

class ProfessionalProvider extends ChangeNotifier {
  final ProfessionalService _service;

  List<Professional> professionals = [];
  bool loading = false;
  String? error;

  ProfessionalProvider(this._service);

  Future<void> load(int barbeariaId) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      professionals = await _service.fetchByBarbershop(barbeariaId);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
