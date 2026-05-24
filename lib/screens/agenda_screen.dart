import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/petcare_appbar.dart';
import '../widgets/bottom_nav.dart';
import 'calendario_screen.dart';
import 'documentos_screen.dart';
import 'nova_atividade_screen.dart';

class AgendaScreen extends StatefulWidget {
  final String tipoUsuario;

  AgendaScreen({this.tipoUsuario = 'tutor'});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  int indiceNavAtual = 2;

  List<ItemAgenda> atividades = [
    ItemAgenda(nome: 'Dar remédio', tipo: 'Rotina', hora: '08:00', dataHora: DateTime(2026, 4, 15, 8, 0)),
    ItemAgenda(nome: 'Alimentar', tipo: 'Rotina', hora: '20:00', dataHora: DateTime.now().add(Duration(hours: 2))),
  ];

  void aoTrocarNav(int index) {
    if (index == indiceNavAtual) return;
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CalendarioScreen(tipoUsuario: widget.tipoUsuario)),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DocumentosScreen(tipoUsuario: widget.tipoUsuario)),
      );
    }
    setState(() => indiceNavAtual = index);
  }

  void removerAtividade(ItemAgenda item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Remover atividade?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary),
        ),
        content: Text(
          'Deseja remover "${item.nome}" da rotina?',
          style: TextStyle(fontSize: 14, color: AppColors.darkGrey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar', style: TextStyle(color: AppColors.darkGrey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => atividades.remove(item));
            },
            child: Text('Remover', style: TextStyle(color: AppColors.corConsulta, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
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
                    'Agenda Diária',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: corPrimaria),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Atividades do dia',
                    style: TextStyle(fontSize: 13, color: AppColors.darkGrey),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E8F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '15 Abril 2026',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: corPrimaria),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: atividades.isEmpty
                        ? Center(
                            child: Text(
                              'Nenhuma atividade cadastrada',
                              style: TextStyle(fontSize: 14, color: AppColors.darkGrey),
                            ),
                          )
                        : ListView.separated(
                            itemCount: atividades.length,
                            separatorBuilder: (context, i) => SizedBox(height: 12),
                            itemBuilder: (context, i) => CardAgenda(
                              item: atividades[i],
                              aoRemover: () => removerAtividade(atividades[i]),
                            ),
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
                onPressed: () async {
                  final resultado = await showModalBottomSheet<String>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => NovaAtividadeSheet(),
                  );
                  if (resultado != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$resultado adicionado com sucesso!'),
                        backgroundColor: AppColors.corRemedio,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: corPrimaria,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  '+ Nova Atividade',
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

class ItemAgenda {
  final String nome;
  final String tipo;
  final String hora;
  final DateTime dataHora;

  ItemAgenda({required this.nome, required this.tipo, required this.hora, required this.dataHora});

  bool get estaAtrasado => dataHora.isBefore(DateTime.now());
}

class CardAgenda extends StatelessWidget {
  final ItemAgenda item;
  final VoidCallback aoRemover;

  CardAgenda({required this.item, required this.aoRemover});

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: item.estaAtrasado ? Border.all(color: AppColors.corAtrasado, width: 1.5) : null,
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 14, 8, 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        item.nome,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: corPrimaria),
                      ),
                      if (item.estaAtrasado) ...[
                        SizedBox(width: 6),
                        Icon(Icons.warning_amber_rounded, color: AppColors.corAtrasado, size: 16),
                      ],
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(item.tipo, style: TextStyle(fontSize: 13, color: AppColors.darkGrey)),
                  SizedBox(height: 2),
                  Text(
                    item.estaAtrasado ? '⚠ Atrasado — era ${item.hora}' : item.hora,
                    style: TextStyle(
                      fontSize: 13,
                      color: item.estaAtrasado ? AppColors.corAtrasado : AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: AppColors.darkGrey, size: 20),
              onPressed: aoRemover,
            ),
          ],
        ),
      ),
    );
  }
}
