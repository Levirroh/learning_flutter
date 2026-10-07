import 'package:flutter/material.dart';

import '../models/livro.dart';
import '../utils/categorias.dart';

class LivroCard extends StatelessWidget {
  const LivroCard({
    super.key,
    required this.livro,
    required this.onTap,
    required this.onFavorito,
  });

  final Livro livro;
  final VoidCallback onTap;
  final VoidCallback onFavorito;

  @override
  Widget build(BuildContext context) {
    // Card + ListTile e uma combinacao comum para itens de uma lista.
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(iconeDaCategoria(livro.categoria)),
        ),
        title: Text(livro.titulo),
        subtitle: Text('${livro.autor} • ${livro.categoria}'),
        trailing: IconButton(
          tooltip: 'Favorito',
          onPressed: onFavorito,
          icon: Icon(
            livro.favorito ? Icons.favorite : Icons.favorite_border,
          ),
        ),
      ),
    );
  }
}
