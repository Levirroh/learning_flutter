import 'package:flutter/material.dart';
import 'package:agenda_eventos/screens/home_screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  void enter() {
    if (!formKey.currentState!.validate()) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => HomeScreen(name: nameController.text.trim()),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
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
            key: formKey,
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Seu nome",
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => enter(),
              validator: (value) => value == null || value.trim().isEmpty
                  ? "Informe seu nome"
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: enter, child: const Text("Entrar")),
        ],
      ),
    );
  }
}
