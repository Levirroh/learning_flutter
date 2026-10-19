import 'package:flutter/material.dart';
import 'package:agenda_eventos/models/evento.dart';

class DetalhesEventoScreen extends StatefulWidget {
  const DetalhesEventoScreen({super.key, required this.evento});

  final Evento evento;

  @override
  State<DetalhesEventoScreen> createState() => _DetalhesEventoScreenState();
}

class _DetalhesEventoScreenState extends State<DetalhesEventoScreen> {
  // TODO_ATIVIDADE_07 concluído.
  Future<void> _excluir() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Excluir evento?"),
        content: Text("Deseja excluir ${widget.evento.titulo}?"),
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
    if (!mounted || confirmar != true) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final evento = widget.evento;
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes do evento")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            evento.titulo,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text("Categoria: ${evento.categoria}"),
          Text("Local: ${evento.local}"),
          Text("Data: ${evento.dataFormatada}"),
          const SizedBox(height: 16),
          Text(evento.descricao),
          const SizedBox(height: 24),
          FilledButton(
            // TODO_ATIVIDADE_08 concluído.
            onPressed: () => setState(() => evento.inscrito = !evento.inscrito),
            child: Text(
              evento.inscrito ? "Cancelar inscrição" : "Inscrever-se",
            ),
          ),
          OutlinedButton(
            onPressed: _excluir,
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
