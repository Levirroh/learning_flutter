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
      body: Column(children: []),
    );
  }
}
