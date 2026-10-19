import 'package:catalogo_produto/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  final ValueNotifier<List<String>> history = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final initialState = WidgetsBinding.instance.lifecycleState;
    if (initialState != null) {
      recordState(initialState, initial: true);
    }
  }

  void recordState(AppLifecycleState state, {bool initial = false}) {
    final time = DateTime.now().toIso8601String().substring(11, 19);
    history.value = [
      ...history.value,
      "$time - ${state.name}${initial ? ' (estado inicial)' : ''}",
    ];
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    recordState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    history.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Catálogo de Jogos",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
          surface: AppColors.surface,
        ),
      ),
      home: MainScreen(history: history),
    );
  }
}
