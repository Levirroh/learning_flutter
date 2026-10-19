import 'package:catalogo_produto/assets/lifecycle_history.dart';
import 'package:catalogo_produto/classes/catalog_item.dart';
import 'package:catalogo_produto/main_screen.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key, required this.item, required this.history});

  final Produto item;
  final ValueNotifier<List<String>> history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.background,
        title: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(item.name, style: const TextStyle(color: Colors.black)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(item.description),
          ),
          const SizedBox(height: 16),
          Text(
            "Preço: R\$ ${item.price.toStringAsFixed(2).replaceAll('.', ',')}",
          ),
          const SizedBox(height: 8),
          Text("Quantidade disponível: ${item.quantity}"),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text("Voltar ao catálogo"),
          ),
          const SizedBox(height: 24),
          LifecycleHistory(history: history),
        ],
      ),
    );
  }
}
