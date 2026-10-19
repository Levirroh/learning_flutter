import 'package:flutter/material.dart';
import 'package:agenda_eventos/data/eventos_iniciais.dart';
import 'package:agenda_eventos/models/evento.dart';

class NovoEventoScreen extends StatefulWidget {
  const NovoEventoScreen({super.key});

  @override
  State<NovoEventoScreen> createState() => _NovoEventoScreenState();
}

class _NovoEventoScreenState extends State<NovoEventoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _localController = TextEditingController();
  final _descricaoController = TextEditingController();
  String _categoria = "Palestra";
  DateTime _data = DateTime.now();
  bool _salvando = false;

  String? _obrigatorio(String? value) {
    return value == null || value.trim().isEmpty ? "Preencha este campo" : null;
  }

  Future<void> _escolherData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _data,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (!mounted || data == null) return;
    setState(() => _data = data);
  }

  // TODO_ATIVIDADE_09 concluído.
  Future<void> _salvar() async {
    if (_salvando || !_formKey.currentState!.validate()) return;
    setState(() => _salvando = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    final evento = Evento(
      titulo: _tituloController.text.trim(),
      descricao: _descricaoController.text.trim(),
      local: _localController.text.trim(),
      categoria: _categoria,
      data: _data,
    );
    Navigator.pop(context, evento);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _localController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data =
        "${_data.day.toString().padLeft(2, '0')}/${_data.month.toString().padLeft(2, '0')}/${_data.year}";
    return PopScope(
      canPop: !_salvando,
      child: Scaffold(
        appBar: AppBar(title: const Text("Novo evento")),
        body: AbsorbPointer(
          absorbing: _salvando,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(labelText: "Título"),
                  validator: _obrigatorio,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _localController,
                  decoration: const InputDecoration(labelText: "Local"),
                  validator: _obrigatorio,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descricaoController,
                  decoration: const InputDecoration(labelText: "Descrição"),
                  minLines: 3,
                  maxLines: 5,
                  validator: _obrigatorio,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _categoria,
                  decoration: const InputDecoration(labelText: "Categoria"),
                  items: categorias
                      .where((categoria) => categoria != "Todos")
                      .map(
                        (categoria) => DropdownMenuItem(
                          value: categoria,
                          child: Text(categoria),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _categoria = value);
                  },
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _escolherData,
                  icon: const Icon(Icons.calendar_month),
                  label: Text("Data: $data"),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _salvando ? null : _salvar,
                  child: _salvando
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Salvar evento"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
