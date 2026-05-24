import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/petcare_appbar.dart';
import '../widgets/bottom_nav.dart';
import 'agenda_screen.dart';
import 'documentos_screen.dart';
import 'novo_evento_screen.dart';

class CalendarioScreen extends StatefulWidget {
  final String tipoUsuario;
  CalendarioScreen({this.tipoUsuario = 'tutor'});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  DateTime mesAtual = DateTime(2026, 4, 1);
  DateTime? diaSelecionado = DateTime(2026, 4, 15);
  int indiceNavAtual = 1;

  final List<String> _meses = [
    '', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];
  final List<String> _diasSemana = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

  late Map<DateTime, EventoCalendario> eventosMap;

  @override
  void initState() {
    super.initState();
    eventosMap = {
      DateTime(2026, 4, 1): EventoCalendario('Vacina', AppColors.corVacina, '09:00'),
      DateTime(2026, 4, 15): EventoCalendario('Vacina', AppColors.corVacina, '09:00'),
      DateTime(2026, 4, 19): EventoCalendario('Remédio', AppColors.corRemedio, '08:00'),
      DateTime(2026, 4, 23): EventoCalendario('Remédio', AppColors.corRemedio, '08:00'),
    };
  }

  bool _mesmodia(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  EventoCalendario? _buscarEvento(DateTime dia) =>
      eventosMap[DateTime(dia.year, dia.month, dia.day)];

  bool _estaAtrasado(DateTime dia) {
    DateTime hoje = DateTime.now();
    return dia.isBefore(DateTime(hoje.year, hoje.month, hoje.day));
  }

  void _mesAnterior() =>
      setState(() => mesAtual = DateTime(mesAtual.year, mesAtual.month - 1, 1));

  void _proximoMes() =>
      setState(() => mesAtual = DateTime(mesAtual.year, mesAtual.month + 1, 1));

  String _formatarData(DateTime dia) =>
      '${dia.day} ${_meses[dia.month]} ${dia.year}';

  void _removerEvento(DateTime dia) =>
      setState(() => eventosMap.remove(DateTime(dia.year, dia.month, dia.day)));

  void aoTrocarNav(int index) {
    if (index == indiceNavAtual) return;
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AgendaScreen(tipoUsuario: widget.tipoUsuario)),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DocumentosScreen(tipoUsuario: widget.tipoUsuario)),
      );
    }
    setState(() => indiceNavAtual = index);
  }

  Widget _buildCelula(BuildContext context, DateTime data) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;
    bool ehHoje = _mesmodia(data, DateTime.now());
    bool ehSelecionado = diaSelecionado != null && _mesmodia(data, diaSelecionado!);
    EventoCalendario? evento = _buscarEvento(data);
    bool temEvento = evento != null;
    bool atrasado = temEvento && _estaAtrasado(data);

    Color? corFundo;
    Color corTexto = corPrimaria;

    if (ehSelecionado) {
      corFundo = AppColors.corSecundaria;
      corTexto = Colors.white;
    } else if (ehHoje) {
      corFundo = AppColors.todayOrange;
      corTexto = Colors.white;
    } else if (temEvento) {
      corFundo = atrasado ? AppColors.corAtrasado : evento!.cor;
      corTexto = Colors.white;
    }

    return GestureDetector(
      onTap: () => setState(() => diaSelecionado = data),
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(color: corFundo, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          '${data.day}',
          style: TextStyle(
            fontSize: 13,
            fontWeight: corFundo != null ? FontWeight.w700 : FontWeight.w500,
            color: corTexto,
          ),
        ),
      ),
    );
  }

  Widget _buildGradeCalendario(BuildContext context) {
    int diasNoMes = DateTime(mesAtual.year, mesAtual.month + 1, 0).day;
    int iniciaSemana = DateTime(mesAtual.year, mesAtual.month, 1).weekday % 7;

    List<Widget> celulas = List.generate(iniciaSemana, (_) => SizedBox());
    for (int d = 1; d <= diasNoMes; d++) {
      celulas.add(_buildCelula(context, DateTime(mesAtual.year, mesAtual.month, d)));
    }
    int resto = celulas.length % 7;
    if (resto != 0) {
      for (int i = 0; i < 7 - resto; i++) celulas.add(SizedBox());
    }

    return Column(
      children: [
        SizedBox(height: 12),
        Row(
          children: _diasSemana
              .map((d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 4),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 1,
          children: celulas,
        ),
        SizedBox(height: 8),
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;
    double larguraTela = MediaQuery.of(context).size.width;
    double pad = larguraTela * 0.05;

    EventoCalendario? eventoDoDia =
        diaSelecionado != null ? _buscarEvento(diaSelecionado!) : null;
    bool diaAtrasado = diaSelecionado != null && _estaAtrasado(diaSelecionado!);

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: PetCareAppBar(showBack: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: AppColors.lightGrey,
                    padding: EdgeInsets.symmetric(horizontal: pad),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Calendário de Cuidados',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: corPrimaria,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.chevron_left, color: corPrimaria, size: 28),
                              onPressed: _mesAnterior,
                            ),
                            Text(
                              '${_meses[mesAtual.month]} ${mesAtual.year}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: corPrimaria,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right, color: corPrimaria, size: 28),
                              onPressed: _proximoMes,
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
                          child: _buildGradeCalendario(context),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _ItemLegenda(cor: AppColors.corVacina, rotulo: 'Vacina'),
                            SizedBox(width: 16),
                            _ItemLegenda(cor: AppColors.corConsulta, rotulo: 'Consulta'),
                            SizedBox(width: 16),
                            _ItemLegenda(cor: AppColors.corRemedio, rotulo: 'Remédio'),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: pad),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 24),
                        if (diaSelecionado != null)
                          Text(
                            _formatarData(diaSelecionado!),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: corPrimaria,
                            ),
                          ),
                        SizedBox(height: 16),
                        if (eventoDoDia == null && diaSelecionado != null)
                          Text(
                            'Nenhum evento neste dia',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: AppColors.darkGrey),
                          ),
                        if (eventoDoDia != null)
                          _CardEvento(
                            evento: eventoDoDia,
                            atrasado: diaAtrasado,
                            aoExcluir: () => _confirmarExclusao(context, eventoDoDia),
                          ),
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
                    builder: (context) => NovoEventoSheet(),
                  );
                  if (resultado != null && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$resultado registrado com sucesso!'),
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
                  '+ Novo Evento',
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

  void _confirmarExclusao(BuildContext context, EventoCalendario evento) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Excluir evento?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: corPrimaria),
        ),
        content: Text(
          'Deseja remover "${evento.nome}"?',
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
              _removerEvento(diaSelecionado!);
            },
            child: Text(
              'Excluir',
              style: TextStyle(color: AppColors.corConsulta, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class EventoCalendario {
  final String nome;
  final Color cor;
  final String hora;
  EventoCalendario(this.nome, this.cor, this.hora);
}

class _CardEvento extends StatelessWidget {
  final EventoCalendario evento;
  final bool atrasado;
  final VoidCallback aoExcluir;

  _CardEvento({required this.evento, required this.atrasado, required this.aoExcluir});

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onLongPress: aoExcluir,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Color(0xFFF0F0F8),
          borderRadius: BorderRadius.circular(16),
          border: atrasado ? Border.all(color: AppColors.corAtrasado, width: 1.5) : null,
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: atrasado ? AppColors.corAtrasado : evento.cor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        evento.nome,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: corPrimaria),
                      ),
                      if (atrasado) ...[
                        SizedBox(width: 6),
                        Icon(Icons.warning_amber_rounded, color: AppColors.corAtrasado, size: 16),
                      ],
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    atrasado ? '⚠ Atrasado — era ${evento.hora}' : evento.hora,
                    style: TextStyle(
                      fontSize: 13,
                      color: atrasado ? AppColors.corAtrasado : AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemLegenda extends StatelessWidget {
  final Color cor;
  final String rotulo;
  _ItemLegenda({required this.cor, required this.rotulo});

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: cor, shape: BoxShape.circle)),
        SizedBox(width: 5),
        Text(rotulo, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: corPrimaria)),
      ],
    );
  }
}
