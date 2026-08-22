import 'package:flutter/material.dart';
import 'package:game_tracker/classes/game.dart';
import 'package:game_tracker/components/game_card_component.dart';

class AddGameScreen extends StatelessWidget {
  const AddGameScreen({
    super.key,
    required this.allGames,
    required this.userGames,
  });

  final List<Game> allGames;
  final List<Game> userGames;

  @override
  Widget build(BuildContext context) {
    final availableGames = allGames.where((game) {
      return !userGames.any((userGame) => userGame.name == game.name);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar jogo")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: availableGames.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 440,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 310,
          ),
          itemBuilder: (context, index) {
            final game = availableGames[index];

            return GameCardComponent(
              game: game,
              rating: game.generalRating,
              onTap: () {
                Navigator.pop(context, game);
              },
            );
          },
        ),
      ),
    );
  }
}
