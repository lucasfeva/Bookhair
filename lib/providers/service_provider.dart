import 'package:flutter/foundation.dart';
import '../models/service.dart';
import '../services/service_service.dart';

class ServiceProvider extends ChangeNotifier {
  final ServiceService _service;
  List<Service> items = [];
  bool loading = false;
  String? error;

  ServiceProvider(this._service);

  Future<void> load(int barbershopId) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      items = await _service.fetchByBarbershop(barbershopId);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
