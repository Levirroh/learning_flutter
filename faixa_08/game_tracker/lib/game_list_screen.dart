import 'package:flutter/material.dart';

class GameListScreen extends StatelessWidget {
  const GameListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Card(shape: BeveledRectangleBorder(), child: Text("Jogo!")),
      ),
    );
  }
}
