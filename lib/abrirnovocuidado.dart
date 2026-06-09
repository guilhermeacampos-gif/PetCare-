import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'selecionartipo.dart';


class NovoCuidado extends StatefulWidget {
  const NovoCuidado({super.key});

  @override 
  State<NovoCuidado> createState() => _NovoCuidadoState();
}

  class _NovoCuidadoState extends State<NovoCuidado> {
    final _historicoRef = FirebaseFirestore.instance.collection('Pets').doc('69WrDHBDy4XNoLYIncac').collection('Histórico');

    String? _tipoSelecionado;
    String? _dataSelecionada;
    bool _salvando = false;
    final TextEditingController _descricaoController = TextEditingController();

    @override
    void dispose() {
      _descricaoController.dispose();
      super.dispose();
    }

    void _abrirSelecionarTipo() async {
      final resultado = await showModalBottomSheet<String>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const Selecionartipo(),
      );
      if (resultado != null) {
        setState(() => _tipoSelecionado = resultado);
      }
    }

    void _selecionarData() async {
      final data = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2070),
      );
      if (data !=null) {
        setState(() {
          _dataSelecionada = '${data.day.toString().padLeft(2, '0')}/''${data.month.toString().padLeft(2, '0')}/''${data.year}';
        });
      }
    }

    void _salvar() async {
      if (_tipoSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecione um tipo de cuidado')));
        return;
      }
      if (_dataSelecionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecione uma data')));
        return;
      }

      final partes = _dataSelecionada!.split('/');
      final dataTimestamp = Timestamp.fromDate(DateTime(
        int.parse(partes[2]), 
        int.parse(partes[1]), 
        int.parse(partes[0]), 
      ));
      setState(() => _salvando = true);

      try {
        await _historicoRef.add({
          'titulo': _tipoSelecionado,
          'descricao': _descricaoController.text.trim(),
          'data': _dataSelecionada,
          'dataTimestamp': dataTimestamp,
          'criado Em': FieldValue.serverTimestamp(),
          'criado Por': FirebaseAuth.instance.currentUser?.email,
        });

        if (mounted) Navigator.pop(context);
      } catch (e) {
        setState(() => _salvando = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar cuidado: $e')));
        }
      }
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
          children: [
            Container(
              width: 40, height: 4, margin: const EdgeInsets.only(bottom:16),
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2),),
            ),
            const Text('Novo Cuidado', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _abrirSelecionarTipo(),
              child: _buildCampo(
                label: 'Tipo de Cuidado',
                valor: _tipoSelecionado ?? 'Selecione o tipo de cuidado',
                trailing: const Icon(Icons.arrow_drop_down, size:18, color: Colors.grey)
              ),
            ),
            const SizedBox(height: 10),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 90,
                    child: Text('Descrição', style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _descricaoController,
                      decoration: const InputDecoration(
                        hintText: 'Digite uma descrição ...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () => _selecionarData(),
              child: _buildCampo(
                label: 'Data',
                valor: _dataSelecionada ?? 'Selecione a data ...',
                trailing: const Icon(Icons.calendar_today_outlined, size:18, color: Colors.grey),
                valorCinza: _dataSelecionada == null,
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _salvando ? null : _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _salvando 
                  ? const SizedBox(
                    height: 20, width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : Text('Salvar',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16, fontWeight: FontWeight.bold,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildCampo({
    required String label,
    required String valor,
    required Widget trailing,
    bool valorCinza = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(valor, style: TextStyle(color: valorCinza ? Colors.grey : Colors.black87, fontSize: 13),),
          ),
          trailing,
        ],
      ),
    );
  }
}
