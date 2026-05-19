import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        toolbarHeight: 96,
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
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(24, 0, 24, 0),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Acesse sua conta com seu e-mail e senha"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Acesso"),
                TextField(
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Selecione uma opção...',
                ),
                )
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email"),
                TextField(
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Seu@email.com',
                ),
                )
              ],
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Senha"),
                TextField(
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Insira sua senha'
                ),
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Esqueceu sua senha?", style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Redefina a senha",
                    style:TextStyle(fontWeight: FontWeight.bold)
                  )
                )
              ]),
            SizedBox(height: 34),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)
                  ),
                ),
                onPressed: () {},
                child: Text('Login')
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Não tem conta?", style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: Text("Cadastre-se", style: TextStyle(fontWeight: FontWeight.bold)))
              ]
            )
          ],
        ),
      ),
    );
  }
}
