import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'splash.dart';
import 'emergency/confirm_emergency.dart';
import 'screens/busca_pets_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize(
    serverClientId: '1033030076476-a8q1ls9efhct8lbb9jp7stj6q8uvklil.apps.googleusercontent.com',
  );
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
