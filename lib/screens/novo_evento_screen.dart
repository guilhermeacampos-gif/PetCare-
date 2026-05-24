import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NovoEventoSheet extends StatefulWidget {
  @override
  State<NovoEventoSheet> createState() => _NovoEventoSheetState();
}

class _NovoEventoSheetState extends State<NovoEventoSheet> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerTipo = TextEditingController();
  TextEditingController controllerObservacoes = TextEditingController();
  DateTime dataSelecionada = DateTime(2026, 4, 15);
  TimeOfDay horaSelecionada = TimeOfDay(hour: 9, minute: 0);

  @override
  void dispose() {
    controllerNome.dispose();
    controllerTipo.dispose();
    controllerObservacoes.dispose();
    super.dispose();
  }

  Future<void> escolherData() async {
    DateTime? escolhida = await showDatePicker(
      context: context,
      initialDate: dataSelecionada,
      firstDate: DateTime(2025),
      lastDate: DateTime(2028),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).colorScheme.primary,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (escolhida != null) setState(() => dataSelecionada = escolhida);
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

  String formatarData(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

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
                  Text('Nome do Evento', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: corPrimaria)),
                  SizedBox(height: 8),
                  TextField(
                    controller: controllerNome,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: corPrimaria),
                    decoration: decoracao(hint: 'Ex.: Vacina'),
                  ),
                  SizedBox(height: 20),
                  Text('Data', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: corPrimaria)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: escolherData,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              formatarData(dataSelecionada),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: corPrimaria),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: escolherHora,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              formatarHora(horaSelecionada),
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: corPrimaria),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Tipo', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: corPrimaria)),
                  SizedBox(height: 8),
                  TextField(
                    controller: controllerTipo,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: corPrimaria),
                    decoration: decoracao(hint: 'Consulta / Vacina'),
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
                  String nome = controllerNome.text.isNotEmpty
                      ? controllerNome.text
                      : controllerTipo.text.isNotEmpty
                          ? controllerTipo.text
                          : 'Evento';
                  Navigator.of(context).pop(nome);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: corPrimaria,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Salvar Evento',
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
