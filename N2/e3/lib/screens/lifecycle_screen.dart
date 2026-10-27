import 'package:flutter/material.dart';

class LifecycleScreen extends StatefulWidget {
  const LifecycleScreen({super.key});

  @override
  State<LifecycleScreen> createState() => _LifecycleScreenState();
}

class _LifecycleScreenState extends State<LifecycleScreen> {
  late final AppLifecycleListener listener;
  AppLifecycleState? currentState;
  final List<String> history = [];

  @override
  void initState() {
    super.initState();
    currentState = WidgetsBinding.instance.lifecycleState;
    if (currentState != null) {
      history.add("${currentState!.name} (estado inicial)");
      debugPrint("Estado inicial: ${currentState!.name}");
    }

    listener = AppLifecycleListener(
      onStateChange: (state) {
        setState(() {
          currentState = state;
          history.add(state.name);
        });
        debugPrint("Ciclo de vida: ${state.name}");
      },
    );
  }

  @override
  void dispose() {
    listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ciclo de vida")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Estado atual: ${currentState?.name ?? 'aguardando'}",
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 12),
          const Text(
            "Pressione Home no Android e depois retorne ao aplicativo para observar as mudanças.",
          ),
          const SizedBox(height: 24),
          const Text("Histórico", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          if (history.isEmpty) const Text("Nenhum estado recebido ainda."),
          ...history.asMap().entries.map(
            (entry) => Text("${entry.key + 1}. ${entry.value}"),
          ),
        ],
      ),
    );
  }
}
