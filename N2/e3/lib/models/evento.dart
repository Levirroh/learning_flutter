class Evento {
  Evento({
    required this.id,
    required this.titulo,
    required this.local,
    required this.categoria,
    required this.descricao,
    this.inscrito = false,
  });

  final int id;
  final String titulo;
  final String local;
  final String categoria;
  final String descricao;

  // Estado simples mantido apenas em memoria neste exemplo.
  bool inscrito;
}
