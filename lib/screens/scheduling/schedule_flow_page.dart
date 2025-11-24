import 'package:flutter/material.dart';
import '../../models/appointment.dart';
import '../../models/appointment_repository.dart';
import '../../models/service.dart';
import '../../theme.dart';
import '../../widgets/gradient_button.dart';
import '../home/home_shell.dart';
import 'package:flutter/services.dart';


class ScheduleFlowPage extends StatefulWidget {
  final Service service;

  const ScheduleFlowPage({super.key, required this.service});

  @override
  State<ScheduleFlowPage> createState() => _ScheduleFlowPageState();
}

class _ScheduleFlowPageState extends State<ScheduleFlowPage> {
  int step = 0;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  final List<TimeOfDay> availableTimes = const [
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 9, minute: 30),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 10, minute: 30),
    TimeOfDay(hour: 11, minute: 0),
    TimeOfDay(hour: 11, minute: 30),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 12, minute: 30),
    TimeOfDay(hour: 13, minute: 0),
    TimeOfDay(hour: 13, minute: 30),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 14, minute: 30),
    TimeOfDay(hour: 15, minute: 0),
    TimeOfDay(hour: 15, minute: 30),
    TimeOfDay(hour: 16, minute: 0),
    TimeOfDay(hour: 16, minute: 30),
    TimeOfDay(hour: 17, minute: 0),
    TimeOfDay(hour: 17, minute: 30),
    TimeOfDay(hour: 18, minute: 0),
  ];

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (step < 3) {
      setState(() => step++);
    }
  }

  void _confirm() {
    if (selectedDate == null || selectedTime == null) return;

    final dateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    final appointment = Appointment(
      service: widget.service,
      dateTime: dateTime,
      duration: Duration(minutes: widget.service.durationMinutes),
      clientName: nameCtrl.text.isEmpty ? 'Cliente' : nameCtrl.text,
      phone: phoneCtrl.text,
    );

    AppointmentRepository.instance.add(appointment);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const HomeShell(initialTab: 1),
      ),
      (route) => false,
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: List.generate(4, (index) {
        final active = index <= step;
        return Expanded(
          child: Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: active ? AppColors.primary : Colors.grey.shade300,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Agendar ${service.name}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, size: 18),
                  const SizedBox(width: 4),
                  Text('${service.durationMinutes} min'),
                  const SizedBox(width: 16),
                  const Icon(Icons.attach_money, size: 18),
                  const SizedBox(width: 2),
                  Text('R\$ ${service.price.toStringAsFixed(0)}'),
                ],
              ),
            ),
            _buildStepIndicator(),
            const SizedBox(height: 16),
            Expanded(child: _buildStepContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (step) {
      case 0:
        return _buildDateStep();
      case 1:
        return _buildTimeStep();
      case 2:
        return _buildClientStep();
      case 3:
      default:
        return _buildConfirmStep();
    }
  }

  Widget _buildDateStep() {
    final now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escolha a data',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: CalendarDatePicker(
            firstDate: now,
            lastDate: DateTime(now.year + 1),
            initialDate: selectedDate ?? now,
            onDateChanged: (date) {
              setState(() => selectedDate = date);
            },
          ),
        ),
        GradientButton(
          text: 'Continuar',
          onPressed: selectedDate == null ? () {} : _next,
          enabled: selectedDate != null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTimeStep() {
    if (selectedDate == null) {
      // proteção caso usuário avance sem data
      selectedDate = DateTime.now();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escolha o horário',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_weekdayName(selectedDate!)} '
          '${selectedDate!.day.toString().padLeft(2, '0')} '
          'de ${_monthName(selectedDate!)}',
          style: const TextStyle(color: AppColors.textLight),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: availableTimes.map((time) {
                final selected = time == selectedTime;
                final label =
                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedTime = time);
                  },
                  child: Container(
                    width: 90,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          selected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        GradientButton(
          text: 'Continuar',
          onPressed: selectedTime == null ? () {} : _next,
          enabled: selectedTime != null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildClientStep() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Seus dados',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 16),

      // -------------------------
      // CAMPO NOME COMPLETO
      // -------------------------
      const Text('Nome completo'),
      const SizedBox(height: 6),
      TextField(
        controller: nameCtrl,
        keyboardType: TextInputType.name, // ✔ teclado de nome
        decoration: const InputDecoration(
          hintText: 'Digite seu nome',
        ),
      ),

      const SizedBox(height: 16),
      const Text('Telefone'),
      const SizedBox(height: 6),
      TextField(
        controller: phoneCtrl,
        keyboardType: TextInputType.number, 
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, 
          _PhoneInputFormatter(),                 
        ],
        decoration: const InputDecoration(
          hintText: '(00) 00000-0000',
        ),
      ),

      const Spacer(),
      GradientButton(
        text: 'Continuar',
        onPressed: _next,
      ),
      const SizedBox(height: 16),
    ],
  );
}

  Widget _buildConfirmStep() {
    final service = widget.service;
    final date = selectedDate!;
    final time = selectedTime!;

    final dateText =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    final timeText =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Confirmar agendamento',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _row('Serviço', service.name),
              _row('Data', dateText),
              _row('Horário', timeText),
              _row('Duração', '${service.durationMinutes} min'),
              _row('Cliente', nameCtrl.text.isEmpty ? 'Cliente' : nameCtrl.text),
              _row('Telefone', phoneCtrl.text),
              _row('Total', 'R\$ ${service.price.toStringAsFixed(0)}'),
            ],
          ),
        ),
        const Spacer(),
        GradientButton(
          text: 'Confirmar Agendamento',
          onPressed: _confirm,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textLight),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _weekdayName(DateTime date) {
    const names = [
      'domingo',
      'segunda-feira',
      'terça-feira',
      'quarta-feira',
      'quinta-feira',
      'sexta-feira',
      'sábado',
    ];
    return names[date.weekday % 7];
  }

  String _monthName(DateTime date) {
    const names = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];
    return names[date.month - 1];
  }
}

class _PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Mantém apenas números
    var digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limite de 11 dígitos (DDD + 9 números)
    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    var formatted = '';

    if (digits.isNotEmpty) {
      // DDD
      formatted = '(${digits.substring(0, 2)}';
    }
    if (digits.length >= 3) {
      // espaço depois do DDD + começo do número
      formatted += ') ${digits.substring(2, digits.length.clamp(3, 7))}';
    }
    if (digits.length >= 8) {
      // parte final com traço
      formatted =
          '(${digits.substring(0, 2)}) ${digits.substring(2, 7)}-${digits.substring(7)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}