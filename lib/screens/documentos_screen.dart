import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart';
import '../widgets/petcare_appbar.dart';
import '../widgets/bottom_nav.dart';
import 'agenda_screen.dart';
import 'calendario_screen.dart';

class DocumentosScreen extends StatefulWidget {
  final String tipoUsuario;
  DocumentosScreen({this.tipoUsuario = 'tutor'});

  @override
  State<DocumentosScreen> createState() => _DocumentosScreenState();
}

class _DocumentosScreenState extends State<DocumentosScreen> {
  int paginaAtual = 3;

  @override
  Widget build(BuildContext context) {
    double largura_tela = MediaQuery.of(context).size.width;
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    String email = FirebaseAuth.instance.currentUser?.email ?? '';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 28),
                  Text(
                    'Documentos',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Arquivos do pet',
                    style: TextStyle(
                        fontSize: 13, color: AppColors.cinzaTexto),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('usuarios')
                          .doc(uid)
                          .collection('documentos')
                          .orderBy('timestamp', descending: true)
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
                              'Nenhum documento',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.cinzaTexto),
                            ),
                          );
                        }
                        return ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          separatorBuilder: (context, i) =>
                              SizedBox(height: 12),
                          itemBuilder: (context, i) {
                            var doc = snapshot.data!.docs[i];
                            var dados =
                                doc.data() as Map<String, dynamic>;
                            return GestureDetector(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    title: Text('Remover documento?'),
                                    content: Text(
                                        'Deseja remover "${dados['nome']}"?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text('Cancelar',
                                            style: TextStyle(
                                                color:
                                                    AppColors.cinzaTexto)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          FirebaseFirestore.instance
                                              .collection('usuarios')
                                              .doc(uid)
                                              .collection('documentos')
                                              .doc(doc.id)
                                              .delete();
                                        },
                                        child: Text('Remover',
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
                                padding: EdgeInsetsGeometry.fromLTRB(
                                    16, 18, 16, 18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Color.fromRGBO(0, 0, 0, 0.06),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dados['nome'] ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      dados['data_upload'] ?? '',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.cinzaTexto),
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
                  await FirebaseFirestore.instance
                      .collection('usuarios')
                      .doc(uid)
                      .collection('documentos')
                      .add({
                    'nome':
                        'Documento_${DateTime.now().millisecondsSinceEpoch}.pdf',
                    'data_upload':
                        '${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}',
                    'criado_por': email,
                    'timestamp': FieldValue.serverTimestamp(),
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  '+ Upload',
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
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AgendaScreen(tipoUsuario: widget.tipoUsuario)),
            );
          }
          setState(() => paginaAtual = index);
        },
      ),
    );
  }
}
