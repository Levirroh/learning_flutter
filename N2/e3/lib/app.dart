import 'package:flutter/material.dart';

import 'screens/entrada_screen.dart';

class AgendaEventosApp extends StatelessWidget {
  const AgendaEventosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda de Eventos',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const EntradaScreen(),
    );
  }
}
