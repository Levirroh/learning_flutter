import 'package:flutter/material.dart';
import 'package:agenda_eventos/data/initial_events.dart';
import 'package:agenda_eventos/models/event.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedCategory = "Palestra";
  DateTime selectedDate = DateTime.now();
  bool saving = false;

  String? validateRequired(String? value) {
    return value == null || value.trim().isEmpty ? "Preencha este campo" : null;
  }

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (!mounted || date == null) return;
    setState(() => selectedDate = date);
  }

  Future<void> saveEvent() async {
    if (saving || !formKey.currentState!.validate()) return;
    setState(() => saving = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    final event = Event(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      location: locationController.text.trim(),
      category: selectedCategory,
      date: selectedDate,
    );
    Navigator.pop(context, event);
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final date =
        "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}";
    return PopScope(
      canPop: !saving,
      child: Scaffold(
        appBar: AppBar(title: const Text("Novo evento")),
        body: AbsorbPointer(
          absorbing: saving,
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Título"),
                  validator: validateRequired,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: "Local"),
                  validator: validateRequired,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Descrição"),
                  minLines: 3,
                  maxLines: 5,
                  validator: validateRequired,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  decoration: const InputDecoration(labelText: "Categoria"),
                  items: categories
                      .where((category) => category != "Todos")
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => selectedCategory = value);
                  },
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: selectDate,
                  icon: const Icon(Icons.calendar_month),
                  label: Text("Data: $date"),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: saving ? null : saveEvent,
                  child: saving
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
