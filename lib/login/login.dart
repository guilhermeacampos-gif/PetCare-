import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_care/login/alterarsenha.dart';
import 'package:pet_care/emergency/confirm_emergency.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fator = screenWidth / 375;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        toolbarHeight: 96,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 50,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Text(
              'PETCARE+',
              style: TextStyle(
                fontSize: 14 * fator,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfirmEmergencyPage()),
              );
            },
            icon: SvgPicture.asset(
              "assets/images/icones/emergency-white.svg",
              height: 40,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(24, 0, 24, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 6, child: SizedBox.shrink()),
            Text(
              "Login",
              style: TextStyle(
                fontSize: 32 * fator,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Acesse sua conta com seu e-mail e senha",
              style: TextStyle(
                fontSize: 12 * fator,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Acesso",
                  style: TextStyle(
                    fontSize: 12 * fator,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                DropdownMenu(
                  hintText: "Selecione uma opção...",
                  width: double.infinity,
                  menuStyle: MenuStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 24),
                    ),
                  ),
                  trailingIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  selectedTrailingIcon: Icon(
                    Icons.keyboard_arrow_up,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "tutor", label: "Tutor"),
                    DropdownMenuEntry(
                      value: "veterinário",
                      label: "Veterinário",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 12 * fator,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Seu@email.com',
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Senha",
                  style: TextStyle(
                    fontSize: 12 * fator,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Insira sua senha',
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Esqueceu sua senha?",
                  style: TextStyle(
                    fontSize: 12 * fator,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlterarSenha()),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsetsGeometry.fromLTRB(4, 0, 0, 0),
                  ),
                  child: Text(
                    "Redefina a senha",
                    style: TextStyle(
                      fontSize: 12 * fator,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(flex: 6, child: SizedBox.shrink()),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(0, 14, 0, 14),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18 * fator,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Não tem conta?",
                  style: TextStyle(
                    fontSize: 12 * fator,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsetsGeometry.fromLTRB(4, 0, 0, 0),
                  ),
                  child: Text(
                    "Cadastre-se",
                    style: TextStyle(
                      fontSize: 12 * fator,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(flex: 6, child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
