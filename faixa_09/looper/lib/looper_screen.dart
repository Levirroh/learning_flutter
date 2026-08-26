import 'package:flutter/material.dart';

class LooperScreen extends StatelessWidget {
  const LooperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Looper"),
        backgroundColor: Colors.pink[200],
      ),
      body: Column(),
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
        backgroundColor: Colors.pink[200],
        label: Text("Add Track", style: TextStyle(color: Colors.grey[900])),
        icon: Icon(Icons.add, color: Colors.grey[900],),
      ),
    );
  }
}
