import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NovaAtividadeSheet extends StatefulWidget {
  @override
  State<NovaAtividadeSheet> createState() => _NovaAtividadeSheetState();
}

class _NovaAtividadeSheetState extends State<NovaAtividadeSheet> {
  TextEditingController controllerAtividade = TextEditingController();
  TextEditingController controllerTipo = TextEditingController();
  TextEditingController controllerObservacoes = TextEditingController();
  TimeOfDay horaSelecionada = TimeOfDay(hour: 9, minute: 0);
  bool repete = true;

  @override
  void dispose() {
    controllerAtividade.dispose();
    controllerTipo.dispose();
    controllerObservacoes.dispose();
    super.dispose();
  }

  Future<void> escolherHora() async {
    TimeOfDay? escolhida = await showTimePicker(
      context: context,
      initialTime: horaSelecionada,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: Theme.of(context).colorScheme.primary),
        ),
        child: child!,
      ),
    );
    if (escolhida != null) setState(() => horaSelecionada = escolhida);
  }

  String formatarHora(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;
    double alturaTela = MediaQuery.of(context).size.height;

    OutlineInputBorder borda = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );

    InputDecoration decoracao({String hint = ''}) => InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14, color: AppColors.darkGrey),
          filled: true,
          fillColor: AppColors.lightGrey,
          border: borda,
          enabledBorder: borda,
          focusedBorder: borda,
          disabledBorder: borda,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        );

    return Container(
      height: alturaTela * 0.88,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(2)),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Atividade', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: corPrimaria)),
                  SizedBox(height: 8),
                  TextField(
                    controller: controllerAtividade,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: corPrimaria),
                    decoration: decoracao(hint: 'Ex.: Alimentar animal'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hora', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: corPrimaria)),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: escolherHora,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  formatarHora(horaSelecionada),
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: corPrimaria),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tipo', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: corPrimaria)),
                            SizedBox(height: 8),
                            TextField(
                              controller: controllerTipo,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: corPrimaria),
                              decoration: decoracao(hint: 'Tipo'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Observações', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: corPrimaria)),
                  SizedBox(height: 8),
                  TextField(
                    controller: controllerObservacoes,
                    maxLines: 4,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: corPrimaria),
                    decoration: decoracao(),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Repete?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: corPrimaria)),
                      Switch(
                        value: repete,
                        onChanged: (valor) => setState(() => repete = valor),
                        thumbColor: WidgetStateProperty.all(Colors.white),
                        trackColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) return AppColors.corSecundaria;
                          return AppColors.grey;
                        }),
                        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  String nome = controllerAtividade.text.isNotEmpty ? controllerAtividade.text : 'Atividade';
                  Navigator.of(context).pop(nome);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: corPrimaria,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Salvar Atividade',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
