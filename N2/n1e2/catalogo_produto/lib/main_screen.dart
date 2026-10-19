import 'package:catalogo_produto/assets/item_card.dart';
import 'package:catalogo_produto/classes/catalog_item.dart';
import 'package:catalogo_produto/item_screen.dart';
import 'package:catalogo_produto/assets/lifecycle_history.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color background = Color(0xFF161616);
  static const Color surface = Color(0xFF222222);
  static const Color surfaceLight = Color(0xFF2C2C2C);

  static const Color primary = Color(0xFFDA70D6);
  static const Color secondary = Color(0xFF7A1F77);

  static const Color textPrimary = Color(0xFFF2F2F2);
  static const Color textSecondary = Color(0xFFAFAFAF);

  static const Color divider = Color(0xFF3A3A3A);
  static const Color done = Color(0xFFBFE59A);
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.history});

  final ValueNotifier<List<String>> history;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Produto> catalog = [
    Produto(
      name: "War",
      description: "O War é um clássico jogo de tabuleiro de estratégia militar onde os participantes controlam exércitos coloridos com o objetivo de conquistar territórios em um mapa-múndi de 42 países.",
      color: Colors.redAccent,
      price: 118.91,
      quantity: 38,
    ),
    Produto(
      name: "Monopoly",
      description: "Monopoly é um clássico jogo de tabuleiro de finanças e negociação onde os jogadores compram, vendem e alugam propriedades com o objetivo de levar os adversários à falência.",
      color: Colors.lightBlueAccent,
      price: 130.50,
      quantity: 23,
    ),
    Produto(
      name: "Jogo da Vida",
      description: "Neste jogo, os participantes avançam por um caminho cheio de escolhas, profissões, casas, família e decisões financeiras até chegarem à aposentadoria.",
      color: Colors.greenAccent,
      price: 103.30,
      quantity: 17,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cards = catalog.map((item) {
      return ItemCard(
        item: item,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) =>
                  ItemScreen(item: item, history: widget.history),
            ),
          );
        },
      );
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          "Catálogo",
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...cards,
          const SizedBox(height: 12),
          const Transformations(),
          const SizedBox(height: 24),
          LifecycleHistory(history: widget.history),
        ],
      ),
    );
  }
}

class Transformations extends StatelessWidget {
  const Transformations({super.key});

  @override
  Widget build(BuildContext context) {
    final numbers = [1, 2, 3, 4, 5];
    final List<String> strings = numbers
        .map((number) => number.toString())
        .toList();
    final doubled = numbers.map((number) => number * 2).toList();
    final words = ["Flutter", "é", "incrível"];
    final names = ["Ana", "Bruno", "Carlos"];

    return Card(
      color: AppColors.surface,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Transformações", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Text("Lista original: $numbers"),
            Text('Strings: [${strings.map((value) => '"$value"').join(', ')}]'),
            Text("Multiplicados por 2: $doubled"),
            const SizedBox(height: 16),
            const Text("Palavras em widgets Text:"),
            Wrap(
              spacing: 6,
              children: words.map((word) => Text(word)).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Botões a partir de nomes:"),
            Wrap(
              spacing: 8,
              children: names.map((name) {
                return ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Você selecionou $name")),
                    );
                  },
                  child: Text(name),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
