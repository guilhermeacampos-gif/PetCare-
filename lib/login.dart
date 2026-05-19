import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('images/logo.png', height: 30, fit: BoxFit.contain),
            SizedBox(width: 10),
            Text(
              'PETCARE+',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              )
            )
          ]
        )
      ),
      body: Center(
        child: Column (
          children: [
            Text("Login"),
            Text("Acesse sua conta com seu e-mail e senha"),
            Column(),
            Column(),
            Column(),
            Row(),
            SizedBox(),
            TextButton(onPressed: () {}, child: Text('Login')),
            Row(
              children: [
                Text("Não tem conta?"),
                Text("Cadastre-se")
              ]
            )
          ],
        )
      ),
    );
  }
}
