import 'package:flutter/material.dart';
import '../colors.dart';


class SplashScreen extends StatefulWidget {
const SplashScreen({super.key});


@override
State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
super.initState();
Future.delayed(const Duration(milliseconds: 2000), () {
if (mounted) Navigator.of(context).pushReplacementNamed('/login');
});
}


@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: AppColors.lightPurple,
body: Center(
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Container(
padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 28),
decoration: BoxDecoration(
color: Colors.white.withOpacity(0.12),
borderRadius: BorderRadius.circular(18),
),
child: const Text(
'AgendaAí',
style: TextStyle(
color: Colors.white,
fontSize: 36,
fontWeight: FontWeight.bold,
letterSpacing: 0.6,
),
),
),
const SizedBox(height: 18),
const Text(
'Seu salão, seu agendamento',
style: TextStyle(color: Colors.white70, fontSize: 14),
),
],
),
),
);
}
}