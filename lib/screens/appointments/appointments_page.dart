import 'package:flutter/material.dart';
import '../../models/appointment.dart';
import '../../models/appointment_repository.dart';
import '../../theme.dart';
import '../../widgets/gradient_button.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    final repo = AppointmentRepository.instance;
    final upcoming = repo.upcoming;
    final canceled = repo.canceled;

    return ListView(
      children: [
        const SizedBox(height: 24),
        if (upcoming.isNotEmpty) ...[
          const Text(
            'Próximos agendamentos',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          ...upcoming.map((a) => _appointmentCard(a)),
          const SizedBox(height: 24),
        ],
        if (canceled.isNotEmpty) ...[
          const Text(
            'Cancelados',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          ...canceled.map((a) => _appointmentCard(a, canceled: true)),
        ],
        if (upcoming.isEmpty && canceled.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Você ainda não possui agendamentos.',
                style: TextStyle(color: AppColors.textLight),
              ),
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _appointmentCard(Appointment a, {bool canceled = false}) {
    final date = a.dateTime;
    final dateText =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    final timeText =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            a.service.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: canceled
                      ? AppColors.canceled.withOpacity(0.1)
                      : AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      canceled ? Icons.cancel : Icons.check_circle,
                      size: 14,
                      color:
                          canceled ? AppColors.canceled : AppColors.success,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      canceled ? 'Cancelado' : 'Confirmado',
                      style: TextStyle(
                        fontSize: 12,
                        color: canceled
                            ? AppColors.canceled
                            : AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 4),
              Text('$dateText às $timeText'),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16),
              const SizedBox(width: 4),
              Text('${a.duration.inMinutes} min'),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16),
              const SizedBox(width: 4),
              Text(a.clientName),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.phone, size: 16),
              const SizedBox(width: 4),
              Text(a.phone),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.attach_money, size: 16),
              const SizedBox(width: 4),
              Text('R\$ ${a.service.price.toStringAsFixed(0)}'),
            ],
          ),
          if (!canceled) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    AppointmentRepository.instance.cancel(a);
                  });
                },
                child: const Text('Cancelar agendamento'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
