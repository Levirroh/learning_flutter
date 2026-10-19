import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({
    super.key,
    required this.notificacoes,
    required this.modoCompacto,
  });

  final bool notificacoes;
  final bool modoCompacto;

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  late bool _notificacoes;
  late bool _modoCompacto;

  @override
  void initState() {
    super.initState();
    _notificacoes = widget.notificacoes;
    _modoCompacto = widget.modoCompacto;
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
            value: _notificacoes,
            onChanged: (value) => setState(() => _notificacoes = value),
          ),
          SwitchListTile(
            title: const Text("Modo compacto"),
            subtitle: const Text("Ocultar descrições nos cards da lista."),
            value: _modoCompacto,
            onChanged: (value) => setState(() => _modoCompacto = value),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              // TODO_ATIVIDADE_10 concluído: somente as duas chaves pedidas.
              Navigator.pop(context, <String, bool>{
                'notificacoes': _notificacoes,
                'modoCompacto': _modoCompacto,
              });
            },
            child: const Text("Salvar e voltar"),
          ),
        ],
      ),
    );
  }
}
