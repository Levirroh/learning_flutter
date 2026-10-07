import 'package:flutter/material.dart';

import '../models/livro.dart';
import '../utils/categorias.dart';

class DetalhesLivroScreen extends StatefulWidget {
  const DetalhesLivroScreen({
    super.key,
    required this.livro,
  });

  final Livro livro;

  @override
  State<DetalhesLivroScreen> createState() => _DetalhesLivroScreenState();
}

class _DetalhesLivroScreenState extends State<DetalhesLivroScreen> {
  Future<void> _confirmarExclusao() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir livro?'),
        content: Text('Remover "${widget.livro.titulo}" do catalogo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (!mounted || confirmar != true) return;

    // Esta pagina devolve true para avisar a Home que o livro deve ser removido.
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final livro = widget.livro;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        actions: [
          IconButton(
            tooltip: 'Excluir',
            onPressed: _confirmarExclusao,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 42,
                child: Icon(iconeDaCategoria(livro.categoria), size: 40),
              ),
              const SizedBox(height: 16),
              Text(
                livro.titulo,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                livro.autor,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(label: Text(livro.categoria)),
                  const SizedBox(width: 8),
                  Chip(label: Text(livro.lido ? 'Lido' : 'Nao lido')),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(livro.descricao),
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Favorito'),
                value: livro.favorito,
                onChanged: (valor) {
                  setState(() => livro.favorito = valor);
                },
              ),
              CheckboxListTile(
                title: const Text('Ja li este livro'),
                value: livro.lido,
                onChanged: (valor) {
                  setState(() => livro.lido = valor ?? false);
                },
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => Navigator.pop(context, false),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Voltar para a lista'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
