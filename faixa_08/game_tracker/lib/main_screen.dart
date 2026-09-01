import 'package:flutter/material.dart';
import 'package:game_tracker/chart_statistics_screen.dart';
import 'package:game_tracker/classes/game.dart';
import 'package:game_tracker/dashboard_screen.dart';
import 'package:game_tracker/enums/game_category_enum.dart';
import 'package:game_tracker/enums/game_platform_enum.dart';
import 'package:game_tracker/user_game_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 1;

  final List<Game> userGames = [
    Game(
      name: "Hollow Knight",
      gameImage: "assets/images/hk.jpg",
      categories: [GameCategoryEnum.action, GameCategoryEnum.adventure],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Explore Hallownest, um vasto reino subterrâneo em ruínas, enfrente criaturas corrompidas, descubra novas habilidades e desvende os segredos de uma antiga civilização.",
      version: "1.5.78.11833a",

      generalRating: 9,
      allReviews: [
        "Atmosfera incrível e exploração muito bem construída.",
        "Um dos melhores metroidvanias que já joguei.",
        "Os chefes são difíceis, mas extremamente satisfatórios.",
      ],

      hoursPlayed: 127,
      userRating: 10,
      userReview: "Jogo muito bom, pena que eu enlouqueci em algum momento entre o começo e o final.",
    ),

    Game(
      name: "MIO: Memories in Orbit",
      gameImage: "assets/images/mio.jpg",
      categories: [GameCategoryEnum.action, GameCategoryEnum.adventure],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Controle MIO, um robô que desperta em uma gigantesca arca tecnológica em decadência. Explore ambientes interligados, adquira novas habilidades e descubra as memórias da Nau.",
      version: "Patch 2",

      generalRating: 8,
      allReviews: [
        "Direção artística muito bonita.",
        "A exploração é divertida e o movimento é bem fluido.",
        "Algumas áreas podem ficar um pouco confusas.",
      ],

      hoursPlayed: 23,
      userRating: 8,
      userReview: "Legal, muito bom pra quem gosta de lore confusa.",
    ),

    Game(
      name: "Scrutinized",
      gameImage: "assets/images/scrutinized.jpg",
      categories: [
        GameCategoryEnum.simulation,
        GameCategoryEnum.horror,
        GameCategoryEnum.puzzle,
      ],
      platform: [GamePlatformEnum.pc],
      descricao: "Investigue cidadãos utilizando relatórios policiais, celulares, redes sociais, registros públicos e outras evidências digitais para identificar possíveis criminosos enquanto tenta sobreviver às ameaças fora do computador.",
      version: "1.2.0",

      generalRating: 8,
      allReviews: [
        "Uma mistura muito interessante de investigação e terror.",
        "Investigar os suspeitos é extremamente divertido.",
        "O jogo consegue deixar tarefas simples muito tensas.",
      ],

      hoursPlayed: 40,
      userRating: 9,
      userReview: "Não jogue à noite.",
    ),

    Game(
      name: "Shadows of Doubt",
      gameImage: "assets/images/sd.jpg",
      categories: [
        GameCategoryEnum.puzzle,
        GameCategoryEnum.simulation,
        GameCategoryEnum.adventure,
      ],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
      ],
      descricao: "Assuma o papel de um investigador particular em uma cidade procedural onde cada cidadão possui sua própria rotina. Investigue assassinatos, reúna evidências e persiga criminosos.",
      version: "1.0",

      generalRating: 9,
      allReviews: [
        "A liberdade para investigar crimes é absurda.",
        "Cada caso parece uma pequena história criada pelo próprio jogador.",
        "A simulação da cidade é uma das partes mais interessantes.",
      ],

      hoursPlayed: 30,
      userRating: 10,
      userReview: "Bom pra caralho, a experiência de ativar o modo personalizado de ser um rato + ter um caracol imortal atrás de você enquanto você investiga crimes, tem que ser uma das experiências mais fortes do mundo.",
    ),

    Game(
      name: "Sons of The Forest",
      gameImage: "assets/images/stf.jpg",
      categories: [
        GameCategoryEnum.action,
        GameCategoryEnum.adventure,
        GameCategoryEnum.simulation,
        GameCategoryEnum.horror,
      ],
      platform: [GamePlatformEnum.pc],
      descricao: "Enviado para encontrar um bilionário desaparecido, você acaba preso em uma ilha dominada por canibais e criaturas mutantes. Explore, construa, fabrique equipamentos e sobreviva sozinho ou em cooperação.",
      version: "1.0",

      generalRating: 8,
      allReviews: [
        "Construir bases com amigos é a melhor parte.",
        "O mapa é enorme e muito bonito.",
        "A sobrevivência poderia ser um pouco mais profunda.",
      ],

      hoursPlayed: 33,
      userRating: 7,
      userReview: "Jogo bom, mas a lore consegue ser pior que o primeiro, além de ser muito confuso, mas eu ri muito várias vezes.",
    ),

    Game(
      name: "Species: Unknown",
      gameImage: "assets/images/sunknown.jpg",
      categories: [
        GameCategoryEnum.horror,
        GameCategoryEnum.action,
        GameCategoryEnum.strategy,
      ],
      platform: [GamePlatformEnum.pc],
      descricao: "Survival horror cooperativo para até quatro jogadores em que mercenários realizam contratos dentro de uma nave abandonada enquanto são perseguidos por criaturas desconhecidas.",
      version: "Early Access",

      generalRating: 8,
      allReviews: [
        "Muito divertido jogando em grupo.",
        "A criatura torna cada partida imprevisível.",
        "Ainda precisa de mais conteúdo, mas a ideia é excelente.",
      ],

      hoursPlayed: 26,
      userRating: 10,
      userReview: "Muito bom, jogo fácil de ficar lá por horas jogando e não perceber, early acess, então eu passo pano pra algumas coisas, mas tem menos bug que a maioria dos jogos já.",
    ),

    Game(
      name: "Hollow Knight: Silksong",
      gameImage: "assets/images/hksilksong.jpg",
      categories: [GameCategoryEnum.action, GameCategoryEnum.adventure],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Controle Hornet em sua jornada por Pharloom, um novo reino de insetos repleto de inimigos, chefes, ferramentas e regiões interligadas enquanto ela ascende em uma perigosa peregrinação.",
      version: "Atual",

      generalRating: 9,
      allReviews: [
        "O movimento da Hornet deixa a exploração extremamente dinâmica.",
        "Pharloom é enorme e cheio de segredos.",
        "Uma excelente evolução das ideias do primeiro jogo.",
      ],

      hoursPlayed: 119,
      userRating: 9,
      userReview: "Jogasso, não tem muito o que falar, só dei 9 invés de 10 pq fiquei com vontade mesmo.",
    ),

    Game(
      name: "Subnautica",
      gameImage: "assets/images/subnautica.jpg",
      categories: [GameCategoryEnum.adventure, GameCategoryEnum.simulation],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Após cair no planeta oceânico 4546B, explore um enorme mundo submarino alienígena, colete recursos, construa bases e veículos e descubra o que aconteceu com o planeta.",
      version: "2.0",

      generalRating: 9,
      allReviews: [
        "Explorar as profundezas é fascinante e assustador.",
        "A progressão através dos diferentes biomas é excelente.",
        "Poucos jogos conseguem transmitir tão bem a sensação de exploração.",
      ],

      hoursPlayed: 63,
      userRating: 9,
      userReview: "Loucura que já faz muito tempo que esse jogo lançou, e tu ainda consegue sair voando 800 metros acima da água com 2 comandos ao mesmo tempo.",
    ),
  ];

  final List<Game> allGames = [
    Game(
      name: "Hollow Knight",
      gameImage: "assets/images/hk.jpg",
      categories: [GameCategoryEnum.action, GameCategoryEnum.adventure],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Explore Hallownest, um vasto reino subterrâneo em ruínas, enfrente criaturas corrompidas e descubra os segredos de uma antiga civilização.",
      version: "1.5.78.11833a",
      generalRating: 9,
      allReviews: [
        "Atmosfera incrível e exploração muito bem construída.",
        "Um dos melhores metroidvanias que já joguei.",
        "Os chefes são difíceis, mas extremamente satisfatórios.",
      ],
    ),

    Game(
      name: "MIO: Memories in Orbit",
      gameImage: "assets/images/mio.jpg",
      categories: [GameCategoryEnum.action, GameCategoryEnum.adventure],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Explore uma imensa arca tecnológica em decadência enquanto recupera as memórias perdidas de MIO e desenvolve novas habilidades.",
      version: "Patch 2",
      generalRating: 8,
      allReviews: [
        "Direção artística muito bonita.",
        "A exploração é divertida e o movimento é bem fluido.",
        "Algumas áreas podem ficar um pouco confusas.",
      ],
    ),

    Game(
      name: "Scrutinized",
      gameImage: "assets/images/scrutinized.jpg",
      categories: [
        GameCategoryEnum.simulation,
        GameCategoryEnum.horror,
        GameCategoryEnum.puzzle,
      ],
      platform: [GamePlatformEnum.pc],
      descricao: "Investigue cidadãos por meio de registros digitais enquanto tenta identificar criminosos e sobreviver às ameaças ao seu redor.",
      version: "1.2.0",
      generalRating: 8,
      allReviews: [
        "Uma mistura muito interessante de investigação e terror.",
        "Investigar os suspeitos é extremamente divertido.",
        "O jogo consegue deixar tarefas simples muito tensas.",
      ],
    ),

    Game(
      name: "Shadows of Doubt",
      gameImage: "assets/images/sd.jpg",
      categories: [
        GameCategoryEnum.puzzle,
        GameCategoryEnum.simulation,
        GameCategoryEnum.adventure,
      ],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
      ],
      descricao: "Resolva assassinatos em uma cidade procedural onde cada cidadão possui rotina, residência, emprego e relacionamentos próprios.",
      version: "1.0",
      generalRating: 9,
      allReviews: [
        "A liberdade para investigar crimes é absurda.",
        "Cada caso parece uma pequena história criada pelo próprio jogador.",
        "A simulação da cidade é uma das partes mais interessantes.",
      ],
    ),

    Game(
      name: "Sons of The Forest",
      gameImage: "assets/images/stf.jpg",
      categories: [
        GameCategoryEnum.action,
        GameCategoryEnum.adventure,
        GameCategoryEnum.simulation,
        GameCategoryEnum.horror,
      ],
      platform: [GamePlatformEnum.pc],
      descricao: "Explore uma ilha hostil, construa abrigos e tente sobreviver a canibais e criaturas mutantes.",
      version: "1.0",
      generalRating: 8,
      allReviews: [
        "Construir bases com amigos é a melhor parte.",
        "O mapa é enorme e muito bonito.",
        "A sobrevivência poderia ser um pouco mais profunda.",
      ],
    ),

    Game(
      name: "Species: Unknown",
      gameImage: "assets/images/sunknown.jpg",
      categories: [
        GameCategoryEnum.horror,
        GameCategoryEnum.action,
        GameCategoryEnum.strategy,
      ],
      platform: [GamePlatformEnum.pc],
      descricao: "Realize contratos em uma nave espacial abandonada enquanto uma criatura desconhecida caça sua equipe.",
      version: "Early Access",
      generalRating: 8,
      allReviews: [
        "Muito divertido jogando em grupo.",
        "A criatura torna cada partida imprevisível.",
        "Ainda precisa de mais conteúdo, mas a ideia é excelente.",
      ],
    ),

    Game(
      name: "Hollow Knight: Silksong",
      gameImage: "assets/images/hksilksong.jpg",
      categories: [GameCategoryEnum.action, GameCategoryEnum.adventure],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Controle Hornet em uma perigosa peregrinação através do reino de Pharloom.",
      version: "Atual",
      generalRating: 9,
      allReviews: [
        "O movimento da Hornet deixa a exploração extremamente dinâmica.",
        "Pharloom é enorme e cheio de segredos.",
        "Uma excelente evolução das ideias do primeiro jogo.",
      ],
    ),

    Game(
      name: "Subnautica",
      gameImage: "assets/images/subnautica.jpg",
      categories: [GameCategoryEnum.adventure, GameCategoryEnum.simulation],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Explore o planeta oceânico 4546B, construa bases e veículos e descubra os mistérios escondidos em suas profundezas.",
      version: "2.0",
      generalRating: 9,
      allReviews: [
        "Explorar as profundezas é fascinante e assustador.",
        "A progressão através dos diferentes biomas é excelente.",
        "Poucos jogos conseguem transmitir tão bem a sensação de exploração.",
      ],
    ),

    Game(
      name: "The Forest",
      gameImage: "assets/images/the_forest.jpg",
      categories: [
        GameCategoryEnum.horror,
        GameCategoryEnum.adventure,
        GameCategoryEnum.action,
        GameCategoryEnum.simulation,
      ],
      platform: [GamePlatformEnum.pc, GamePlatformEnum.playStation],
      descricao: "Após sobreviver a um acidente aéreo, explore uma floresta habitada por canibais enquanto procura seu filho desaparecido.",
      version: "1.12",
      generalRating: 8,
      allReviews: [
        "A exploração das cavernas é assustadora.",
        "Muito divertido em cooperação.",
        "A inteligência dos inimigos cria situações inesperadas.",
      ],
    ),

    Game(
      name: "Subnautica: Below Zero",
      gameImage: "assets/images/subnautica_below_zero.jpg",
      categories: [GameCategoryEnum.adventure, GameCategoryEnum.simulation],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Retorne ao planeta 4546B e sobreviva às regiões congeladas enquanto investiga o desaparecimento de sua irmã.",
      version: "Atual",
      generalRating: 8,
      allReviews: [
        "Uma boa continuação de Subnautica.",
        "As regiões congeladas trazem ideias interessantes.",
        "Menor que o primeiro, mas ainda muito divertido.",
      ],
    ),

    Game(
      name: "Dead Signal",
      gameImage: "assets/images/dead_signal.jpg",
      categories: [GameCategoryEnum.horror, GameCategoryEnum.simulation],
      platform: [GamePlatformEnum.pc],
      descricao: "Observe câmeras, realize tarefas e monitore ameaças em uma experiência de terror criada pelo estúdio de Scrutinized.",
      version: "Atual",
      generalRating: 8,
      allReviews: [
        "Muito tenso quando várias ameaças aparecem ao mesmo tempo.",
        "A mecânica das câmeras funciona muito bem.",
        "Uma experiência curta, mas intensa.",
      ],
    ),

    Game(
      name: "Welcome to the Game",
      gameImage: "assets/images/wttg.jpg",
      categories: [
        GameCategoryEnum.horror,
        GameCategoryEnum.puzzle,
        GameCategoryEnum.simulation,
      ],
      platform: [GamePlatformEnum.pc],
      descricao: "Explore uma representação fictícia da deep web procurando pistas para encontrar uma transmissão escondida enquanto tenta evitar diferentes ameaças.",
      version: "Atual",
      generalRating: 8,
      allReviews: [
        "A investigação é simples, mas muito atmosférica.",
        "O terror funciona justamente por interromper sua concentração.",
        "Uma ideia muito diferente para um jogo de horror.",
      ],
    ),

    Game(
      name: "Welcome to the Game II",
      gameImage: "assets/images/wttg2.jpg",
      categories: [
        GameCategoryEnum.horror,
        GameCategoryEnum.puzzle,
        GameCategoryEnum.simulation,
      ],
      platform: [GamePlatformEnum.pc],
      descricao: "Investigue a deep web em busca de pistas sobre uma transmissão enquanto administra ameaças digitais e físicas.",
      version: "Atual",
      generalRating: 8,
      allReviews: [
        "Muito mais complexo que o primeiro.",
        "Existem várias mecânicas para aprender ao mesmo tempo.",
        "É brutalmente difícil, mas muito satisfatório quando tudo funciona.",
      ],
    ),

    Game(
      name: "Outer Wilds",
      gameImage: "assets/images/outer_wilds.jpg",
      categories: [GameCategoryEnum.adventure, GameCategoryEnum.puzzle],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Explore um pequeno sistema solar preso em um ciclo temporal e descubra os segredos deixados por uma civilização antiga.",
      version: "Atual",
      generalRating: 10,
      allReviews: [
        "A exploração baseada em conhecimento é incrível.",
        "Cada descoberta muda completamente sua compreensão do mundo.",
        "Um daqueles jogos que você gostaria de poder esquecer para jogar novamente.",
      ],
    ),

    Game(
      name: "Terraria",
      gameImage: "assets/images/terraria.jpg",
      categories: [GameCategoryEnum.action, GameCategoryEnum.adventure],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Explore, construa, fabrique equipamentos e enfrente inimigos em um enorme mundo sandbox bidimensional.",
      version: "Atual",
      generalRating: 9,
      allReviews: [
        "Existe uma quantidade absurda de conteúdo.",
        "A progressão é extremamente satisfatória.",
        "Pode consumir centenas de horas facilmente.",
      ],
    ),

    Game(
      name: "No Man's Sky",
      gameImage: "assets/images/no_mans_sky.jpg",
      categories: [
        GameCategoryEnum.adventure,
        GameCategoryEnum.simulation,
        GameCategoryEnum.action,
      ],
      platform: [
        GamePlatformEnum.pc,
        GamePlatformEnum.playStation,
        GamePlatformEnum.xbox,
        GamePlatformEnum.nintendoSwitch,
      ],
      descricao: "Explore uma galáxia procedural, visite planetas, construa bases, pilote naves e descubra novas formas de vida.",
      version: "Atual",
      generalRating: 8,
      allReviews: [
        "A escala do universo é impressionante.",
        "Construir bases em planetas diferentes é muito divertido.",
        "Recebeu tanto conteúdo que hoje parece outro jogo.",
      ],
    ),
  ];

  int get totalHours {
    return userGames.fold(0, (total, game) => total + game.hoursPlayed);
  }

  void addGame(Game game) {
    if (!userGames.any((userGame) => userGame.name == game.name)) {
      setState(() {
        userGames.add(game);
      });
    }
  }

  void updateGame(Game game) {
    setState(() {});
  }

  List<Widget> get screens => [
    UserGameListScreen(
      userGames: userGames,
      allGames: allGames,
      onAddGame: addGame,
      onUpdateGame: updateGame,
    ),

    DashboardScreen(
      totalHours: totalHours,
      games: userGames,
      allGames: allGames,
      onAddGame: addGame,
    ),

    ChartStatisticsScreen(games: userGames),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.sports_esports),
            label: 'Jogos',
          ),
          NavigationDestination(icon: Icon(Icons.home), label: 'Início'),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Estatísticas',
          ),
        ],
      ),
    );
  }
}
