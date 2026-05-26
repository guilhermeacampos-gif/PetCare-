import 'package:flutter/material.dart';
import 'splash.dart';
import 'emergency/confirm_emergency.dart';
import 'screens/busca_pets_screen.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare+',

      debugShowCheckedModeBanner: false,

      routes: {
        '/confirmEmergency': (context) => ConfirmEmergencyPage(),

        '/buscaPets': (context) => BuscaPetsScreen(),
      },

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF181166),
          primary: const Color(0xFF181166),
          secondary: const Color(0xFFEEEEEE),
          tertiary: const Color(0xFF3F36A7),
        ),

        fontFamily: 'Quicksand',
      ),

      home: SplashScreen(),
    );
  }
}
