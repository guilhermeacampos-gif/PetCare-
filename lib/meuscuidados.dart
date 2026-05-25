import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_care/screens/agenda_screen.dart';
import 'package:pet_care/screens/documentos_screen.dart';

class MeusCuidados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        toolbarHeight: 96,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(8, 0, 0, 0),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('images/logo.png', height: 50, fit: BoxFit.contain),
            SizedBox(width: 10),
            Text(
              'PETCARE+',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            height: 50,
            child: SvgPicture.asset(
              "images/icones/emergency-white.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(24, 36, 24, 60),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Meus Cuidados",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.all(
                      Radius.circular(16)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AgendaScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      shadowColor: Colors.black.withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(16)
                        )
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.alarm,
                          size: 64,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        Text(
                          "Agenda Diária",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.all(
                      Radius.circular(16)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DocumentosScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      shadowColor: Colors.black.withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(16)
                        )
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 64,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        Text(
                          "Documentos",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 50,
              child: SvgPicture.asset(
                "images/icones/pet-paw.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 50,
              child: SvgPicture.asset(
                "images/icones/calendar.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 50,
              child: SvgPicture.asset(
                "images/icones/hand-holding-heart.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 50,
              child: SvgPicture.asset(
                "images/icones/perfil.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
