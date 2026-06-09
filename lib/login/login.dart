import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:flutter/foundation.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:pet_care/login/alterarsenha.dart";
import "package:pet_care/emergency/confirm_emergency.dart";
import "package:pet_care/login/cadastro.dart";
import "package:pet_care/meuscuidados.dart";

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
              "assets/images/logo.png",
              height: 50,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Text(
              "PETCARE+",
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
          SizedBox(width: 12),
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
                          DropdownMenu<String>(
                            initialSelection: selectedRole,
                            onSelected: (String? value) {
                              setState(() {
                                selectedRole = value;
                              });
                            },
                            hintText: "Selecione uma opção...",
                            width: double.infinity,
                            inputDecorationTheme: InputDecorationTheme(
                              isDense: true,
                              contentPadding: EdgeInsetsGeometry.fromLTRB(
                                12,
                                12,
                                12,
                                12,
                              ),
                              border: OutlineInputBorder(),
                            ),
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
                              isDense: true,
                              contentPadding: EdgeInsetsGeometry.fromLTRB(
                                12,
                                12,
                                12,
                                12,
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Seu@email.com",
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
                              isDense: true,
                              contentPadding: EdgeInsetsGeometry.fromLTRB(
                                12,
                                12,
                                12,
                                12,
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Insira sua senha",
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
                                MaterialPageRoute(
                                  builder: (context) => AlterarSenha(),
                                ),
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
                            if (selectedRole == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Selecione um tipo de acesso"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text,
                                  );

                              String? email = userCredential.user?.email;
                              if (email == null ||
                                  !email.endsWith('@souunit.com.br')) {
                                await FirebaseAuth.instance.signOut();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Email não pertence à instituição",
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                                return;
                              }

                              await FirebaseFirestore.instance
                                  .collection('usuarios')
                                  .doc(userCredential.user!.uid)
                                  .set({
                                    'role': selectedRole,
                                    'email': userCredential.user!.email,
                                    'criado_por': userCredential.user!.email,
                                  }, SetOptions(merge: true));

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Usuário conectado"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MeusCuidados(),
                                    ),
                                  );
                                });
                              }
                            } on FirebaseAuthException catch (e) {
                              if (context.mounted) {
                                String msg;
                                if (e.code == "user-not-found") {
                                  msg = "Usuário não encontrado";
                                } else if (e.code == "wrong-password") {
                                  msg = "Senha incorreta";
                                } else if (e.code == "invalid-email") {
                                  msg = "E-mail inválido";
                                } else if (e.code == "too-many-requests") {
                                  msg =
                                      "Muitas tentativas. Tente novamente mais tarde";
                                } else if (e.code == "invalid-credential") {
                                  msg = "E-mail ou senha incorretos";
                                } else if (e.code == "channel-error") {
                                  msg = "Erro de conexão com a internet";
                                } else {
                                  msg = "Erro ao fazer login";
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(msg),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("$e"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding: EdgeInsetsGeometry.fromLTRB(0, 12, 0, 12),
                            child: Text(
                              "Login",
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
                                MaterialPageRoute(
                                  builder: (context) => CadastroPage(),
                                ),
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
                      Expanded(flex: 1, child: SizedBox.shrink()),
                      Text("OU"),
                      Expanded(flex: 1, child: SizedBox.shrink()),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (selectedRole == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Selecione um tipo de acesso"),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          try {
                            UserCredential userCredential;
                            if (kIsWeb) {
                              GoogleAuthProvider googleProvider =
                                  GoogleAuthProvider();
                              userCredential = await FirebaseAuth.instance
                                  .signInWithPopup(googleProvider);
                            } else {
                              GoogleSignInAccount googleUser =
                                  await GoogleSignIn.instance.authenticate();

                              GoogleSignInAuthentication googleAuth =
                                  googleUser.authentication;
                              OAuthCredential credential =
                                  GoogleAuthProvider.credential(
                                    idToken: googleAuth.idToken,
                                  );

                              userCredential = await FirebaseAuth.instance
                                  .signInWithCredential(credential);
                            }

                            String? email = userCredential.user?.email;
                            if (email == null ||
                                !email.endsWith('@souunit.com.br')) {
                              await FirebaseAuth.instance.signOut();
                              if (!kIsWeb) {
                                await GoogleSignIn.instance.signOut();
                              }
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Email não pertence à instituição",
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              return;
                            }

                            await FirebaseFirestore.instance
                                .collection('usuarios')
                                .doc(userCredential.user!.uid)
                                .set({
                                  'role': selectedRole,
                                  'email': userCredential.user!.email,
                                  'criado_por': userCredential.user!.email,
                                }, SetOptions(merge: true));

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Usuário conectado"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MeusCuidados(),
                                  ),
                                );
                              });
                            }
                          } on FirebaseAuthException catch (e) {
                            print(e);
                            if (context.mounted) {
                              String msg;
                              if (e.code ==
                                  "account-exists-with-different-credential") {
                                msg = "Conta já existe com outra credencial";
                              } else if (e.code == "invalid-credential") {
                                msg = "Credencial inválida";
                              } else {
                                msg = "Erro ao fazer login com Google";
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(msg),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } catch (e) {
                            print(e);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("$e"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        icon: SvgPicture.asset(
                          "assets/images/icones/google.svg",
                          height: 24,
                        ),
                        label: Text(
                          "Login com Google",
                          style: TextStyle(
                            fontSize: 12 * fator,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
