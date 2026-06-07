import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart';
import '../widgets/petcare_appbar.dart';
import '../widgets/bottom_nav.dart';
import 'agenda_screen.dart';
import 'documentos_screen.dart';

class CalendarioScreen extends StatefulWidget {
  final String tipoUsuario;
  CalendarioScreen({this.tipoUsuario = 'tutor'});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  DateTime mesAtual = DateTime(2026, 4, 1);
  DateTime? diaSelecionado = DateTime(2026, 4, 15);
  int paginaAtual = 1;

  List<String> meses = ['', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];
  List<String> diasSemana = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

  bool _mesmodia(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _estaAtrasado(DateTime d) {
    var hoje = DateTime.now();
    return d.isBefore(DateTime(hoje.year, hoje.month, hoje.day));
  }

  Color _corTipo(String tipo) {
    if (tipo == 'vacina') return AppColors.corVacina;
    if (tipo == 'consulta') return AppColors.corConsulta;
    if (tipo == 'remedio') return AppColors.corRemedio;
    return AppColors.roxoSecundario;
  }

  @override
  Widget build(BuildContext context) {
    double largura_tela = MediaQuery.of(context).size.width;
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    String email = FirebaseAuth.instance.currentUser?.email ?? '';

    return Scaffold(
      backgroundColor: AppColors.fundoCinza,
      appBar: PetCareAppBar(showBack: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .collection('eventos')
            .snapshots(),
        builder: (context, snapshot) {
          List<QueryDocumentSnapshot> todosEventos =
              snapshot.data?.docs ?? [];

          QueryDocumentSnapshot? evSelecionado;
          if (diaSelecionado != null) {
            for (var doc in todosEventos) {
              var d = doc.data() as Map<String, dynamic>;
              if (d['data'] != null) {
                Timestamp ts = d['data'];
                if (_mesmodia(ts.toDate(), diaSelecionado!)) {
                  evSelecionado = doc;
                  break;
                }
              }
            }
          }

          int diasNoMes =
              DateTime(mesAtual.year, mesAtual.month + 1, 0).day;
          int iniciaSemana =
              DateTime(mesAtual.year, mesAtual.month, 1).weekday % 7;
          List<Widget> celulas =
              List.generate(iniciaSemana, (_) => SizedBox());

          for (int d = 1; d <= diasNoMes; d++) {
            DateTime dataAtual =
                DateTime(mesAtual.year, mesAtual.month, d);
            bool ehHoje = _mesmodia(dataAtual, DateTime.now());
            bool selecionado = diaSelecionado != null &&
                _mesmodia(dataAtual, diaSelecionado!);
            bool atrasado = _estaAtrasado(dataAtual);

            QueryDocumentSnapshot? evDia;
            for (var doc in todosEventos) {
              var dados = doc.data() as Map<String, dynamic>;
              if (dados['data'] != null) {
                Timestamp ts = dados['data'];
                if (_mesmodia(ts.toDate(), dataAtual)) {
                  evDia = doc;
                  break;
                }
              }
            }

            Color? fundo;
            Color textoCor = Theme.of(context).colorScheme.primary;

            if (selecionado) {
              fundo = AppColors.roxoSecundario;
              textoCor = Colors.white;
            } else if (ehHoje) {
              fundo = AppColors.laranjaHoje;
              textoCor = Colors.white;
            } else if (evDia != null) {
              var dados = evDia.data() as Map<String, dynamic>;
              fundo = atrasado
                  ? AppColors.corAtrasado
                  : _corTipo(dados['tipo_evento'] ?? '');
              textoCor = Colors.white;
            }

            celulas.add(
              GestureDetector(
                onTap: () => setState(() => diaSelecionado = dataAtual),
                child: Container(
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: fundo, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(
                    '$d',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: fundo != null
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: textoCor,
                    ),
                  ),
                ),
              ),
            );
          }

          int resto = celulas.length % 7;
          if (resto != 0) {
            for (int i = 0; i < 7 - resto; i++) celulas.add(SizedBox());
          }

          bool diaAtrasado = diaSelecionado != null &&
              _estaAtrasado(diaSelecionado!);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        color: AppColors.fundoCinza,
                        padding: EdgeInsets.symmetric(
                            horizontal: largura_tela * 0.05),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Calendário de Cuidados',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.chevron_left,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                      size: 28),
                                  onPressed: () => setState(() => mesAtual =
                                      DateTime(mesAtual.year,
                                          mesAtual.month - 1, 1)),
                                ),
                                Text(
                                  '${meses[mesAtual.month]} ${mesAtual.year}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.chevron_right,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                      size: 28),
                                  onPressed: () => setState(() => mesAtual =
                                      DateTime(mesAtual.year,
                                          mesAtual.month + 1, 1)),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.06),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 12),
                                  Row(
                                    children: diasSemana
                                        .map((d) => Expanded(
                                              child: Center(
                                                child: Text(d,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors
                                                          .cinzaTexto,
                                                    )),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                  SizedBox(height: 4),
                                  GridView.count(
                                    crossAxisCount: 7,
                                    shrinkWrap: true,
                                    physics:
                                        NeverScrollableScrollPhysics(),
                                    childAspectRatio: 1,
                                    children: celulas,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: 40,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: AppColors.cinzaMedio,
                                      borderRadius:
                                          BorderRadius.circular(2),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: AppColors.corVacina,
                                        shape: BoxShape.circle)),
                                SizedBox(width: 5),
                                Text('Vacina',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                SizedBox(width: 16),
                                Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: AppColors.corConsulta,
                                        shape: BoxShape.circle)),
                                SizedBox(width: 5),
                                Text('Consulta',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                SizedBox(width: 16),
                                Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: AppColors.corRemedio,
                                        shape: BoxShape.circle)),
                                SizedBox(width: 5),
                                Text('Remédio',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: largura_tela * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 24),
                            if (diaSelecionado != null)
                              Text(
                                '${diaSelecionado!.day} ${meses[diaSelecionado!.month]} ${diaSelecionado!.year}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                ),
                              ),
                            SizedBox(height: 16),
                            if (evSelecionado == null &&
                                diaSelecionado != null)
                              Text(
                                'Nenhum evento neste dia',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.cinzaTexto),
                              ),
                            if (evSelecionado != null)
                              Builder(builder: (context) {
                                var dados = evSelecionado!.data()
                                    as Map<String, dynamic>;
                                return GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        title: Text('Excluir evento?'),
                                        content: Text(
                                            'Deseja remover "${dados['nome']}"?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text('Cancelar',
                                                style: TextStyle(
                                                    color: AppColors
                                                        .cinzaTexto)),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              FirebaseFirestore.instance
                                                  .collection('usuarios')
                                                  .doc(uid)
                                                  .collection('eventos')
                                                  .doc(evSelecionado!.id)
                                                  .delete();
                                            },
                                            child: Text('Excluir',
                                                style: TextStyle(
                                                  color: AppColors.corConsulta,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF0F0F8),
                                      borderRadius:
                                          BorderRadius.circular(16),
                                      border: diaAtrasado
                                          ? Border.all(
                                              color: AppColors.corAtrasado,
                                              width: 1.5)
                                          : null,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: diaAtrasado
                                                ? AppColors.corAtrasado
                                                : _corTipo(
                                                    dados['tipo_evento'] ??
                                                        ''),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 14),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  dados['nome'] ?? '',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                                if (diaAtrasado) ...[
                                                  SizedBox(width: 6),
                                                  Icon(
                                                      Icons
                                                          .warning_amber_rounded,
                                                      color: AppColors
                                                          .corAtrasado,
                                                      size: 16),
                                                ],
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              diaAtrasado
                                                  ? '⚠ Atrasado — era ${dados['hora']}'
                                                  : dados['hora'] ?? '',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: diaAtrasado
                                                    ? AppColors.corAtrasado
                                                    : AppColors.cinzaTexto,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsetsGeometry.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async {
                      final resultado =
                          await showModalBottomSheet<String>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>
                            NovoEventoSheet(uid: uid, email: email),
                      );
                      if (resultado != null && mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '$resultado registrado com sucesso!'),
                            backgroundColor: AppColors.corRemedio,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      '+ Novo Evento',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: PetCareBottomNav(
        currentIndex: paginaAtual,
        onTap: (index) {
          if (index == paginaAtual) return;
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AgendaScreen(tipoUsuario: widget.tipoUsuario)),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DocumentosScreen(tipoUsuario: widget.tipoUsuario)),
            );
          }
          setState(() => paginaAtual = index);
        },
      ),
    );
  }
}

class NovoEventoSheet extends StatefulWidget {
  final String uid;
  final String email;
  NovoEventoSheet({required this.uid, required this.email});

  @override
  State<NovoEventoSheet> createState() => _NovoEventoSheetState();
}

class _NovoEventoSheetState extends State<NovoEventoSheet> {
  TextEditingController campoNome = TextEditingController();
  TextEditingController campoObs = TextEditingController();
  DateTime dataSelecionada = DateTime.now();
  TimeOfDay horaSelecionada = TimeOfDay(hour: 9, minute: 0);
  String tipoEvento = 'vacina';
  bool salvando = false;

  @override
  void dispose() {
    campoNome.dispose();
    campoObs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double altura_tela = MediaQuery.of(context).size.height;

    OutlineInputBorder borda = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );

    return Container(
      height: altura_tela * 0.88,
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
            decoration: BoxDecoration(
              color: AppColors.cinzaMedio,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsetsGeometry.fromLTRB(24, 24, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nome do Evento',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary)),
                  SizedBox(height: 8),
                  TextField(
                    controller: campoNome,
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary),
                    decoration: InputDecoration(
                      hintText: 'Ex.: Vacina',
                      hintStyle: TextStyle(
                          fontSize: 14, color: AppColors.cinzaTexto),
                      filled: true,
                      fillColor: AppColors.fundoCinza,
                      border: borda,
                      enabledBorder: borda,
                      focusedBorder: borda,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Data',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () async {
                            DateTime? d = await showDatePicker(
                              context: context,
                              initialDate: dataSelecionada,
                              firstDate: DateTime(2025),
                              lastDate: DateTime(2028),
                            );
                            if (d != null)
                              setState(() => dataSelecionada = d);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: AppColors.fundoCinza,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${dataSelecionada.day.toString().padLeft(2, '0')}/${dataSelecionada.month.toString().padLeft(2, '0')}/${dataSelecionada.year}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () async {
                            TimeOfDay? t = await showTimePicker(
                                context: context,
                                initialTime: horaSelecionada);
                            if (t != null)
                              setState(() => horaSelecionada = t);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: AppColors.fundoCinza,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${horaSelecionada.hour.toString().padLeft(2, '0')}:${horaSelecionada.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Tipo',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary)),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: tipoEvento,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.fundoCinza,
                      border: borda,
                      enabledBorder: borda,
                      focusedBorder: borda,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: 'Quicksand'),
                    items: [
                      DropdownMenuItem(
                          value: 'vacina', child: Text('Vacina')),
                      DropdownMenuItem(
                          value: 'consulta', child: Text('Consulta')),
                      DropdownMenuItem(
                          value: 'remedio', child: Text('Remédio')),
                    ],
                    onChanged: (v) => setState(() => tipoEvento = v!),
                  ),
                  SizedBox(height: 20),
                  Text('Observações',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary)),
                  SizedBox(height: 8),
                  TextField(
                    controller: campoObs,
                    maxLines: 4,
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.fundoCinza,
                      border: borda,
                      enabledBorder: borda,
                      focusedBorder: borda,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(24, 0, 24, 24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: salvando
                    ? null
                    : () async {
                        if (campoNome.text.isEmpty) return;
                        setState(() => salvando = true);
                        await FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(widget.uid)
                            .collection('eventos')
                            .add({
                          'nome': campoNome.text.trim(),
                          'tipo_evento': tipoEvento,
                          'hora':
                              '${horaSelecionada.hour.toString().padLeft(2, '0')}:${horaSelecionada.minute.toString().padLeft(2, '0')}',
                          'data': Timestamp.fromDate(dataSelecionada),
                          'observacoes': campoObs.text.trim(),
                          'criado_por': widget.email,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        setState(() => salvando = false);
                        Navigator.of(context).pop(campoNome.text.trim());
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: salvando
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : Text('Salvar Evento',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
