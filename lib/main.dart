import 'package:flutter/material.dart';
import 'splash.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF181166),
          primary: const Color(0xFF181166),
          secondary: const Color(0xFFEEEEEE),
        ),
        fontFamily: 'Quicksand',
      ),
      home: SplashScreen(),
    );
  }
}
