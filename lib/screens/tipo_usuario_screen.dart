import 'package:flutter/material.dart';
import 'agenda_screen.dart';

class TipoUsuarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double largura_tela = MediaQuery.of(context).size.width;
    double altura_tela = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: largura_tela * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: altura_tela * 0.1),
              Image.asset('images/logo.png', height: 80, fit: BoxFit.contain),
              SizedBox(height: 12),
              Text(
                'PETCARE+',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Cuidados com quem você ama',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              SizedBox(height: altura_tela * 0.07),
              Text(
                'Você é:',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AgendaScreen(tipoUsuario: 'tutor')),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0EFFF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.favorite_outline,
                            color: Theme.of(context).colorScheme.primary,
                            size: 26),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tutor',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Cuido dos meus pets',
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF9E9E9E)),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF9E9E9E), size: 16),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AgendaScreen(tipoUsuario: 'veterinario')),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0EFFF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.medical_services_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 26),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Veterinário',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Atendo e monitoro pacientes',
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xFF9E9E9E)),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF9E9E9E), size: 16),
                    ],
                  ),
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
