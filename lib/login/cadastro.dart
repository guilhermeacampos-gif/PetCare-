import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_care/services/auth_service.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  String? tipoUsuario;
  final emailController = TextEditingController();
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();
  final crmvController = TextEditingController();
  final clinicaController = TextEditingController();

  bool cadastrando = false;

  @override
  void dispose() {
    emailController.dispose();
    nomeController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    crmvController.dispose();
    clinicaController.dispose();
    super.dispose();
  }

  void mostrarMensagem(String mensagem, {required bool sucesso}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(mensagem),
          backgroundColor: sucesso ? Colors.green : Colors.red,
        ),
      );
  }

  bool validarCampos() {
    final email = emailController.text.trim().toLowerCase();
    final nome = nomeController.text.trim();
    final senha = senhaController.text;
    final confirmarSenha = confirmarSenhaController.text;

    if (tipoUsuario == null) {
      mostrarMensagem('Selecione Tutor ou Veterinário', sucesso: false);
      return false;
    }

    if (email.isEmpty ||
        nome.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty) {
      mostrarMensagem('Preencha todos os campos obrigatórios', sucesso: false);
      return false;
    }

    if (!email.endsWith('@souunit.com.br')) {
      mostrarMensagem('Use um e-mail @souunit.com.br', sucesso: false);
      return false;
    }

    if (senha.length < 6) {
      mostrarMensagem(
        'A senha deve ter pelo menos 6 caracteres',
        sucesso: false,
      );
      return false;
    }

    if (senha != confirmarSenha) {
      mostrarMensagem('A senha e a confirmação não coincidem', sucesso: false);
      return false;
    }

    if (tipoUsuario == 'Veterinário') {
      final crmv = crmvController.text.trim().toUpperCase();
      final formatoCrmv = RegExp(
        r'^(?:CRMV[-/\s]*)?(?:[A-Z]{2}[-/\s]*\d{4,6}|\d{4,6}[-/\s]*[A-Z]{2})$',
      );

      if (crmv.isEmpty) {
        mostrarMensagem('Informe o CRMV', sucesso: false);
        return false;
      }

      if (!formatoCrmv.hasMatch(crmv)) {
        mostrarMensagem(
          'CRMV inválido. Exemplo: CRMV-SP 12345',
          sucesso: false,
        );
        return false;
      }
    }

    return true;
  }

  Future<void> cadastrar() async {
    FocusScope.of(context).unfocus();

    if (cadastrando || !validarCampos()) return;

    setState(() {
      cadastrando = true;
    });

    final email = emailController.text.trim().toLowerCase();

    try {
      final erro = await AuthService.criarConta(email, senhaController.text);

      if (!mounted) return;

      if (erro != null) {
        mostrarMensagem(erro, sucesso: false);
        return;
      }

      final usuario = AuthService.usuarioLogado;

      if (usuario == null) {
        mostrarMensagem(
          'Não foi possível identificar o usuário criado',
          sucesso: false,
        );
        return;
      }

      final dadosUsuario = <String, dynamic>{
        'email': email,
        'nomeCompleto': nomeController.text.trim(),
        'tipoUsuario': tipoUsuario,
        'dataCriacao': FieldValue.serverTimestamp(),
      };

      if (tipoUsuario == 'Veterinário') {
        dadosUsuario['crmv'] = crmvController.text.trim().toUpperCase();

        final clinica = clinicaController.text.trim();
        if (clinica.isNotEmpty) {
          dadosUsuario['clinica'] = clinica;
        }
      }

      try {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(usuario.uid)
            .set(dadosUsuario);
      } catch (_) {
        await usuario.delete();
        rethrow;
      }

      if (!mounted) return;

      mostrarMensagem('Cadastro realizado com sucesso!', sucesso: true);
    } catch (_) {
      if (!mounted) return;

      mostrarMensagem(
        'Não foi possível concluir o cadastro. Tente novamente.',
        sucesso: false,
      );
    } finally {
      if (mounted) {
        setState(() {
          cadastrando = false;
        });
      }
    }
  }

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
            Expanded(child: SizedBox()),

            Expanded(
              flex: 2,

              child: Row(
                children: [
                  Image.asset('assets/images/logo.png', height: 50),

                  SizedBox(width: 10),

                  Text(
                    'PETCARE+',

                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
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
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 32),

          child: Column(
            children: [
              Text(
                "Criar Conta",

                style: TextStyle(
                  fontSize: 36,

                  fontWeight: FontWeight.bold,

                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "Crie uma conta para aproveitar o app",

                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),

              SizedBox(height: 28),

              campo(
                context,

                "Acesso",

                DropdownMenu<String>(
                  initialSelection: tipoUsuario,

                  hintText: "Selecione uma opção...",

                  width: double.infinity,

                  onSelected: (valor) {
                    setState(() {
                      tipoUsuario = valor;

                      if (valor != 'Veterinário') {
                        crmvController.clear();
                        clinicaController.clear();
                      }
                    });
                  },

                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "Tutor", label: "Tutor"),

                    DropdownMenuEntry(
                      value: "Veterinário",
                      label: "Veterinário",
                    ),
                  ],
                ),
              ),

              campo(
                context,

                "Email",

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    hintText: "Seu@email.com",
                  ),
                ),
              ),

              campo(
                context,

                "Nome Completo",

                TextField(
                  controller: nomeController,
                  textCapitalization: TextCapitalization.words,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    hintText: "Nome Completo",
                  ),
                ),
              ),

              campo(
                context,

                "Senha",

                TextField(
                  controller: senhaController,
                  obscureText: true,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    hintText: "Insira sua senha",
                  ),
                ),
              ),

              campo(
                context,

                "Confirmar senha",

                TextField(
                  controller: confirmarSenhaController,
                  obscureText: true,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    hintText: "Confirme sua senha",
                  ),
                ),
              ),

              if (tipoUsuario == "Veterinário") ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Text(
                          "Registro Profissional",

                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(width: 4),

                        Expanded(
                          child: Text(
                            "* Obrigatório para validação profissional",

                            style: TextStyle(color: Colors.red, fontSize: 10),

                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6),

                    TextField(
                      controller: crmvController,
                      textCapitalization: TextCapitalization.characters,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),

                        hintText: "CRMV",
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                campo(
                  context,

                  "Clínica",

                  TextField(
                    controller: clinicaController,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),

                      hintText: "Nome da Clínica (Opcional)",
                    ),
                  ),
                ),
              ],

              SizedBox(height: 18),

              SizedBox(
                width: double.infinity,

                height: 58,

                child: FilledButton(
                  onPressed: cadastrando ? null : cadastrar,

                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),

                  child: cadastrando
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          tipoUsuario == null
                              ? "Cadastrar"
                              : "Cadastrar como $tipoUsuario",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text("Já possui conta?"),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: Text("Faça o login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget campo(BuildContext context, String titulo, Widget widget) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            titulo,

            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,

              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 6),

          widget,
        ],
      ),
    );
  }
}
