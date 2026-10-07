import 'package:catalogo_produto/assets/item_card.dart';
import 'package:catalogo_produto/classes/catalog_item.dart';
import 'package:catalogo_produto/item_screen.dart';
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
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<CatalogItem> catalog = [
    CatalogItem(
      name: "War",
      description: "O War é um clássico jogo de tabuleiro de estratégia militar onde os participantes controlam exércitos coloridos com o objetivo de conquistar territórios em um mapa-múndi de 42 países.",
      color: Colors.redAccent,
      price: 118.91,
      quantity: 38,
    ),
    CatalogItem(
      name: "Monopoly",
      description: "Monopoly é um clássico jogo de tabuleiro de finanças e negociação onde os jogadores compram, vendem e alugam propriedades com o objetivo de levar os adversários à falência.",
      color: Colors.lightBlueAccent,
      price: 130.50,
      quantity: 23,
    ),
    CatalogItem(
      name: "Jogo da Vida",
      description: "Neste jogo, os participantes avançam por um caminho cheio de escolhas, profissões, casas, família e decisões financeiras até chegarem à aposentadoria.",
      color: Colors.greenAccent,
      price: 103.30,
      quantity: 17,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          "Catálogo",
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: catalog.length,
        itemBuilder: (context, index) {
          final item = catalog[index];
          return ItemCard(
            item: item,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => ItemScreen(item: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
