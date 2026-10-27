import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../utils/categorias.dart';

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

  String _categoria = 'Tecnologia';
  bool _inscrito = false;
  bool _salvando = false;

  @override
  void dispose() {
    _tituloController.dispose();
    _localController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_salvando || !_formKey.currentState!.validate()) return;
    setState(() => _salvando = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    final evento = Evento(
      id: DateTime.now().microsecondsSinceEpoch,
      titulo: _tituloController.text.trim(),
      local: _localController.text.trim(),
      categoria: _categoria,
      descricao: _descricaoController.text.trim(),
      inscrito: _inscrito,
    );
    Navigator.pop(context, evento);
  }

  @override
  Widget build(BuildContext context) {
    final categoriasCadastro = categorias.where((c) => c != 'Todos').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Novo evento')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (_salvando) const LinearProgressIndicator(),
              if (_salvando) const SizedBox(height: 16),
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o titulo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _localController,
                decoration: const InputDecoration(
                  labelText: 'Local',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o local.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _categoria,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
                items: categoriasCadastro
                    .map(
                      (categoria) => DropdownMenuItem<String>(
                        value: categoria,
                        child: Text(categoria),
                      ),
                    )
                    .toList(),
                onChanged: _salvando
                    ? null
                    : (valor) {
                        if (valor != null) {
                          setState(() => _categoria = valor);
                        }
                      },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descricaoController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Descricao',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Ja quero me inscrever'),
                value: _inscrito,
                onChanged: _salvando
                    ? null
                    : (valor) => setState(() => _inscrito = valor),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _salvando ? null : _salvar,
                icon: const Icon(Icons.save),
                label: const Text('Salvar evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
