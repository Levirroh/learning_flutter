import 'package:flutter/material.dart';
import 'package:items_supabase/models/item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({super.key});

  @override
  State<NewItemPage> createState() => _NewItemScreenPageState();
}

class _NewItemScreenPageState extends State<NewItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final supabase = Supabase.instance.client;

  late final user = supabase.auth.currentUser;

  bool _salvando = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_salvando || !_formKey.currentState!.validate()) return;
    setState(() => _salvando = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    final item = Item(
      id: DateTime.now().microsecondsSinceEpoch,
      name: _nameController.text.trim(),
      createdAt: DateTime.now(),
      userId: user!.id,
    );
    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Item')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (_salvando) const LinearProgressIndicator(),
              if (_salvando) const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o nome.';
                  }
                  return null;
                },
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
