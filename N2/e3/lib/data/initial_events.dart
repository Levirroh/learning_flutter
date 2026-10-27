import 'package:agenda_eventos/models/event.dart';

const categories = ["Todos", "Palestra", "Oficina", "Minicurso"];

List<Event> createInitialEvents() {
  return [
    Event(
      title: "Introdução ao Flutter",
      description: "Uma palestra sobre desenvolvimento de aplicativos com Flutter e Dart.",
      location: "Auditório principal",
      category: "Palestra",
      date: DateTime(2026, 11, 10),
    ),
    Event(
      title: "Git na prática",
      description: "Oficina para praticar commits, branches e trabalho em equipe usando Git.",
      location: "Laboratório 2",
      category: "Oficina",
      date: DateTime(2026, 11, 12),
      registered: true,
    ),
    Event(
      title: "Banco de dados",
      description:
          "Minicurso de modelagem de tabelas e consultas básicas em SQL.",
      location: "Laboratório 3",
      category: "Minicurso",
      date: DateTime(2026, 11, 14),
    ),
  ];
}
