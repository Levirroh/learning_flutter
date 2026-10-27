import 'package:flutter/material.dart';
import 'package:agenda_eventos/app_colors.dart';
import 'package:agenda_eventos/models/event.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.onDetails,
    required this.onRegistrationToggle,
    required this.compact,
  });

  final Event event;
  final VoidCallback onDetails;
  final VoidCallback onRegistrationToggle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(compact ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              "${event.category} • ${event.formattedDate}",
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            Text(event.location),
            if (!compact) ...[
              const SizedBox(height: 8),
              Text(event.description),
            ],
            const SizedBox(height: 8),
            if (event.registered)
              const Text(
                "Inscrição confirmada",
                style: TextStyle(color: AppColors.done),
              ),
            Wrap(
              spacing: 8,
              children: [
                TextButton(onPressed: onDetails, child: const Text("Detalhes")),
                ElevatedButton(
                  onPressed: onRegistrationToggle,
                  child: Text(
                    event.registered ? "Cancelar inscrição" : "Inscrever-se",
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
