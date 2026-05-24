import 'package:flutter/material.dart';
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
  int indiceNavAtual = 3;

  List<ItemDocumento> documentos = [
    ItemDocumento(nome: 'Receita_antibiotico(1).pdf', data: '15/04/2026'),
    ItemDocumento(nome: 'Receita_antibiotico.pdf', data: '12/04/2026'),
    ItemDocumento(nome: 'Exame_sangue.jpg', data: '10/04/2026'),
  ];

  void aoTrocarNav(int index) {
    if (index == indiceNavAtual) return;
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CalendarioScreen(tipoUsuario: widget.tipoUsuario)),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AgendaScreen(tipoUsuario: widget.tipoUsuario)),
      );
    }
    setState(() => indiceNavAtual = index);
  }

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: PetCareAppBar(showBack: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: larguraTela * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 28),
                  Text(
                    'Documentos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: corPrimaria),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Arquivos do pet',
                    style: TextStyle(fontSize: 13, color: AppColors.darkGrey),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: documentos.length,
                      separatorBuilder: (context, i) => SizedBox(height: 12),
                      itemBuilder: (context, i) => CardDocumento(doc: documentos[i]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: corPrimaria,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  '+ Upload',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: PetCareBottomNav(currentIndex: indiceNavAtual, onTap: aoTrocarNav),
    );
  }
}

class ItemDocumento {
  final String nome;
  final String data;
  ItemDocumento({required this.nome, required this.data});
}

class CardDocumento extends StatelessWidget {
  final ItemDocumento doc;
  CardDocumento({required this.doc});

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc.nome,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: corPrimaria),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6),
          Text(
            doc.data,
            style: TextStyle(fontSize: 13, color: AppColors.darkGrey),
          ),
        ],
      ),
    );
  }
}
