import 'package:agenda_eventos/models/evento.dart';

const categorias = ["Todos", "Palestra", "Oficina", "Minicurso"];

List<Evento> criarEventosIniciais() {
  return [
    Evento(
      titulo: "Introdução ao Flutter",
      descricao: "Uma palestra sobre desenvolvimento de aplicativos com Flutter e Dart.",
      local: "Auditório principal",
      categoria: "Palestra",
      data: DateTime(2026, 11, 10),
    ),
    Evento(
      titulo: "Git na prática",
      descricao: "Oficina para praticar commits, branches e trabalho em equipe usando Git.",
      local: "Laboratório 2",
      categoria: "Oficina",
      data: DateTime(2026, 11, 12),
      inscrito: true,
    ),
    Evento(
      titulo: "Banco de dados",
      descricao:
          "Minicurso de modelagem de tabelas e consultas básicas em SQL.",
      local: "Laboratório 3",
      categoria: "Minicurso",
      data: DateTime(2026, 11, 14),
    ),
  ];
}
