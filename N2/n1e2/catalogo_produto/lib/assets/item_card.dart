import 'package:catalogo_produto/classes/catalog_item.dart';
import 'package:catalogo_produto/main_screen.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Produto item;
  final VoidCallback onTap;

  const ItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.casino, color: item.color, size: 40),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: item.color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${item.quantity}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "R\$ ${item.price.toStringAsFixed(2).replaceAll('.', ',')}",
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: "Detalhes de ${item.name}",
                onPressed: onTap,
                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
