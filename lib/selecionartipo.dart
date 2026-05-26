import 'package:flutter/material.dart';


class Selecionartipo extends StatelessWidget {
  const Selecionartipo({super.key});

  static const _tipos = ['Vacina', 'Exame', 'Medicamento', 'Consulta'];

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
          children: [
            Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom:16),
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2),),
            ),
            const Text('Selecionar Tipo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            const SizedBox(height: 16),
            ..._tipos.map((tipo) => Column(
              children: [
                ListTile(
                  title: Text(tipo),
                  contentPadding: EdgeInsets.zero,
                  onTap: () => Navigator.pop(context, tipo),
                ),
                Divider(height: 1, color: Colors.grey.shade200),
              ],
            ),),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                ),
                child: Text('Salvar', style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
