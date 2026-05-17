import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double largura_tela = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Image(
          image: AssetImage('images/logo.png'),
          width: largura_tela * 0.8,
        ),
      ),
    );
  }
}
