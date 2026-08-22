import 'package:game_tracker/enums/game_category_enum.dart';
import 'package:game_tracker/enums/game_platform_enum.dart';

class Game {
  // Dados globais
  final String name;
  final String gameImage;
  final List<GameCategoryEnum> categories;
  final List<GamePlatformEnum> platform;
  final String descricao;
  final int generalRating;
  final List<String> allReviews;
  final String version;

  // Dados do usuário
  int hoursPlayed;
  int userRating;
  String userReview;

  Game({
    required this.name,
    required this.gameImage,
    required this.categories,
    required this.platform,
    required this.descricao,
    required this.version,
    required this.generalRating,
    required this.allReviews,
    this.hoursPlayed = 0,
    this.userRating = 0,
    this.userReview = "",
  });
}
