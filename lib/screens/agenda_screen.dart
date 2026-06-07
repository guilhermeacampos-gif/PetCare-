import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart';
import '../widgets/petcare_appbar.dart';
import '../widgets/bottom_nav.dart';
import 'calendario_screen.dart';
import 'documentos_screen.dart';

class AgendaScreen extends StatefulWidget {
  final String tipoUsuario;
  AgendaScreen({this.tipoUsuario = 'tutor'});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  int paginaAtual = 2;

  @override
  Widget build(BuildContext context) {
    double largura_tela = MediaQuery.of(context).size.width;
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      backgroundColor: AppColors.fundoCinza,
      appBar: PetCareAppBar(showBack: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: largura_tela * 0.05),
              child: Column(
                children: [
                  SizedBox(height: 28),
                  Text(
                    'Agenda Diária',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Atividades do dia',
                    style: TextStyle(fontSize: 13, color: AppColors.cinzaTexto),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsetsGeometry.fromLTRB(16, 14, 16, 14),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E8F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '15 Abril 2026',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('usuarios')
                          .doc(uid)
                          .collection('atividades')
                          .orderBy('timestamp')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData ||
                            snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              'Nenhuma atividade cadastrada',
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.cinzaTexto),
                            ),
                          );
                        }
                        return ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          separatorBuilder: (context, i) =>
                              SizedBox(height: 12),
                          itemBuilder: (context, i) {
                            var doc = snapshot.data!.docs[i];
                            var dados = doc.data() as Map<String, dynamic>;
                            bool atrasado = false;
                            if (dados['timestamp'] != null) {
                              Timestamp ts = dados['timestamp'];
                              atrasado =
                                  ts.toDate().isBefore(DateTime.now());
                            }
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: atrasado
                                    ? Border.all(
                                        color: AppColors.corAtrasado,
                                        width: 1.5)
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.06),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsGeometry.fromLTRB(16, 14, 8, 14),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                dados['nome'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              if (atrasado) ...[
                                                SizedBox(width: 6),
                                                Icon(
                                                    Icons
                                                        .warning_amber_rounded,
                                                    color:
                                                        AppColors.corAtrasado,
                                                    size: 16),
                                              ],
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(dados['tipo'] ?? '',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color:
                                                      AppColors.cinzaTexto)),
                                          SizedBox(height: 2),
                                          Text(
                                            atrasado
                                                ? '⚠ Atrasado — era ${dados['hora']}'
                                                : dados['hora'] ?? '',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: atrasado
                                                  ? AppColors.corAtrasado
                                                  : AppColors.cinzaTexto,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete_outline,
                                          color: AppColors.cinzaTexto,
                                          size: 20),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            title: Text('Remover atividade?'),
                                            content: Text(
                                                'Deseja remover "${dados['nome']}"?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(),
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
                                                      .collection('atividades')
                                                      .doc(doc.id)
                                                      .delete();
                                                },
                                                child: Text('Remover',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.corConsulta,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(16, 8, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () async {
                  final resultado = await showModalBottomSheet<String>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => NovaAtividadeSheet(),
                  );
                  if (resultado != null && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$resultado adicionado com sucesso!'),
                        backgroundColor: AppColors.corRemedio,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  '+ Nova Atividade',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: PetCareBottomNav(
        currentIndex: paginaAtual,
        onTap: (index) {
          if (index == paginaAtual) return;
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CalendarioScreen(tipoUsuario: widget.tipoUsuario)),
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

class NovaAtividadeSheet extends StatefulWidget {
  @override
  State<NovaAtividadeSheet> createState() => _NovaAtividadeSheetState();
}

class _NovaAtividadeSheetState extends State<NovaAtividadeSheet> {
  TextEditingController campoAtividade = TextEditingController();
  TextEditingController campoTipo = TextEditingController();
  TextEditingController campoObs = TextEditingController();
  TimeOfDay horaSelecionada = TimeOfDay(hour: 9, minute: 0);
  bool repete = true;
  bool salvando = false;

  @override
  void dispose() {
    campoAtividade.dispose();
    campoTipo.dispose();
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
                  Text(
                    'Atividade',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: campoAtividade,
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary),
                    decoration: InputDecoration(
                      hintText: 'Ex.: Alimentar animal',
                      hintStyle:
                          TextStyle(fontSize: 14, color: AppColors.cinzaTexto),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hora',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                TimeOfDay? t = await showTimePicker(
                                    context: context,
                                    initialTime: horaSelecionada);
                                if (t != null)
                                  setState(() => horaSelecionada = t);
                              },
                              child: Container(
                                width: double.infinity,
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
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tipo',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: campoTipo,
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.primary),
                              decoration: InputDecoration(
                                hintText: 'Tipo',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.cinzaTexto),
                                filled: true,
                                fillColor: AppColors.fundoCinza,
                                border: borda,
                                enabledBorder: borda,
                                focusedBorder: borda,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Observações',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
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
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Repete?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Switch(
                        value: repete,
                        onChanged: (v) => setState(() => repete = v),
                        thumbColor: WidgetStateProperty.all(Colors.white),
                        trackColor: WidgetStateProperty.resolveWith((s) =>
                            s.contains(WidgetState.selected)
                                ? AppColors.roxoSecundario
                                : AppColors.cinzaMedio),
                        trackOutlineColor:
                            WidgetStateProperty.all(Colors.transparent),
                      ),
                    ],
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
                        if (campoAtividade.text.isEmpty) return;
                        setState(() => salvando = true);
                        String uid = FirebaseAuth
                                .instance.currentUser?.uid ??
                            '';
                        String email = FirebaseAuth
                                .instance.currentUser?.email ??
                            '';
                        await FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(uid)
                            .collection('atividades')
                            .add({
                          'nome': campoAtividade.text.trim(),
                          'tipo': campoTipo.text.trim().isEmpty
                              ? 'Rotina'
                              : campoTipo.text.trim(),
                          'hora':
                              '${horaSelecionada.hour.toString().padLeft(2, '0')}:${horaSelecionada.minute.toString().padLeft(2, '0')}',
                          'repete': repete,
                          'observacoes': campoObs.text.trim(),
                          'criado_por': email,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        setState(() => salvando = false);
                        Navigator.of(context).pop(campoAtividade.text.trim());
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
                    : Text(
                        'Salvar Atividade',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
