import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_tracker/classes/game.dart';
import 'package:game_tracker/components/game_card_component.dart';
import 'package:game_tracker/components/info_card_component.dart';
import 'package:game_tracker/game_details_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.totalHours,
    required this.games,
    required this.allGames,
    required this.onAddGame,
  });

  final int totalHours;
  final List<Game> games;
  final List<Game> allGames;
  final ValueChanged<Game> onAddGame;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Game? recommendedGame;
  Game? recommendedNewGame;

  double get averageRating {
    if (widget.games.isEmpty) {
      return 0;
    }

    return widget.games.fold(0.0, (total, game) => total + game.userRating) /
        widget.games.length;
  }

  List<Game> get availableGames {
    return widget.allGames.where((game) {
      return !widget.games.any((userGame) => userGame.name == game.name);
    }).toList();
  }

  void randomGame() {
    if (widget.games.isEmpty) {
      return;
    }

    final random = Random();

    setState(() {
      recommendedGame = widget.games[random.nextInt(widget.games.length)];
    });
  }

  void randomNewGame() {
    final games = availableGames;

    if (games.isEmpty) {
      return;
    }

    final random = Random();

    setState(() {
      recommendedNewGame = games[random.nextInt(games.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Cabeçalho
                Column(
                  children: [
                    Text(
                      "TrackerMania",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Sua coleção de jogos",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Resumo
                Text(
                  "Visão geral",
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                LayoutBuilder(
                  builder: (context, constraints) {
                    double cardWidth;

                    if (constraints.maxWidth >= 750) {
                      cardWidth = (constraints.maxWidth - 24) / 3;
                    } else if (constraints.maxWidth >= 500) {
                      cardWidth = (constraints.maxWidth - 12) / 2;
                    } else {
                      cardWidth = constraints.maxWidth;
                    }

                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: InfoCardComponent(
                            icon: Icons.sports_esports,
                            value: "${widget.games.length}",
                            label: "Jogos",
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: InfoCardComponent(
                            icon: Icons.schedule,
                            value: "${widget.totalHours}h",
                            label: "Horas jogadas",
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: InfoCardComponent(
                            icon: Icons.star,
                            value: averageRating.toStringAsFixed(1),
                            label: "Avaliação média",
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 40),

                Text(
                  "Recomendações",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                Text(
                  "Não sabe o que abrir hoje? Deixa o TrackerMania decidir.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 20),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final bool sideBySide = constraints.maxWidth >= 850;

                    final double sectionWidth = sideBySide
                        ? (constraints.maxWidth - 16) / 2
                        : constraints.maxWidth;

                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        SizedBox(
                          width: sectionWidth,
                          child: _RecommendationSection(
                            icon: Icons.casino,
                            title: "O que jogar?",
                            description:
                                "Sorteie um jogo que já está na sua coleção.",
                            buttonText: recommendedGame == null
                                ? "Sortear jogo"
                                : "Sortear novamente",
                            onPressed: widget.games.isEmpty ? null : randomGame,
                            child: recommendedGame == null
                                ? null
                                : SizedBox(
                                    height: 310,
                                    child: GameCardComponent(
                                      game: recommendedGame!,
                                      rating: recommendedGame!.userRating,
                                      hoursPlayed: recommendedGame!.hoursPlayed,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GameDetailsScreen(
                                                  game: recommendedGame!,
                                                  isUserGame: true,
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(
                          width: sectionWidth,
                          child: _RecommendationSection(
                            icon: Icons.auto_awesome,
                            title: "Quer algo novo?",
                            description: "Descubra um jogo que ainda não faz parte da sua coleção.",
                            buttonText: recommendedNewGame == null
                                ? "Descobrir jogo"
                                : "Descobrir outro",
                            onPressed: availableGames.isEmpty
                                ? null
                                : randomNewGame,
                            emptyMessage: availableGames.isEmpty
                                ? "Você já adicionou todos os jogos disponíveis!"
                                : null,
                            child: recommendedNewGame == null
                                ? null
                                : SizedBox(
                                    height: 310,
                                    child: GameCardComponent(
                                      game: recommendedNewGame!,
                                      rating: recommendedNewGame!.generalRating,
                                      onTap: () async {
                                        final game = await Navigator.push<Game>(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GameDetailsScreen(
                                                  game: recommendedNewGame!,
                                                  showAddButton: true,
                                                ),
                                          ),
                                        );

                                        if (game != null) {
                                          widget.onAddGame(game);

                                          setState(() {
                                            recommendedNewGame = null;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecommendationSection extends StatelessWidget {
  const _RecommendationSection({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    this.child,
    this.emptyMessage,
  });

  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: FilledButton.icon(
                onPressed: onPressed,
                icon: Icon(icon),
                label: Text(buttonText),
              ),
            ),

            if (emptyMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                emptyMessage!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],

            if (child != null) ...[const SizedBox(height: 20), child!],
          ],
        ),
      ),
    );
  }
}
