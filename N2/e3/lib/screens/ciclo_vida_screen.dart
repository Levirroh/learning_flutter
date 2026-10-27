import 'package:flutter/material.dart';

class CicloVidaScreen extends StatefulWidget {
  const CicloVidaScreen({super.key});

  @override
  State<CicloVidaScreen> createState() => _CicloVidaScreenState();
}

class _CicloVidaScreenState extends State<CicloVidaScreen> {
  AppLifecycleListener? _listener;
  String _estadoAtual = 'Ainda nao observado';
  final List<String> _historico = [];

  @override
  void initState() {
    super.initState();

    final inicial = WidgetsBinding.instance.lifecycleState;
    if (inicial != null) {
      _estadoAtual = inicial.name;
      _historico.add('${inicial.name} (estado inicial)');
      debugPrint('Estado inicial: ${inicial.name}');
    }
    _listener = AppLifecycleListener(onStateChange: (estado) {
      setState(() {
        _estadoAtual = estado.name;
        _historico.add(estado.name);
      });
      debugPrint('Ciclo de vida: ${estado.name}');
    });
  }

  @override
  void dispose() {
    _listener?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ciclo de vida do app')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estado observado: $_estadoAtual',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              const Text(
                'Teste no Android: deixe esta tela aberta, pressione Inicio, '
                'abra outro app e depois retorne. Observe a tela e o console.',
              ),
              const SizedBox(height: 12),
              const Text(
                'Importante: o estado do app Flutter nao corresponde '
                'um-para-um aos callbacks da Activity Android.',
              ),
              const Divider(height: 28),
              Text(
                'Historico (${_historico.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _historico.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhuma mudanca registrada.',
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
