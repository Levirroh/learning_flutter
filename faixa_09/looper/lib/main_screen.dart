import 'package:flutter/material.dart';
import 'package:looper/looper_screen.dart';
import 'package:looper/recorded_loops_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 1;

  List<Widget> get screens => [RecordedLoopsScreen(), LooperScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.grey[800],
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Colors.black);
            }
            return const IconThemeData(color: Colors.white70);
          }),
          indicatorColor: Colors.pink[200],
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold
              );
            }
            return const TextStyle(color: Colors.white70);
          }),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },  
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.queue_music_outlined),
              label: 'Áudios salvos',
            ),
            NavigationDestination(
              icon: Icon(Icons.music_note_outlined),
              label: 'Início',
            ),
          ],
        ),
      ),
    );
  }
}
