import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:game_tracker/classes/game.dart';
import 'package:game_tracker/components/info_box_component.dart';

class ChartStatisticsScreen extends StatelessWidget {
  const ChartStatisticsScreen({super.key, required this.games});

  final List<Game> games;

  int get totalHours {
    return games.fold(0, (total, game) => total + game.hoursPlayed);
  }

  double get averageRating {
    if (games.isEmpty) {
      return 0;
    }

    return games.fold(0, (total, game) => total + game.userRating) /
        games.length;
  }

  Game? get mostPlayedGame {
    if (games.isEmpty) {
      return null;
    }

    return games.reduce(
      (current, next) =>
          current.hoursPlayed > next.hoursPlayed ? current : next,
    );
  }

  Game? get bestRatedGame {
    if (games.isEmpty) {
      return null;
    }

    return games.reduce(
      (current, next) => current.userRating > next.userRating ? current : next,
    );
  }

  double get maxHours {
    if (games.isEmpty) {
      return 10;
    }

    final highestHours = games.map((game) => game.hoursPlayed).reduce(max);

    return (highestHours + 20).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) {
      return const Center(
        child: Text(
          "Adicione jogos à sua coleção para visualizar as estatísticas.",
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Estatísticas",
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Text(
              "Um resumo da sua coleção",
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // Informações calculadas
            Row(
              children: [
                Expanded(
                  child: InfoBoxComponent(
                    icon: Icons.schedule,
                    title: "Total de horas",
                    value: "${totalHours}h",
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: InfoBoxComponent(
                    icon: Icons.star,
                    title: "Média das avaliações",
                    value: averageRating.toStringAsFixed(1),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: InfoBoxComponent(
                    icon: Icons.timer,
                    title: "Mais jogado",
                    value: mostPlayedGame!.name,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: InfoBoxComponent(
                    icon: Icons.emoji_events,
                    title: "Mais bem avaliado",
                    value: bestRatedGame!.name,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Text(
              "Horas jogadas por jogo",
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: SizedBox(
                  height: 350,
                  child: BarChart(
                    BarChartData(
                      maxY: maxHours,

                      barTouchData: BarTouchData(enabled: true),

                      gridData: const FlGridData(show: true),

                      borderData: FlBorderData(show: false),

                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),

                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                          ),
                        ),

                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();

                              if (index < 0 || index >= games.length) {
                                return const SizedBox();
                              }

                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  _shortName(games[index].name),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      barGroups: List.generate(games.length, (index) {
                        final game = games[index];

                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: game.hoursPlayed.toDouble(),
                              width: 22,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(6),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _shortName(String name) {
    if (name.length <= 10) {
      return name;
    }

    return "${name.substring(0, 8)}...";
  }
}
