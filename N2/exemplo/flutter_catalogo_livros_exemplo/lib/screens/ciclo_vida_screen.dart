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

    // Estado inicial conhecido pelo binding do Flutter.
    _estadoAtual = WidgetsBinding.instance.lifecycleState;

    // AppLifecycleListener observa o ciclo de vida do APLICATIVO.
    // Nao confundir com Navigator: mudar de tela nao significa pausar o app.
    _listener = AppLifecycleListener(
      onStateChange: _aoMudarEstado,
    );
  }

  void _aoMudarEstado(AppLifecycleState novoEstado) {
    if (!mounted) return;

    setState(() {
      _estadoAtual = novoEstado;
      _historico.insert(0, novoEstado.name);
      if (_historico.length > 8) {
        _historico.removeLast();
      }
    });

    debugPrint('Estado do app: ${novoEstado.name}');
  }

  @override
  void dispose() {
    // A assinatura deve ser encerrada quando este State sair da arvore.
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nomeEstado = _estadoAtual?.name ?? 'desconhecido';

    return Scaffold(
      appBar: AppBar(title: const Text('Ciclo de vida')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Teste no Android',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '1. Deixe esta tela aberta.\n'
                        '2. Pressione o botao Inicio do Android.\n'
                        '3. Volte pelo seletor de apps.\n'
                        '4. Observe os estados abaixo e o console.',
                      ),
                      const SizedBox(height: 12),
                      Text('Estado atual: $nomeEstado'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Relacao simplificada com Android',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'onResume() + foco -> resumed\n'
                'onPause() ou perda de foco -> inactive\n'
                'onStop() -> hidden/paused\n\n'
                'Nao existe correspondencia perfeita um-para-um.',
              ),
              const Divider(height: 28),
              Text(
                'Eventos observados (${_historico.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _historico.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhuma mudanca ainda.\nEnvie o app para segundo plano e volte.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.separated(
                        itemCount: _historico.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(child: Text('${index + 1}')),
                            title: Text(_historico[index]),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
