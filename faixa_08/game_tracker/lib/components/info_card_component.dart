import 'package:flutter/material.dart';

class InfoCardComponent extends StatelessWidget {
  const InfoCardComponent({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [Icon(icon), Text(value), Text(label)]),
      ),
    );
  }
}
