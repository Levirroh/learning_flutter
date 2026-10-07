import 'package:flutter/material.dart';

class CabecalhoCatalogo extends StatelessWidget {
  const CabecalhoCatalogo({
    super.key,
    required this.nomeUsuario,
    required this.total,
  });

  final String nomeUsuario;
  final int total;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    // Stack sobrepoe widgets DENTRO do layout.
    // Isso e diferente da pilha de rotas controlada pelo Navigator.
    return SizedBox(
      height: 126,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: cores.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned(
            right: 20,
            top: 18,
            child: Icon(
              Icons.local_library,
              size: 72,
              color: cores.primary.withValues(alpha: 0.25),
            ),
          ),
          Positioned(
            left: 20,
            top: 22,
            right: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ola, $nomeUsuario',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('$total livro(s) no catalogo'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
