import 'package:flutter/material.dart';
import 'package:items_supabase/models/item.dart';
import 'package:items_supabase/widgets/evento_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key, required this.email});

  final String email;

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<Item> items = [];
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    items =
        (await supabase
                .from('items')
                .select('id, name, user_id, created_at')
                .order('created_at', ascending: false))
            .cast<Item>();
  }

  void _addItem(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de itens')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addItem,
        icon: const Icon(Icons.add),
        label: const Text('Novo evento'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: items.map((item) {
              return ItemCard(
                item: Item(
                  name: item.name,
                  id: item.id,
                  userId: item.userId,
                  createdAt: item.createdAt,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
