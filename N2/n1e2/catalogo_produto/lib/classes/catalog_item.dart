import 'package:flutter/material.dart';

class Produto {
  final String name;
  final String description;
  final Color color;
  final double price;
  final int quantity;

  const Produto({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.color,
  });
}
