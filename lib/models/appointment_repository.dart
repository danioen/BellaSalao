import 'appointment.dart';

class AppointmentRepository {
  AppointmentRepository._();
  static final instance = AppointmentRepository._();

  final List<Appointment> _items = [];

  List<Appointment> get upcoming {
    final now = DateTime.now();
    final list = _items
        .where((a) =>
            a.status == AppointmentStatus.confirmed &&
            a.dateTime.isAfter(now.subtract(a.duration)))
        .toList();
    list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return list;
  }

  List<Appointment> get canceled {
    final list = _items
        .where((a) => a.status == AppointmentStatus.canceled)
        .toList();
    list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return list;
  }

  void add(Appointment appointment) {
    _items.add(appointment);
  }

  void cancel(Appointment appointment) {
    appointment.status = AppointmentStatus.canceled;
  }
}
