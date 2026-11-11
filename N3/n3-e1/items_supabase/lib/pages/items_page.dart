import 'package:flutter/material.dart';
import 'package:items_supabase/models/item.dart';
import 'package:items_supabase/widgets/evento_card.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key, required this.email});

  final String email;

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de itens')),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(24), child: Column(
          children: [ItemCard(item: Item(name: "teste", id: 1, userId: 'asd', createdAt: DateTime(2026)))],
        )),
      ),
    );
  }
}
