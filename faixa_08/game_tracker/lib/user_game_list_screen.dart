import 'package:flutter/material.dart';
import 'package:game_tracker/all_game_list_screen.dart';
import 'package:game_tracker/classes/game.dart';
import 'package:game_tracker/components/add_game_card_component.dart';
import 'package:game_tracker/components/game_card_component.dart';
import 'package:game_tracker/game_details_screen.dart';

class UserGameListScreen extends StatelessWidget {
  const UserGameListScreen({
    super.key,
    required this.userGames,
    required this.allGames,
    required this.onAddGame,
    required this.onUpdateGame,
  });

  final List<Game> userGames;
  final List<Game> allGames;

  final ValueChanged<Game> onAddGame;
  final ValueChanged<Game> onUpdateGame;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: userGames.length + 1,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 440,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 310,
        ),
        itemBuilder: (context, index) {
          if (index == 0) {
            return AddGameCardComponent(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllGameListScreen(
                      allGames: allGames,
                      userGames: userGames,
                      onAddGame: onAddGame,
                    ),
                  ),
                );
              },
            );
          }

          final game = userGames[index - 1];

          return GameCardComponent(
            game: game,
            rating: game.userRating,
            hoursPlayed: game.hoursPlayed,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameDetailsScreen(
                    game: game,
                    isUserGame: true,
                    onGameUpdated: onUpdateGame,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
