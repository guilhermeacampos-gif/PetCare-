import 'package:flutter/material.dart';

class Exportarhistorico extends StatelessWidget {
  const Exportarhistorico({super.key});

  static const _periodos = ['Últimos 30 dias', 'Último ano', 'Personalizado'];
  static const _tipos = ['Vacinas','Exames','Consultas Médicas','Medicamentos'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFEFEFEF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                margin: const EdgeInsets.only(bottom:16),
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const Center(child: Text('Exportar Histórico', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
            const SizedBox(height: 20),

            const Text('Período', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._periodos.map((periodo) => Row(
              children: [
                Radio(value: periodo, groupValue: 'Últimos 30 dias', onChanged: (_) {},
                activeColor: Theme.of(context).colorScheme.primary,),
                Text(periodo, style: const TextStyle(fontSize: 14)),
              ],
            )),
            const Divider(height: 24,),

            const Text('Tipo de Registro', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._tipos.map((tipo) => Row(
              children: [
                Checkbox(value: true, onChanged: (_) {}, activeColor: Theme.of(context).colorScheme.primary),
                Text(tipo, style: const TextStyle(fontSize: 14)),
              ],
            )),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Gerar PDF',
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}