import 'package:flutter/material.dart';
import 'package:catalogo_produto/main_screen.dart';

class LifecycleHistory extends StatelessWidget {
  const LifecycleHistory({super.key, required this.history});

  final ValueNotifier<List<String>> history;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ciclo de vida", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            ValueListenableBuilder<List<String>>(
              valueListenable: history,
              builder: (context, states, child) {
                if (states.isEmpty) {
                  return const Text(
                    "Aguardando o primeiro estado do aplicativo.",
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: states.asMap().entries.map((entry) {
                    return Text("${entry.key + 1}. ${entry.value}");
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
