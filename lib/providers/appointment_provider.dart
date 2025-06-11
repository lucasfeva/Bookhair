import 'package:flutter/foundation.dart';
import '../models/appointment_detail.dart';
import '../services/appointment_service.dart';
import '../services/barbershop_service.dart';
import '../services/service_service.dart';

class AppointmentProvider extends ChangeNotifier {
  final AppointmentService _apptSrv;
  final BarbershopService _barbSrv;
  final ServiceService _svcSrv;

  List<AppointmentDetail> _details = [];
  bool loading = false;
  String? error;

  AppointmentProvider(this._apptSrv, this._barbSrv, this._svcSrv);

  /// Retorna o próximo (ou null, se não houver)
  AppointmentDetail? get nextAppointment =>
      _details.isNotEmpty ? _details.first : null;

  Future<void> loadHistory(int clienteId) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final history = await _apptSrv.fetchHistory(clienteId);
      // Só futuros, ordenados
      final futuros =
          history.where((a) => a.dateHora.isAfter(DateTime.now())).toList()
            ..sort((a, b) => a.dateHora.compareTo(b.dateHora));

      if (futuros.isNotEmpty) {
        final appt = futuros.first;
        // Busca barbearia e serviço
        final barb = await _barbSrv.fetchById(appt.barbeariaId);
        final svc = await _svcSrv.fetchById(appt.servicoId);
        _details = [
          AppointmentDetail(base: appt, barbershop: barb, service: svc),
        ];
      } else {
        _details = [];
      }
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
