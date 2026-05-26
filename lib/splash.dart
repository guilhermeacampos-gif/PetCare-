import 'package:flutter/material.dart';
import '/login/login.dart';
import 'historicopet.dart';
import 'meuscuidados.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double largura_tela = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Image.asset('images/logo.png', width: largura_tela * 0.8),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeusCuidados()),
              );
            },
            child: Icon(Icons.alarm),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Icon(Icons.login),
          ),
        ],
      ),
    );
  }
}
