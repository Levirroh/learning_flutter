import 'package:flutter/material.dart';

class InfoBoxComponent extends StatelessWidget {
  const InfoBoxComponent({super.key, 
    required this.icon,
    required this.title,
    required this.value,
    this.fontSize
  });

  final IconData icon;
  final String title;
  final String value;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 28),

            const SizedBox(height: 8),

            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
