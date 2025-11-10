import 'package:flutter/material.dart';
import 'colors.dart';
import 'screens/splash.dart';
import 'screens/login.dart';
import 'screens/signup.dart';


void main() {
runApp(const AgendaAiApp());
}


class AgendaAiApp extends StatelessWidget {
const AgendaAiApp({super.key});


@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'AgendaAí',
debugShowCheckedModeBanner: false,
theme: ThemeData(
primaryColor: AppColors.lightPurple,
scaffoldBackgroundColor: AppColors.bg,
inputDecorationTheme: InputDecorationTheme(
filled: true,
fillColor: Colors.white,
contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
borderSide: BorderSide.none,
),
),
elevatedButtonTheme: ElevatedButtonThemeData(
style: ElevatedButton.styleFrom(
backgroundColor: AppColors.lightPurple,
foregroundColor: Colors.white,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
),
),
),
routes: {
'/': (context) => const SplashScreen(),
'/login': (context) => const LoginPage(),
'/signup': (context) => const SignUpPage(),
},
initialRoute: '/',
);
}
}