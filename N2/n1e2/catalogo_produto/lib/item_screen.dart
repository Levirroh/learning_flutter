import 'package:catalogo_produto/classes/catalog_item.dart';
import 'package:catalogo_produto/main_screen.dart';
import 'package:flutter/material.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key, required this.item});

  final CatalogItem item;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Actions(actions: Navigator.pop(), child: Icon(Icons.add)),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.background,
        title: Container(
          width: 150,
          height: 40,
          alignment: AlignmentGeometry.center,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: widget.item.color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(widget.item.name, style: TextStyle(color: Colors.black)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.all(8),
                child: Text(
                  widget.item.description,
                  style: TextStyle(color: AppColors.textPrimary),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 50,
            children: [
              Text(
                "Preço: R\$ ${widget.item.price.toString()}",
                style: TextStyle(color: AppColors.textPrimary),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: Container(
                  width: 2,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Text(
                "Quantidade: ${widget.item.quantity.toString()}",
                style: TextStyle(color: AppColors.textPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
