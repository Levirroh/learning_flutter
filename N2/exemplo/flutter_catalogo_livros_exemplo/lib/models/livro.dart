class Livro {
  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.categoria,
    required this.descricao,
    this.favorito = false,
    this.lido = false,
  });

  final int id;
  final String titulo;
  final String autor;
  final String categoria;
  final String descricao;

  // Para este projeto didatico, estes dois estados ficam em memoria.
  // Fechar o processo do app pode apagar essas alteracoes.
  bool favorito;
  bool lido;
}
