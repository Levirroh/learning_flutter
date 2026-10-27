import 'package:flutter/material.dart';
import 'package:agenda_eventos/models/event.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key, required this.event});

  final Event event;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  Future<void> deleteEvent() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Excluir evento?"),
        content: Text("Deseja excluir ${widget.event.title}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Excluir"),
          ),
        ],
      ),
    );
    if (!mounted || confirm != true) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes do evento")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            event.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text("Categoria: ${event.category}"),
          Text("Local: ${event.location}"),
          Text("Data: ${event.formattedDate}"),
          const SizedBox(height: 16),
          Text(event.description),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () =>
                setState(() => event.registered = !event.registered),
            child: Text(
              event.registered ? "Cancelar inscrição" : "Inscrever-se",
            ),
          ),
          OutlinedButton(
            onPressed: deleteEvent,
            child: const Text("Excluir evento"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Voltar à agenda"),
          ),
        ],
      ),
    );
  }
}
