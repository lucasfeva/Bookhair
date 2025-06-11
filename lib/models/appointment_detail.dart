import 'appointment.dart';
import 'barbershop.dart';
import 'service.dart';

class AppointmentDetail {
  final Appointment base;
  final Barbershop barbershop;
  final Service service;

  AppointmentDetail({
    required this.base,
    required this.barbershop,
    required this.service,
  });

  DateTime get dateTime => base.dateHora;
  String get status => base.status;

  String get barbershopName => barbershop.name;
  String get address => barbershop.address;
  String get imageUrl => barbershop.imageUrl ?? '';

  String get servicesLabel => service.name;
}
