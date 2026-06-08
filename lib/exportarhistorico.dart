import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Exportarhistorico extends StatefulWidget {
  const Exportarhistorico({super.key});

  @override
  State<Exportarhistorico> createState() => _ExportarhistoricoState();
}

  class _ExportarhistoricoState extends State<Exportarhistorico> {
    final _historicoRef = FirebaseFirestore.instance.collection('Pets').doc('69WrDHBDy4XNoLYIncac').collection('Histórico');

    String _periodoSelecionado = 'Últimos 30 dias';

    final Map<String, bool> _tiposSelecionados = {
      'Vacinas': true,
      'Exames': true,
      'Consultas Médicas': true,
      'Medicamentos': true,
    };

    bool _gerando = false;

    static const _periodos = ['Últimos 30 dias', 'Último ano', 'Personalizado'];

    bool _dentroNoPeriodo(String data) {
      try {
        final partes = data.split('/');
        final dataDoc = DateTime(int.parse(partes[2]), int.parse(partes[1]), int.parse(partes[0]));
        final hoje = DateTime.now();
        if (_periodoSelecionado == 'Últimos 30 dias') {
          return dataDoc.isAfter(hoje.subtract(const Duration(days: 30)));
        } else if (_periodoSelecionado == 'Último ano') {
          return dataDoc.isAfter(hoje.subtract(const Duration(days: 365)));
        }
        return true;
      } catch (e) {
        return true;
      }
    }

    void _gerarPDF() async {
      setState(() => _gerando = true);

      try {
        final snapshot = await _historicoRef.orderBy('data', descending: true).get();

        final tiposAtivos = _tiposSelecionados.entries.where((e) => e.value).map((e) => e.key.toLowerCase()).toList();
        
        final registros = snapshot.docs.map((doc) => doc.data()).where((dados) {
          final titulo = (dados['titulo'] ?? '').toString().toLowerCase();
          final data = dados['data'] ?? '';
          final tipoOk = tiposAtivos.any((t) => t.contains(titulo) || titulo.contains(t.replaceAll('s', '')));
          final periodoOk = _dentroNoPeriodo(data);
          return tipoOk && periodoOk;
          }).toList();

        final pdf = pw.Document();

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                    child: pw.Text('PetCare+', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Center(
                    child: pw.Text('Histórico de Cuidados', style: const pw.TextStyle(fontSize: 14)),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Center(
                    child: pw.Text('Período: $_periodoSelecionado', style: const pw.TextStyle(fontSize: 12)),
                  ),
                  pw.Divider(),
                  pw.SizedBox(height: 16),

                  if (registros.isEmpty)
                    pw.Text('Nenhum registro encontrado para os filtros selecionados')
                  else
                    ...registros.map((r) => pw.Container(
                      margin: const pw.EdgeInsets.only(bottom: 12),
                      padding: const pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.grey300), 
                        borderRadius: pw.BorderRadius.circular(6),
                      ),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(r['titulo'] ?? '', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize:13)),
                              pw.SizedBox(height: 4),
                              pw.Text(r['descricao'] ?? '', style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700)),
                            ],
                          ),
                          pw.Text(r['data'] ?? '', style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700)),
                        ],
                      ),
                    )),
                  pw.SizedBox(height: 24),
                  pw.Center(
                    child: pw.Text('Gerado em ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
                  ),
                ],
              );
            },
          ),
        );

        await Printing.layoutPdf(onLayout: (_) async => pdf.save());

      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao gerar PDF: $e')));
        }
      }

      if (mounted) setState(() => _gerando = false);
    }       

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
                Radio(value: periodo, groupValue: _periodoSelecionado, onChanged: (v) => setState(() => _periodoSelecionado = v!),
                activeColor: Theme.of(context).colorScheme.primary,),
                Text(periodo, style: const TextStyle(fontSize: 14)),
              ],
            )),
            const Divider(height: 24,),

            const Text('Tipo de Registro', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._tiposSelecionados.keys.map((tipo) => Row(
              children: [
                Checkbox(value: _tiposSelecionados[tipo], onChanged: (v) => setState(() => _tiposSelecionados[tipo] = v!), activeColor: Theme.of(context).colorScheme.primary),
                Text(tipo, style: const TextStyle(fontSize: 14)),
              ],
            )),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _gerando ? null : _gerarPDF,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _gerando ? const SizedBox(
                  height: 20, width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2)
                )
                : Text('Gerar PDF',
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}