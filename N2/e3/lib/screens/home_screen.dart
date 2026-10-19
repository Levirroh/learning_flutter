import 'package:flutter/material.dart';
import 'package:agenda_eventos/data/eventos_iniciais.dart';
import 'package:agenda_eventos/models/evento.dart';
import 'package:agenda_eventos/screens/ciclo_vida_screen.dart';
import 'package:agenda_eventos/screens/configuracoes_screen.dart';
import 'package:agenda_eventos/screens/detalhes_evento_screen.dart';
import 'package:agenda_eventos/screens/entrada_screen.dart';
import 'package:agenda_eventos/screens/novo_evento_screen.dart';
import 'package:agenda_eventos/widgets/evento_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.nome});

  final String nome;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Evento> _eventos = criarEventosIniciais();
  String _busca = "";
  String _categoria = "Todos";
  bool _somenteInscritos = false;
  bool _notificacoes = true;
  bool _modoCompacto = false;

  // TODO_ATIVIDADE_01 concluído: os três critérios são combinados.
  List<Evento> get _eventosFiltrados {
    final busca = _busca.trim().toLowerCase();
    return _eventos.where((evento) {
      final correspondeBusca =
          evento.titulo.toLowerCase().contains(busca) ||
          evento.local.toLowerCase().contains(busca);
      final correspondeCategoria =
          _categoria == "Todos" || evento.categoria == _categoria;
      final correspondeInscricao = !_somenteInscritos || evento.inscrito;
      return correspondeBusca && correspondeCategoria && correspondeInscricao;
    }).toList();
  }

  // TODO_ATIVIDADE_02 concluído.
  Future<void> _abrirDetalhes(Evento evento) async {
    final excluir = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => DetalhesEventoScreen(evento: evento),
      ),
    );
    if (!mounted) return;
    setState(() {
      if (excluir == true) _eventos.remove(evento);
    });
    if (excluir == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${evento.titulo} excluído")));
    }
  }

  // TODO_ATIVIDADE_03 concluído.
  Future<void> _novoEvento() async {
    final evento = await Navigator.push<Evento>(
      context,
      MaterialPageRoute<Evento>(builder: (context) => const NovoEventoScreen()),
    );
    if (!mounted || evento == null) return;
    setState(() => _eventos.add(evento));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("${evento.titulo} cadastrado")));
  }

  // TODO_ATIVIDADE_04 concluído: a entrada passa a ser a única rota.
  Future<void> _sair() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sair da agenda?"),
        content: const Text("Os dados desta sessão serão descartados."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Sair"),
          ),
        ],
      ),
    );
    if (!mounted || confirmar != true) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(builder: (context) => const EntradaScreen()),
      (route) => false,
    );
  }

  Future<void> _configuracoes() async {
    final resultado = await Navigator.push<Map<String, bool>>(
      context,
      MaterialPageRoute<Map<String, bool>>(
        builder: (context) => ConfiguracoesScreen(
          notificacoes: _notificacoes,
          modoCompacto: _modoCompacto,
        ),
      ),
    );
    if (!mounted || resultado == null) return;
    setState(() {
      _notificacoes = resultado['notificacoes']!;
      _modoCompacto = resultado['modoCompacto']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventos = _eventosFiltrados;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda"),
        actions: [
          IconButton(
            tooltip: "Configurações",
            onPressed: _configuracoes,
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            tooltip: "Ciclo de vida",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const CicloVidaScreen(),
              ),
            ),
            icon: const Icon(Icons.history),
          ),
          IconButton(
            tooltip: "Sair",
            onPressed: _sair,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Novo evento",
        onPressed: _novoEvento,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
        children: [
          Text("Olá, ${widget.nome}!", style: const TextStyle(fontSize: 22)),
          Text("Notificações: ${_notificacoes ? 'ativadas' : 'desativadas'}"),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: "Pesquisar por título ou local",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => _busca = value),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            // TODO_ATIVIDADE_05 concluído.
            children: categorias.map((categoria) {
              return FilterChip(
                label: Text(categoria),
                selected: _categoria == categoria,
                onSelected: (_) => setState(() => _categoria = categoria),
              );
            }).toList(),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Mostrar somente minhas inscrições"),
            value: _somenteInscritos,
            onChanged: (value) => setState(() => _somenteInscritos = value),
          ),
          Text("${eventos.length} evento(s) encontrado(s)"),
          const SizedBox(height: 12),
          if (eventos.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text("Nenhum evento encontrado."),
            ),
          ...eventos.map(
            (evento) => EventoCard(
              evento: evento,
              compacto: _modoCompacto,
              onDetalhes: () => _abrirDetalhes(evento),
              // TODO_ATIVIDADE_06 concluído.
              onInscricao: () =>
                  setState(() => evento.inscrito = !evento.inscrito),
            ),
          ),
        ],
      ),
    );
  }
}
