import 'package:flutter/material.dart';

class Historicopet extends StatelessWidget {
  const Historicopet({super.key});

  @override
  Widget build(BuildContext context) {
    final altura = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('images/logo.png', height: 30, fit: BoxFit.contain),
            SizedBox(width: 10),
            Text(
              'PET CARE+',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Image.asset('images/golden.jpg', width: double.infinity, height: altura * 0.3, fit: BoxFit.cover,),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.7),
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: ''),
        ],
      ),
    );
  }
}