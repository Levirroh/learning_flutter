import 'package:flutter/material.dart';

import 'screens/entrada_screen.dart';

class AppExemplo extends StatelessWidget {
  const AppExemplo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca de Bolso',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      // A primeira rota do app e a tela de entrada.
      // Nesta aula, a navegacao sera feita de forma explicita com Navigator
      // + MaterialPageRoute, em vez de rotas nomeadas.
      home: const EntradaScreen(),
    );
  }
}
