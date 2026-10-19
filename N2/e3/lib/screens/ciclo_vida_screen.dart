import 'package:flutter/material.dart';

class CicloVidaScreen extends StatefulWidget {
  const CicloVidaScreen({super.key});

  @override
  State<CicloVidaScreen> createState() => _CicloVidaScreenState();
}

class _CicloVidaScreenState extends State<CicloVidaScreen> {
  late final AppLifecycleListener _listener;
  AppLifecycleState? _estadoAtual;
  final List<String> _historico = [];

  @override
  void initState() {
    super.initState();
    _estadoAtual = WidgetsBinding.instance.lifecycleState;
    if (_estadoAtual != null) {
      _historico.add("${_estadoAtual!.name} (estado inicial)");
      debugPrint("Estado inicial: ${_estadoAtual!.name}");
    }
    // TODO_ATIVIDADE_11 concluído: os estados vêm do Flutter.
    _listener = AppLifecycleListener(
      onStateChange: (state) {
        setState(() {
          _estadoAtual = state;
          _historico.add(state.name);
        });
        debugPrint("Ciclo de vida: ${state.name}");
      },
    );
  }

  @override
  void dispose() {
    // TODO_ATIVIDADE_12 concluído.
    _listener.dispose();
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
            "Estado atual: ${_estadoAtual?.name ?? 'aguardando'}",
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 12),
          const Text(
            "Pressione Home no Android e depois retorne ao aplicativo para observar as mudanças.",
          ),
          const SizedBox(height: 24),
          const Text("Histórico", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          if (_historico.isEmpty) const Text("Nenhum estado recebido ainda."),
          ..._historico.asMap().entries.map(
            (entry) => Text("${entry.key + 1}. ${entry.value}"),
          ),
        ],
      ),
    );
  }
}
