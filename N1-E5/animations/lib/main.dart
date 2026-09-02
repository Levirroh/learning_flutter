import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: const Text("Hello")
              .animate(
                delay:
                    1000.ms, // this delay only happens once at the very start
                onPlay: (controller) => controller.repeat(), // loop
              )
              .fadeIn(
                delay: 500.ms,
              ), // this delay happens at the start of each loop)),
        ),
      ),
    );
  }
}
