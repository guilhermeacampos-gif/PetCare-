import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'abrirnovocuidado.dart';
import 'exportarhistorico.dart';

class Historicopet extends StatefulWidget {
  const Historicopet({super.key});

  @override
  State<Historicopet> createState() => _HistoricopetState();
}

class _HistoricopetState extends State<Historicopet> {
  final _petRef = FirebaseFirestore.instance.collection('Pets').doc('69WrDHBDy4XNoLYIncac');

  void _abrirNovoCuidado(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NovoCuidado(),
    );
  }

  void _abrirExportarHistorico(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const Exportarhistorico(),
    );
  }

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
            Image.asset('assets/images/logo.png', height: 30, fit: BoxFit.contain),
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

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: (altura * 0.28), width: double.infinity,
            child: Image.asset('assets/images/Golden.png', fit: BoxFit.cover, alignment: Alignment.center,),),
            StreamBuilder<DocumentSnapshot>(
              stream: _petRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(),);
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Padding(padding: EdgeInsets.all(16), child: Text('Pet não encontrado'),);
                }
                final pet = snapshot.data!.data() as Map<String, dynamic>;
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(pet['nome'] ?? '', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),),
                          GestureDetector(
                            onTap: () => _abrirExportarHistorico(context),
                            child: const Icon(Icons.more_vert, color: Colors.grey),
                          ),
                        ],
                      ),
                      Text('${pet['tipo']} - ${pet['raca']}', 
                        style: const TextStyle(fontSize: 14, color: Colors.black87)),
                      Text('${pet['idade']} - ${pet['peso']}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ],
                  ),
                );
              },
            ),

            const Divider(thickness: 1, height: 1),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bolt, color: Theme.of(context).colorScheme.primary,),
                      SizedBox(width: 4),
                      Text('Histórico', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),),
                    ],
                  ),
                  ElevatedButton(onPressed: () => _abrirNovoCuidado(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),),
                    child: Text('+ Novo', style: TextStyle(color: Theme.of(context).colorScheme.secondary),),),
                ],
              ),
            ),

            StreamBuilder<QuerySnapshot>(
              stream: _petRef.collection('Histórico')
                .orderBy('data', descending: true)
                .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Nenhum registro encontrado'),
                  );
                }

                final docs = snapshot.data!.docs;

                return Column(
                  children: docs.map((doc) {
                    final dados = doc.data() as Map<String, dynamic>;
                    return _buildHistoricoCard(
                      context,
                      titulo: dados['titulo'] ?? '',
                      descricao: dados['descricao'] ?? '',
                      data: dados['data'] ?? '',
                    );
                  }).toList(),
                ); 
              },
            ),
          ],
        ),
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
  Widget _buildHistoricoCard(BuildContext context, {required String titulo, required String descricao, required String data,})
  {return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6, offset: Offset(0, 2),),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
              SizedBox(height: 4),
              Row(children: [
                Icon(Icons.description_outlined, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text(descricao, style: TextStyle(fontSize: 13, color: Colors.black54),),
              ],
            ),
          ],
        ),
      ),
      Row(
        children: [
          Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
          SizedBox(width: 4),
          Text(data, style: TextStyle(fontSize: 12, color: Colors.black54),),
        ],),
      ],
    ),
  );}
}