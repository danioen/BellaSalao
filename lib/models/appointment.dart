import 'service.dart';

enum AppointmentStatus { confirmed, canceled }

class Appointment {
  final Service service;
  final DateTime dateTime;
  final Duration duration;
  final String clientName;
  final String phone;
  AppointmentStatus status;

  Appointment({
    required this.service,
    required this.dateTime,
    required this.duration,
    required this.clientName,
    required this.phone,
    this.status = AppointmentStatus.confirmed,
  });
}
