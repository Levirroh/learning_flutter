import 'package:flutter/material.dart';

import '../data/eventos_iniciais.dart';
import '../models/evento.dart';
import '../utils/categorias.dart';
import '../widgets/cabecalho_agenda.dart';
import '../widgets/evento_card.dart';
import 'ciclo_vida_screen.dart';
import 'configuracoes_screen.dart';
import 'detalhes_evento_screen.dart';
import 'entrada_screen.dart';
import 'novo_evento_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.nomeUsuario,
  });

  final String nomeUsuario;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _buscaController = TextEditingController();
  late final List<Evento> _eventos;

  String _categoria = 'Todos';
  bool _somenteInscritos = false;

  @override
  void initState() {
    super.initState();
    _eventos = criarEventosIniciais();
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  List<Evento> get _eventosFiltrados {
    final busca = _buscaController.text.trim().toLowerCase();
    return _eventos.where((evento) {
      final correspondeBusca = evento.titulo.toLowerCase().contains(busca) ||
          evento.local.toLowerCase().contains(busca);
      final correspondeCategoria =
          _categoria == 'Todos' || evento.categoria == _categoria;
      final correspondeInscricao = !_somenteInscritos || evento.inscrito;
      return correspondeBusca && correspondeCategoria && correspondeInscricao;
    }).toList();
  }

  Future<void> _abrirDetalhes(Evento evento) async {
    final excluir = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
          builder: (_) => DetalhesEventoScreen(evento: evento)),
    );
    if (!mounted) return;
    setState(() {
      if (excluir == true) _eventos.remove(evento);
    });
    if (excluir == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${evento.titulo} excluido.')),
      );
    }
  }

  Future<void> _adicionarEvento() async {
    final evento = await Navigator.push<Evento>(
      context,
      MaterialPageRoute<Evento>(builder: (_) => const NovoEventoScreen()),
    );
    if (!mounted || evento == null) return;
    setState(() => _eventos.add(evento));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${evento.titulo} cadastrado.')),
    );
  }

  Future<void> _abrirConfiguracoes() async {
    final resultado = await Navigator.push<Map<String, bool>>(
      context,
      MaterialPageRoute<Map<String, bool>>(
        builder: (_) => const ConfiguracoesScreen(),
      ),
    );

    if (!mounted || resultado == null) return;

    final notificacoes = resultado['notificacoes'] ?? false;
    final modoCompacto = resultado['modoCompacto'] ?? false;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Configuracoes: notificacoes=$notificacoes, compacto=$modoCompacto',
        ),
      ),
    );
  }

  Future<void> _sair() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sair da agenda?'),
        content: const Text('Os dados desta sessao serao descartados.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Sair')),
        ],
      ),
    );
    if (!mounted || confirmar != true) return;
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (_) => const EntradaScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtrados = _eventosFiltrados;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        actions: [
          IconButton(
            tooltip: 'Ciclo de vida',
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => const CicloVidaScreen(),
                ),
              );
            },
            icon: const Icon(Icons.sync),
          ),
          IconButton(
            tooltip: 'Configuracoes',
            onPressed: _abrirConfiguracoes,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            tooltip: 'Sair',
            onPressed: _sair,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _adicionarEvento,
        icon: const Icon(Icons.add),
        label: const Text('Novo evento'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CabecalhoAgenda(
                nomeUsuario: widget.nomeUsuario,
                total: _eventos.length,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _buscaController,
                decoration: const InputDecoration(
                  labelText: 'Buscar por titulo ou local',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: categorias
                      .map((categoria) => FilterChip(
                            label: Text(categoria),
                            selected: _categoria == categoria,
                            onSelected: (_) =>
                                setState(() => _categoria = categoria),
                          ))
                      .toList(),
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Mostrar somente minhas inscricoes'),
                value: _somenteInscritos,
                onChanged: (valor) {
                  setState(() => _somenteInscritos = valor);
                },
              ),
              const Divider(),
              Expanded(
                child: filtrados.isEmpty
                    ? const Center(child: Text('Nenhum evento encontrado.'))
                    : ListView.builder(
                        itemCount: filtrados.length,
                        itemBuilder: (context, index) {
                          final evento = filtrados[index];
                          return EventoCard(
                            evento: evento,
                            onTap: () => _abrirDetalhes(evento),
                            onInscricao: () => setState(
                                () => evento.inscrito = !evento.inscrito),
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
