import 'package:flutter/material.dart';
import '../../models/service.dart';
import '../../widgets/service_card.dart';
import '../scheduling/schedule_flow_page.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 24),
        const Text(
          'Nossos Serviços',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Escolha o serviço desejado para agendar',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        ...demoServices.map(
          (service) => ServiceCard(
            service: service,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ScheduleFlowPage(service: service),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
