import 'package:flutter/material.dart';
import 'package:items_supabase/models/item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItemFormPageState extends StatefulWidget {
  const ItemFormPageState({super.key, this.item, required this.isEdit});

  final Item? item;
  final bool isEdit;

  @override
  State<ItemFormPageState> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPageState> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  Item? get item => widget.item;
  bool get isEdit => widget.isEdit;

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
      id: "",
      name: _nameController.text.trim(),
      createdAt: DateTime.now(),
      userId: user!.id,
    );
    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar Item' : 'Adicionar Item')),
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
                label: Text(isEdit ? 'Atualizar Evento' : 'Salvar evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
