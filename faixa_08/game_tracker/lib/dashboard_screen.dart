import 'package:flutter/material.dart';
import 'package:game_tracker/classes/game.dart';
import 'package:game_tracker/components/info_card_component.dart';
import 'package:game_tracker/components/recommendation_card_component.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.totalHours,
    required this.games,
  });

  final int totalHours;
  final List<Game> games;

  double get averageRating =>
      games.fold(0.0, (total, game) => total + game.rating) / games.length;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text("TrackerMania"),
            Text("Sua coleção de jogos"),
            Row(
              children: [
                Expanded(
                  child: InfoCardComponent(
                    icon: Icons.sports_esports,
                    value: '${games.length}',
                    label: "Jogos",
                  ),
                ),
                Expanded(
                  child: InfoCardComponent(
                    icon: Icons.schedule,
                    value: '${totalHours}h',
                    label: "Horas Jogadas",
                  ),
                ),
              ],
            ),
            InfoCardComponent(
              icon: Icons.star,
              value: averageRating.toString(),
              label: "Avaliação média",
            ),
            Text("O que jogar?"),
            RecommendationCardComponent(),
          ],
        ),
      ),
    );
  }
}
