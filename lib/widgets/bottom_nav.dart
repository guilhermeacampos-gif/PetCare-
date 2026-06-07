import 'package:flutter/material.dart';

class PetCareBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  PetCareBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => onTap(0),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: currentIndex == 0 ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.pets,
                      color: currentIndex == 0
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      size: 26),
                ),
              ),
              GestureDetector(
                onTap: () => onTap(1),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: currentIndex == 1 ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.calendar_month,
                      color: currentIndex == 1
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      size: 26),
                ),
              ),
              GestureDetector(
                onTap: () => onTap(2),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: currentIndex == 2 ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.volunteer_activism_outlined,
                      color: currentIndex == 2
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      size: 26),
                ),
              ),
              GestureDetector(
                onTap: () => onTap(3),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: currentIndex == 3 ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_outline,
                      color: currentIndex == 3
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                      size: 26),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
