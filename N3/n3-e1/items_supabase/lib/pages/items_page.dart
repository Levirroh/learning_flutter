import 'package:flutter/material.dart';
import 'package:items_supabase/models/item.dart';
import 'package:items_supabase/pages/new_item_page.dart';
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

  late final user = supabase.auth.currentUser;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final response = await supabase
        .from('items')
        .select('id, name, user_id, created_at')
        .eq('user_id', user!.id)
        .order('created_at', ascending: false);

    if (!mounted) return;

    setState(() {
      items = response.map((row) => Item.fromJson(row)).toList();
    });
  }

  Future<void> _addItem() async {
    final item = await Navigator.push<Item>(
      context,
      MaterialPageRoute<Item>(
        builder: (_) => const ItemFormPageState(isEdit: false),
      ),
    );
    if (!mounted || item == null) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${item.name} cadastrado.')));
    _saveAddItem(item);
  }

  Future<void> _saveAddItem(Item item) async {
    final response = await supabase
        .from('items')
        .insert({'name': item.name, 'user_id': user!.id})
        .select()
        .single();

    if (!mounted) return;

    setState(() {
      items.insert(0, Item.fromJson(response));
    });
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
                onEdit: () {},
                onDelete: () {},
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
