import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.notifications,
    required this.compactMode,
  });

  final bool notifications;
  final bool compactMode;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool notifications;
  late bool compactMode;

  @override
  void initState() {
    super.initState();
    notifications = widget.notifications;
    compactMode = widget.compactMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text("Notificações"),
            subtitle: const Text("Preferência da agenda para esta sessão."),
            value: notifications,
            onChanged: (value) => setState(() => notifications = value),
          ),
          SwitchListTile(
            title: const Text("Modo compacto"),
            subtitle: const Text("Ocultar descrições nos cards da lista."),
            value: compactMode,
            onChanged: (value) => setState(() => compactMode = value),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              Navigator.pop(context, <String, bool>{
                'notificacoes': notifications,
                'modoCompacto': compactMode,
              });
            },
            child: const Text("Salvar e voltar"),
          ),
        ],
      ),
    );
  }
}
