import 'package:flutter/material.dart';
import 'package:game_tracker/classes/game.dart';
import 'package:game_tracker/components/game_card_component.dart';
import 'package:game_tracker/game_details_screen.dart';

class AllGameListScreen extends StatefulWidget {
  const AllGameListScreen({
    super.key,
    required this.allGames,
    required this.userGames,
    required this.onAddGame,
  });

  final List<Game> allGames;
  final List<Game> userGames;
  final ValueChanged<Game> onAddGame;

  @override
  State<AllGameListScreen> createState() => _AllGameListScreenState();
}

class _AllGameListScreenState extends State<AllGameListScreen> {
  bool getIsUserGame(Game game) {
    return widget.userGames.any(
      (userGame) => userGame.name == game.name,
    );
  }

  Game getGameDetails(Game game) {
    if (getIsUserGame(game)) {
      return widget.userGames.firstWhere(
        (userGame) => userGame.name == game.name,
      );
    }

    return game;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos os jogos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: widget.allGames.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 440,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 310,
          ),
          itemBuilder: (context, index) {
            final game = widget.allGames[index];
            final isUserGame = getIsUserGame(game);

            return GameCardComponent(
              game: game,
              rating: game.generalRating,
              onTap: () async {
                final selectedGame = await Navigator.push<Game>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameDetailsScreen(
                      game: getGameDetails(game),
                      isUserGame: isUserGame,
                      showAddButton: true,
                    ),
                  ),
                );

                if (selectedGame != null) {
                  widget.onAddGame(selectedGame);

                  setState(() {});
                }
              },
            );
          },
        ),
      ),
    );
  }
}