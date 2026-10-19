class Evento {
  final String titulo;
  final String descricao;
  final String local;
  final String categoria;
  final DateTime data;
  bool inscrito;

  Evento({
    required this.titulo,
    required this.descricao,
    required this.local,
    required this.categoria,
    required this.data,
    this.inscrito = false,
  });

  String get dataFormatada {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    return "$dia/$mes/${data.year}";
  }
}
