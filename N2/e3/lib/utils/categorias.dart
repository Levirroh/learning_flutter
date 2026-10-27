import 'package:flutter/material.dart';

const categorias = <String>[
  'Todos',
  'Tecnologia',
  'Jogos',
  'Carreira',
  'Pesquisa',
];

IconData iconeDaCategoria(String categoria) {
  switch (categoria) {
    case 'Tecnologia':
      return Icons.memory;
    case 'Jogos':
      return Icons.sports_esports;
    case 'Carreira':
      return Icons.work_outline;
    case 'Pesquisa':
      return Icons.science_outlined;
    default:
      return Icons.event;
  }
}
