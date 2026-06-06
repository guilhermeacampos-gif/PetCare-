import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_care/login/login.dart';
import 'package:pet_care/login/redefinirsenha.dart';

class CodigoSenha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fator = screenWidth / 375;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        toolbarHeight: 96,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(8, 0, 0, 0),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
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
                fontSize: 12 * fator,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),

            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/confirmEmergency');
              },

              child: SizedBox(
                height: 50,

                child: SvgPicture.asset(
                  "assets/images/icones/emergency-white.svg",

                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary,

                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(24, 0, 24, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 6, child: SizedBox.shrink()),
            Text(
              "Alterar Senha",
              style: TextStyle(
                fontSize: 30 * fator,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Vamos lhe ajudar a alterar sua senha",
              style: TextStyle(
                fontSize: 12 * fator,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(flex: 4, child: SizedBox.shrink()),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.email,
                color: Theme.of(context).colorScheme.secondary,
                size: 70,
              ),
            ),
            Expanded(flex: 4, child: SizedBox.shrink()),
            Text(
              "Insira o código enviado para seu e-mail para prosseguir com a alteração.",
              style: TextStyle(
                fontSize: 12 * fator,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(flex: 2, child: SizedBox.shrink()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Código",
                  style: TextStyle(
                    fontSize: 12 * fator,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22 * fator,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22 * fator,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22 * fator,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22 * fator,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22 * fator,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22 * fator,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          counterText: "",
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                  ],
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RedefinirSenha()),
                  );
                },
                child: Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(0, 14, 0, 14),
                  child: Text(
                    'Enviar',
                    style: TextStyle(
                      fontSize: 18 * fator,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Lembrou da senha?",
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
                    "Faça o login",
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
