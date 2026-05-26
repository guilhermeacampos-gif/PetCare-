import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F7),

      appBar: AppBar(
        backgroundColor: const Color(0xFF181166),

        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: const Text(
          "PETCARE+",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const SizedBox(
              height: 10,
            ),

            const Text(
              "Mapa de clínicas próximas",

              style: TextStyle(
                color: Color(0xFF181166),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Container(

  width: double.infinity,

  height: 220,

  clipBehavior: Clip.hardEdge,

  decoration: BoxDecoration(

    borderRadius:
        BorderRadius.circular(
      20,
    ),

  ),

  child: Image.network(

'https://tile.openstreetmap.org/13/2724/1816.png',

    fit: BoxFit.cover,

  ),

),

            const SizedBox(
              height: 24,
            ),

            const Text(
              "Clínicas Próximas:",

              style: TextStyle(
                color: Color(0xFF181166),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            clinicCard(
              context,

              "PetVida Clínica Veterinária",

              "0,3 km • Aberto 24h",
            ),

            const SizedBox(
              height: 12,
            ),

            clinicCard(
              context,

              "AnimalCare Hospital",

              "1,2 km • Fecha às 22h",
            ),

            const Spacer(),

            SizedBox(
              width:
                  double.infinity,

              height: 55,

              child:
                  ElevatedButton(

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red,
                ),

                onPressed: () {},

                child:
                    const Text(

                  "📞 LIGAR PARA EMERGÊNCIA",

                  style: TextStyle(
                    color:
                        Colors.white,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget clinicCard(
    BuildContext context,

    String nome,

    String info,
  ) {

    return GestureDetector(

      onTap: () {

        showDialog(

          context: context,

          builder: (_) {

            return AlertDialog(

              title:
                  Text(
                nome,
              ),

              content:
                  const Text(
                "Ligar para clínica?",
              ),

              actions: [

                TextButton(

                  onPressed: () {

                    Navigator.pop(
                      context,
                    );

                  },

                  child:
                      const Text(
                    "Cancelar",
                  ),

                ),

                ElevatedButton(

                  onPressed: () {

                    Navigator.pop(
                      context,
                    );

                  },

                  child:
                      const Text(
                    "Ligar",
                  ),

                ),

              ],

            );

          },

        );

      },

      child: Container(

        padding:
            const EdgeInsets.all(
          16,
        ),

        decoration:
            BoxDecoration(

          color:
              Colors.white,

          borderRadius:
              BorderRadius.circular(
            16,
          ),

        ),

        child: Row(

          children: [

            const Icon(
              Icons.local_hospital,
              size: 40,
            ),

            const SizedBox(
              width: 12,
            ),

            Expanded(

              child:
                  Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(nome),

                  Text(info),

                ],

              ),

            ),

            const Icon(
              Icons.call,

              color:
                  Colors.deepPurple,
            ),

          ],

        ),

      ),

    );

  }

}