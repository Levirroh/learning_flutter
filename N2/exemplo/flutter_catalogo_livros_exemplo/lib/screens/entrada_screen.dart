import 'package:flutter/material.dart';

import 'home_screen.dart';

class EntradaScreen extends StatefulWidget {
  const EntradaScreen({super.key});

  @override
  State<EntradaScreen> createState() => _EntradaScreenState();
}

class _EntradaScreenState extends State<EntradaScreen> {
  final _nomeController = TextEditingController();

  @override
  void dispose() {
    // Controllers devem ser liberados quando o State sai definitivamente da arvore.
    _nomeController.dispose();
    super.dispose();
  }

  void _entrar() {
    final nome = _nomeController.text.trim();

    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite seu nome para continuar.')),
      );
      return;
    }

    // pushReplacement substitui a rota atual.
    // Depois disso, pressionar Voltar nao retorna para esta tela de entrada.
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (_) => HomeScreen(nomeUsuario: nome),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biblioteca de Bolso')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.menu_book, size: 84),
                  const SizedBox(height: 20),
                  Text(
                    'Exemplo didatico Flutter',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Widgets comuns, estado local, navegacao e ciclo de vida em um unico projeto.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Seu nome',
                      hintText: 'Ex.: Ana',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _entrar(),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _entrar,
                    icon: const Icon(Icons.login),
                    label: const Text('Entrar no catalogo'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
