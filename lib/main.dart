import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/auth/login_page.dart';

void main() {
  runApp(const BellaSalaoApp());
}

class BellaSalaoApp extends StatelessWidget {
  const BellaSalaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bella Salão',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const LoginPage(),
    );
  }
}
