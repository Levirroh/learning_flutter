import 'package:flutter/material.dart';

class Item {
  final String id;
  final String name;
  final Color userId;
  final double createdAt;

  const Item({
    required this.name,
    required this.id,
    required this.userId,
    required this.createdAt,
  });
}
