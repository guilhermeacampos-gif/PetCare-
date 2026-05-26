import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_care/historicopet.dart';

class BuscaPetsScreen extends StatelessWidget {
  const BuscaPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F4F8),

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,

        toolbarHeight: 96,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            Image.asset('images/logo.png', height: 45),

            SizedBox(width: 10),

            Text(
              "PETCARE+",

              style: TextStyle(
                color: Colors.white,

                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),

            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/confirmEmergency');
              },

              child: SvgPicture.asset(
                "images/icones/emergency-white.svg",

                height: 34,

                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,

                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar por nome do pet ou tutor do pet",

                prefixIcon: Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 24),

            Text(
              "Resultados Encontrados:",

              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,

                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            petCard(context, "Rex", "Maria", "Vacinas em dia", Colors.green),

            SizedBox(height: 16),

            petCard(context, "Tifo", "Pedro", "Atenção", Colors.orange),

            SizedBox(height: 16),

            petCard(context, "Bichano", "Valesca", "Urgente", Colors.red),
          ],
        ),
      ),
    );
  }

  static Widget petCard(
    BuildContext context,
    String pet,
    String tutor,
    String status,
    Color cor,
  ) {
    return Container(
      padding: EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          CircleAvatar(radius: 30, child: Icon(Icons.pets)),

          SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  pet,

                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                Text(tutor),

                Row(
                  children: [
                    Icon(Icons.circle, size: 10, color: cor),

                    SizedBox(width: 6),

                    Text(status),
                  ],
                ),

                Text("Última consulta 10/03"),
              ],
            ),
          ),

          FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Historicopet()),
              );
            },

            child: Text("Ver detalhes"),
          ),
        ],
      ),
    );
  }
}
