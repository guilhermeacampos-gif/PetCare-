import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AlterarSenha extends StatefulWidget {
  @override
  _AlterarSenhaState createState() => _AlterarSenhaState();
}

class _AlterarSenhaState extends State<AlterarSenha> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fator = screenWidth / 375;

    return Scaffold(
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
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
                      Text(
                        "Insira o e-mail associado à sua conta.\nSe o e-mail corresponder com um cadastrado em nosso sistema, enviaremos um link para que possa fazer a alteração de senha.",
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
                            "Email",
                            style: TextStyle(
                              fontSize: 12 * fator,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Seu@email.com',
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
                            String email = emailController.text.trim();
                            if (email.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Por favor, insira o seu e-mail')),
                              );
                              return;
                            }
                            if (!email.endsWith('@souunit.com.br')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Erro: O e-mail não pertence a instituição',
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 5),
                                ),
                              );
                              return;
                            }
                            try {
                              await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: email,
                              );
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Link de redefinição de senha enviado para o e-mail',
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 5),
                                  ),
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              String msg = '';
                              if (e.code == 'user-not-found') {
                                msg = 'Nenhum usuário encontrado para esse e-mail';
                              } else if (e.code == 'invalid-email') {
                                msg = 'O e-mail fornecido é inválido';
                              } else {
                                msg = 'Ocorreu um erro ao enviar o link';
                              }
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(msg),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 5),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Ocorreu um erro inesperado'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 5),
                                  ),
                                );
                              }
                            }
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
                            onPressed: () => Navigator.of(context).pop(),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
