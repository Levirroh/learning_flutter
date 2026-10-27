import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../utils/categorias.dart';

class EventoCard extends StatelessWidget {
  const EventoCard({
    super.key,
    required this.evento,
    required this.onTap,
    required this.onInscricao,
  });

  final Evento evento;
  final VoidCallback onTap;
  final VoidCallback onInscricao;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(iconeDaCategoria(evento.categoria)),
        ),
        title: Text(evento.titulo),
        subtitle: Text('${evento.local} • ${evento.categoria}'),
        trailing: IconButton(
          tooltip: evento.inscrito ? 'Cancelar inscricao' : 'Inscrever-se',
          onPressed: onInscricao,
          icon: Icon(
            evento.inscrito ? Icons.check_circle : Icons.add_circle_outline,
          ),
        ),
      ),
    );
  }
}
