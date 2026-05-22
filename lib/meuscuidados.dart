import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MeusCuidados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              )
            )
          ],
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/logo.png',
              height: 50,
              fit: BoxFit.contain,
            ),
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
      body: Column(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: 
            SizedBox(
              height: 50,
              child: SvgPicture.asset(
                "images/icones/pet-paw.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: ''
          ),
          BottomNavigationBarItem(icon: 
            SizedBox(
              height: 50,
              child: SvgPicture.asset(
                "images/icones/calendar.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: ''
          ),
          BottomNavigationBarItem(icon: 
            SizedBox(
              height: 50,
              child: SvgPicture.asset(
                "images/icones/hand-holding-heart.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: ''
          ),
          BottomNavigationBarItem(icon: 
            SizedBox(
              height: 50,
              child: SvgPicture.asset(
                "images/icones/perfil.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: ''
          ),
        ],
      ),
    );
  }
}