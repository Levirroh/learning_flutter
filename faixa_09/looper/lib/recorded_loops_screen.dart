import 'package:flutter/material.dart';

class RecordedLoopsScreen extends StatelessWidget {
  const RecordedLoopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recorded Loops"),
        backgroundColor: Colors.pink[200],
      ),
      backgroundColor: Colors.grey[900],
      body: Text("Recorded Loops"),
    );
  }
}
