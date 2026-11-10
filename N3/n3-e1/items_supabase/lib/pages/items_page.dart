import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Agenda de Eventos')),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(24), child: Column()),
      ),
    );
  }
}
