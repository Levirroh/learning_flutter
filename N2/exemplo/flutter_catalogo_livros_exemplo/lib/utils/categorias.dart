import 'package:flutter/material.dart';

const List<String> categorias = [
  'Todos',
  'Tecnologia',
  'Fantasia',
  'Ficcao',
  'Design',
];

// Exemplo de Map<K, V>: cada chave de texto aponta para um IconData.
const Map<String, IconData> iconesCategorias = {
  'Tecnologia': Icons.computer,
  'Fantasia': Icons.auto_awesome,
  'Ficcao': Icons.rocket_launch,
  'Design': Icons.palette,
};

IconData iconeDaCategoria(String categoria) {
  // Uma busca em Map pode retornar null. O operador ?? fornece um padrao.
  return iconesCategorias[categoria] ?? Icons.menu_book;
}
