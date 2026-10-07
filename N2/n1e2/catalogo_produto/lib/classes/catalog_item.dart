import 'package:flutter/material.dart';

class CatalogItem {
  final String name;
  final String description;
  final Color color;
  final double price;
  final int quantity;

  const CatalogItem({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.color,
  });
}
