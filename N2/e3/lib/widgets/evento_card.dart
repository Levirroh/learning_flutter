import 'package:flutter/material.dart';
import 'package:agenda_eventos/app_colors.dart';
import 'package:agenda_eventos/models/evento.dart';

class EventoCard extends StatelessWidget {
  const EventoCard({
    super.key,
    required this.evento,
    required this.onDetalhes,
    required this.onInscricao,
    required this.compacto,
  });

  final Evento evento;
  final VoidCallback onDetalhes;
  final VoidCallback onInscricao;
  final bool compacto;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(compacto ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              evento.titulo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              "${evento.categoria} • ${evento.dataFormatada}",
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            Text(evento.local),
            if (!compacto) ...[
              const SizedBox(height: 8),
              Text(evento.descricao),
            ],
            const SizedBox(height: 8),
            if (evento.inscrito)
              const Text(
                "Inscrição confirmada",
                style: TextStyle(color: AppColors.done),
              ),
            Wrap(
              spacing: 8,
              children: [
                TextButton(
                  onPressed: onDetalhes,
                  child: const Text("Detalhes"),
                ),
                ElevatedButton(
                  onPressed: onInscricao,
                  child: Text(
                    evento.inscrito ? "Cancelar inscrição" : "Inscrever-se",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
