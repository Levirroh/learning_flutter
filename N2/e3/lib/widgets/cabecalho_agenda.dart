import 'package:flutter/material.dart';

class CabecalhoAgenda extends StatelessWidget {
  const CabecalhoAgenda({
    super.key,
    required this.nomeUsuario,
    required this.total,
  });

  final String nomeUsuario;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(child: Icon(Icons.person)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ola, $nomeUsuario'),
                Text('$total eventos cadastrados'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
