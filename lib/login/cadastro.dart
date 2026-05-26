import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  String? tipoUsuario;

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
                  Image.asset('images/logo.png', height: 50),

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
                    "images/icones/emergency-white.svg",

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
                  onPressed: () {},

                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),

                  child: Text(
                    "Cadastrar como Veterinário",

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
