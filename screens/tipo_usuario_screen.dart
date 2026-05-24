import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'agenda_screen.dart';

class TipoUsuarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;
    double larguraTela = MediaQuery.of(context).size.width;
    double alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: corPrimaria,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: larguraTela * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: alturaTela * 0.1),
              Icon(Icons.pets, color: Colors.white, size: 56),
              SizedBox(height: 16),
              Text(
                'PETCARE+',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 2),
              ),
              SizedBox(height: 8),
              Text(
                'Cuidados com quem você ama',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              SizedBox(height: alturaTela * 0.08),
              Text(
                'Você é:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
              SizedBox(height: 20),
              _CartaoTipo(
                icone: Icons.favorite_outline,
                titulo: 'Tutor',
                descricao: 'Cuido dos meus pets',
                aoSelecionar: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AgendaScreen(tipoUsuario: 'tutor')),
                ),
              ),
              SizedBox(height: 16),
              _CartaoTipo(
                icone: Icons.medical_services_outlined,
                titulo: 'Veterinário',
                descricao: 'Atendo e monitoro pacientes',
                aoSelecionar: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AgendaScreen(tipoUsuario: 'veterinario')),
                ),
              ),
              Spacer(),
              Text(
                'Você poderá alterar isso nas configurações',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white54),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartaoTipo extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  final VoidCallback aoSelecionar;

  _CartaoTipo({required this.icone, required this.titulo, required this.descricao, required this.aoSelecionar});

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: aoSelecionar,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2), blurRadius: 12, offset: Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(color: Color(0xFFF0EFFF), borderRadius: BorderRadius.circular(12)),
              child: Icon(icone, color: corPrimaria, size: 26),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: corPrimaria)),
                  SizedBox(height: 4),
                  Text(descricao, style: TextStyle(fontSize: 13, color: AppColors.darkGrey)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.darkGrey, size: 16),
          ],
        ),
      ),
    );
  }
}
