import 'package:flutter/material.dart';
import 'package:game_tracker/chart_statistics_screen.dart';
import 'package:game_tracker/classes/game.dart';
import 'package:game_tracker/dashboard_screen.dart';
import 'package:game_tracker/game_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 1;

  final List<Game> games = [];

  int get totalHours {
    return games.fold(0, (total, game) => total + game.hoursPlayed);
  }

  List<Widget> get screens => [
    GameListScreen(),
    DashboardScreen(totalHours: totalHours, games: games),
    ChartStatisticsScreen(),
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
