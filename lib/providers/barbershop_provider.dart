import 'package:flutter/foundation.dart';
import '../models/barbershop.dart';
import '../services/barbershop_service.dart';

class BarbershopProvider extends ChangeNotifier {
  final BarbershopService _service;

  List<Barbershop> barbershops = [];
  bool loading = false;
  String? error;

  BarbershopProvider(this._service);

  Future<void> load({String query = ''}) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      barbershops = await _service.fetchAll(query: query);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
