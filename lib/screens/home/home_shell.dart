import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/segmented_tabs.dart';
import '../appointments/appointments_page.dart';
import '../home/services_page.dart';
import '../auth/login_page.dart';


class HomeShell extends StatefulWidget {
  final int initialTab;

  const HomeShell({super.key, this.initialTab = 0});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late int tabIndex;

  @override
  void initState() {
    super.initState();
    tabIndex = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    final body = tabIndex == 0
        ? const ServicesPage()
        : const AppointmentsPage();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.content_cut,
                        color: AppColors.primary),
                    const SizedBox(width: 6),
                    const Text(
                      'Bella Salão',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('Olá,',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight)),
                        Text(
                          'Visitante',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.logout, size: 16),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const LoginPage()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SegmentedTabs(
                  tabs: const ['Serviços', 'Agendamentos'],
                  selectedIndex: tabIndex,
                  onChanged: (i) => setState(() => tabIndex = i),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: body,
      ),
    );
  }
}
