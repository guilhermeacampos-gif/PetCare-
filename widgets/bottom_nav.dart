import 'package:flutter/material.dart';

class PetCareBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  PetCareBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: corPrimaria,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ItemNav(icon: Icons.pets, isSelected: currentIndex == 0, onTap: () => onTap(0)),
              ItemNav(icon: Icons.calendar_month, isSelected: currentIndex == 1, onTap: () => onTap(1)),
              ItemNav(icon: Icons.volunteer_activism_outlined, isSelected: currentIndex == 2, onTap: () => onTap(2)),
              ItemNav(icon: Icons.person_outline, isSelected: currentIndex == 3, onTap: () => onTap(3)),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemNav extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  ItemNav({required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? corPrimaria : Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
