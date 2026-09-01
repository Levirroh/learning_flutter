import 'package:flutter/material.dart';
import 'package:game_tracker/classes/game.dart';
import 'package:game_tracker/components/info_box_component.dart';

class GameDetailsScreen extends StatefulWidget {
  const GameDetailsScreen({
    super.key,
    required this.game,
    this.isUserGame = false,
    this.showAddButton = false,
    this.onGameUpdated,
  });

  final Game game;
  final bool isUserGame;
  final bool showAddButton;
  final ValueChanged<Game>? onGameUpdated;

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  late TextEditingController reviewController;

  @override
  void initState() {
    super.initState();

    reviewController = TextEditingController(text: widget.game.userReview);
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  void increaseHours() {
    setState(() {
      widget.game.hoursPlayed++;
    });

    widget.onGameUpdated?.call(widget.game);
  }

  void decreaseHours() {
    if (widget.game.hoursPlayed <= 0) {
      return;
    }

    setState(() {
      widget.game.hoursPlayed--;
    });

    widget.onGameUpdated?.call(widget.game);
  }

  void increaseRating() {
    if (widget.game.userRating >= 10) {
      return;
    }

    setState(() {
      widget.game.userRating++;
    });

    widget.onGameUpdated?.call(widget.game);
  }

  void decreaseRating() {
    if (widget.game.userRating <= 0) {
      return;
    }

    setState(() {
      widget.game.userRating--;
    });

    widget.onGameUpdated?.call(widget.game);
  }

  void saveReview() {
    setState(() {
      widget.game.userReview = reviewController.text;
    });

    widget.onGameUpdated?.call(widget.game);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Análise salva!")));
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;

    return Scaffold(
      appBar: AppBar(title: Text(game.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  game.gameImage,
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              // Nome
              Text(
                game.name,
                style: Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 4),

              // Versão
              Text(
                "Versão ${game.version}",
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),

              const SizedBox(height: 16),

              // Descrição
              Text(
                game.descricao,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(height: 1.5),
              ),

              const SizedBox(height: 24),

              // Avaliação geral
              InfoBoxComponent(
                icon: Icons.people,
                title: "Avaliação geral",
                value: game.generalRating.toStringAsFixed(1),
              ),

              // Controles do usuário
              if (widget.isUserGame) ...[
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _EditableInfoBox(
                        icon: Icons.star,
                        title: "Sua avaliação",
                        value: game.userRating.toString(),
                        onDecrease: decreaseRating,
                        onIncrease: increaseRating,
                        canDecrease: game.userRating > 0,
                        canIncrease: game.userRating < 10,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _EditableInfoBox(
                        icon: Icons.schedule,
                        title: "Tempo jogado",
                        value: "${game.hoursPlayed}h",
                        onDecrease: decreaseHours,
                        onIncrease: increaseHours,
                        canDecrease: game.hoursPlayed > 0,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 24),

              // Plataformas
              Text(
                "Plataformas",
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: game.platform.map((platform) {
                  return Chip(label: Text(_formatPlatform(platform.name)));
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Categorias
              Text(
                "Categorias",
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: game.categories.map((category) {
                  return Chip(label: Text(_capitalize(category.name)));
                }).toList(),
              ),

              // Review do usuário
              if (widget.isUserGame) ...[
                const SizedBox(height: 24),

                Text(
                  "Minha análise",
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: reviewController,
                  minLines: 3,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Escreva sua análise sobre o jogo...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: saveReview,
                    icon: const Icon(Icons.save),
                    label: const Text("Salvar análise"),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Reviews gerais
              Text(
                "Avaliações da comunidade",
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              ...game.allReviews.map((review) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(review),
                  ),
                );
              }),

              // Adicionar jogo
              if (widget.showAddButton) ...[
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: widget.isUserGame
                        ? null
                        : () {
                            Navigator.pop(context, game);
                          },
                    icon: Icon(widget.isUserGame ? Icons.check : Icons.add),
                    label: Text(
                      widget.isUserGame
                          ? "Já está na sua lista"
                          : "Adicionar à minha lista",
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  static String _capitalize(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }

  static String _formatPlatform(String platform) {
    switch (platform) {
      case "pc":
        return "PC";

      case "playStation":
        return "PlayStation";

      case "xbox":
        return "Xbox";

      case "nintendoSwitch":
        return "Switch";

      default:
        return _capitalize(platform);
    }
  }
}

class _EditableInfoBox extends StatelessWidget {
  const _EditableInfoBox({
    required this.icon,
    required this.title,
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
    this.canDecrease = true,
    this.canIncrease = true,
  });

  final IconData icon;
  final String title;
  final String value;

  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  final bool canDecrease;
  final bool canIncrease;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, size: 28),

            const SizedBox(height: 8),

            Text(title, style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: canDecrease ? onDecrease : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),

                SizedBox(
                  width: 60,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: canIncrease ? onIncrease : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
