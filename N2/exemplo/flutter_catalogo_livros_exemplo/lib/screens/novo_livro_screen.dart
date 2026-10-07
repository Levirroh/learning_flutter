import 'package:flutter/material.dart';

import '../models/livro.dart';
import '../utils/categorias.dart';

class NovoLivroScreen extends StatefulWidget {
  const NovoLivroScreen({super.key});

  @override
  State<NovoLivroScreen> createState() => _NovoLivroScreenState();
}

class _NovoLivroScreenState extends State<NovoLivroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _descricaoController = TextEditingController();

  String _categoria = 'Tecnologia';
  bool _favorito = false;
  bool _salvando = false;

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _salvando = true);

    // Pequena espera apenas para demonstrar estado de carregamento.
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    final livro = Livro(
      id: DateTime.now().millisecondsSinceEpoch,
      titulo: _tituloController.text.trim(),
      autor: _autorController.text.trim(),
      categoria: _categoria,
      descricao: _descricaoController.text.trim(),
      favorito: _favorito,
    );

    // pop(context, resultado) devolve o novo Livro para HomeScreen.
    Navigator.pop(context, livro);
  }

  @override
  Widget build(BuildContext context) {
    final categoriasCadastro = categorias.where((c) => c != 'Todos').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Novo livro')),
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
                controller: _autorController,
                decoration: const InputDecoration(
                  labelText: 'Autor',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o autor.';
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
                title: const Text('Adicionar como favorito'),
                value: _favorito,
                onChanged: _salvando
                    ? null
                    : (valor) => setState(() => _favorito = valor),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _salvando ? null : _salvar,
                icon: const Icon(Icons.save),
                label: const Text('Salvar livro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
