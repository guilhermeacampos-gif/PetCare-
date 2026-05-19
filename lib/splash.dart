import 'package:flutter/material.dart';
import 'login.dart';
import 'historicopet.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double largura_tela = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Image.asset('images/logo.png', width: largura_tela * 0.8),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Historicopet()),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
