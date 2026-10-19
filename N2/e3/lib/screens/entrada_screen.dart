import 'package:flutter/material.dart';
import 'package:agenda_eventos/screens/home_screen.dart';

class EntradaScreen extends StatefulWidget {
  const EntradaScreen({super.key});

  @override
  State<EntradaScreen> createState() => _EntradaScreenState();
}

class _EntradaScreenState extends State<EntradaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();

  void _entrar() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => HomeScreen(nome: _nomeController.text.trim()),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agenda de Eventos")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 40),
          const Icon(Icons.event_note, size: 64),
          const SizedBox(height: 24),
          const Text("Eventos acadêmicos", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          const Text("Informe seu nome para acessar a agenda."),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: "Seu nome",
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _entrar(),
              validator: (value) => value == null || value.trim().isEmpty
                  ? "Informe seu nome"
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _entrar, child: const Text("Entrar")),
        ],
      ),
    );
  }
}
