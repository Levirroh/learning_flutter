import 'package:flutter/material.dart';
import 'package:game_tracker/classes/game.dart';
import 'package:game_tracker/enums/game_platform_enum.dart';

class GameCardComponent extends StatelessWidget {
  const GameCardComponent({
    super.key,
    required this.game,
    required this.rating,
    required this.onTap,
    this.hoursPlayed,
  });

  final Game game;
  final int rating;
  final int? hoursPlayed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: Image.asset(game.gameImage, fit: BoxFit.cover),
                ),

                Positioned(
                  top: 10,
                  left: 10,
                  child: Wrap(
                    spacing: 6,
                    children: [
                      ...game.platform.take(2).map((platform) {
                        return PlatformBadge(platform: platform);
                      }),

                      if (game.platform.length > 2)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.65),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "+",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            game.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        if (hoursPlayed != null) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.schedule, size: 16),
                          const SizedBox(width: 4),
                          Text("${hoursPlayed}h"),
                        ],
                      ],
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        const Icon(Icons.star, size: 16),
                        const SizedBox(width: 4),
                        Text(rating.toStringAsFixed(1)),

                        const Spacer(),

                        Text(
                          mainCategory(),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String mainCategory() {
    if (game.categories.isEmpty) {
      return "Sem gênero";
    }

    final category = game.categories.first.name;

    return category[0].toUpperCase() + category.substring(1);
  }
}

class PlatformBadge extends StatelessWidget {
  const PlatformBadge({super.key, required this.platform});

  final GamePlatformEnum platform;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(platformIcon(), color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            platformName(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData platformIcon() {
    switch (platform) {
      case GamePlatformEnum.pc:
        return Icons.computer;

      case GamePlatformEnum.playStation:
      case GamePlatformEnum.xbox:
      case GamePlatformEnum.nintendoSwitch:
        return Icons.sports_esports;
    }
  }

  String platformName() {
    switch (platform) {
      case GamePlatformEnum.pc:
        return "PC";

      case GamePlatformEnum.playStation:
        return "PS";

      case GamePlatformEnum.xbox:
        return "Xbox";

      case GamePlatformEnum.nintendoSwitch:
        return "Switch";
    }
  }
}
