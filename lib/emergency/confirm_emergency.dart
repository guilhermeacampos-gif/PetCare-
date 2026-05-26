import 'package:flutter/material.dart';
import 'emergency_screen.dart';

class ConfirmEmergencyPage extends StatelessWidget {
  const ConfirmEmergencyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          Colors.black45,

      body: Center(

        child: Container(

          width: 340,

          padding:
              const EdgeInsets.fromLTRB(
            28,
            18,
            28,
            24,
          ),

          decoration:
              BoxDecoration(

            color:
                const Color(
              0xFFF7F7F7,
            ),

            borderRadius:
                BorderRadius.circular(
              36,
            ),

          ),

          child: Column(

            mainAxisSize:
                MainAxisSize.min,

            children: [

              Container(

                width: 60,

                height: 6,

                decoration:
                    BoxDecoration(

                  color:
                      Colors.grey[300],

                  borderRadius:
                      BorderRadius.circular(
                    10,
                  ),

                ),

              ),

              const SizedBox(
                height: 24,
              ),

              Container(

                width: 72,

                height: 72,

                decoration:
                    BoxDecoration(

                  border:
                      Border.all(
                    color:
                        const Color(
                      0xFFC40000,
                    ),
                    width: 2,
                  ),

                ),

                child:
                    const Icon(

                  Icons.notification_important,

                  color:
                      Color(
                    0xFFC40000,
                  ),

                  size: 44,

                ),

              ),

              const SizedBox(
                height: 28,
              ),

              const Text(

        "Confirmar emergência",

        textAlign:
            TextAlign.center,

        style: TextStyle(

          fontSize: 28,

          fontWeight:
              FontWeight.w500,

          color:
              Colors.black,

        ),

      ),

              const SizedBox(
                height: 18,
              ),

              const Text(

                "Isso irá iniciar uma\nchamada de emergência.",

                textAlign:
                    TextAlign.center,

                style: TextStyle(

                  color:
                      Color(
                    0xFF707070,
                  ),

                  fontSize: 16,

                ),

              ),

              const SizedBox(
                height: 26,
              ),

              SizedBox(

                width:
                    double.infinity,

                height: 52,

                child:
                    ElevatedButton(

                  style:
                      ElevatedButton.styleFrom(

                    elevation: 0,

                    backgroundColor:
                        const Color(
                      0xFFC40000,
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        6,
                      ),

                    ),

                  ),

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:
                            (_) =>
                                const EmergencyScreen(),

                      ),

                    );

                  },

                  child:
                      const Text(

                    "Ligar agora",

                    style:
                        TextStyle(

                      color:
                          Colors.white,

                      fontWeight:
                          FontWeight.bold,

                      fontSize: 18,

                    ),

                  ),

                ),

              ),

              const SizedBox(
                height: 12,
              ),

              SizedBox(

                width:
                    double.infinity,

                height: 52,

                child:
                    ElevatedButton(

                  style:
                      ElevatedButton.styleFrom(

                    elevation: 0,

                    backgroundColor:
                        const Color(
                      0xFFD3D3D3,
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        6,
                      ),

                    ),

                  ),

                  onPressed: () {

                    Navigator.pop(
                      context,
                    );

                  },

                  child:
                      const Text(

                    "Cancelar",

                    style:
                        TextStyle(

                      color:
                          Colors.white,

                      fontWeight:
                          FontWeight.w600,

                    ),

                  ),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}