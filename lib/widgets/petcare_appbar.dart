import 'package:flutter/material.dart';

class PetCareAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBack;
  final VoidCallback? onBack;

  PetCareAppBar({this.showBack = true, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            )
          : null,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('images/logo.png', height: 36, fit: BoxFit.contain),
          SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PETCARE+',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'PetCare+',
                style: TextStyle(fontSize: 10, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(0, 0, 12, 0),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white70, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.notifications_outlined,
                  color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
