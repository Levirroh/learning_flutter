import 'package:flutter/material.dart';

import '../data/livros_iniciais.dart';
import '../models/livro.dart';
import '../utils/categorias.dart';
import '../widgets/cabecalho_catalogo.dart';
import '../widgets/livro_card.dart';
import 'ciclo_vida_screen.dart';
import 'configuracoes_screen.dart';
import 'detalhes_livro_screen.dart';
import 'entrada_screen.dart';
import 'novo_livro_screen.dart';

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
  late final List<Livro> _livros;

  String _categoria = 'Todos';
  bool _somenteFavoritos = false;

  @override
  void initState() {
    super.initState();
    _livros = criarLivrosIniciais();
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  List<Livro> get _livrosFiltrados {
    final busca = _buscaController.text.trim().toLowerCase();

    return _livros.where((livro) {
      final combinaBusca = busca.isEmpty ||
          livro.titulo.toLowerCase().contains(busca) ||
          livro.autor.toLowerCase().contains(busca);
      final combinaCategoria =
          _categoria == 'Todos' || livro.categoria == _categoria;
      final combinaFavorito = !_somenteFavoritos || livro.favorito;

      return combinaBusca && combinaCategoria && combinaFavorito;
    }).toList();
  }

  Future<void> _abrirDetalhes(Livro livro) async {
    final excluir = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
        builder: (_) => DetalhesLivroScreen(livro: livro),
      ),
    );

    if (!mounted) return;

    if (excluir == true) {
      setState(() => _livros.remove(livro));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${livro.titulo} removido.')),
      );
    } else {
      // O objeto Livro pode ter sido alterado na tela de detalhes.
      // setState pede uma nova build para refletir favorito/lido na lista.
      setState(() {});
    }
  }

  Future<void> _adicionarLivro() async {
    // Navigator.push<T> pode devolver um resultado de tipo T.
    final novo = await Navigator.push<Livro>(
      context,
      MaterialPageRoute<Livro>(
        builder: (_) => const NovoLivroScreen(),
      ),
    );

    if (!mounted || novo == null) return;

    setState(() => _livros.add(novo));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${novo.titulo} adicionado.')),
    );
  }

  Future<void> _abrirConfiguracoes() async {
    // Resultado em Map<K, V>: duas configuracoes voltam em um unico objeto.
    final resultado = await Navigator.push<Map<String, bool>>(
      context,
      MaterialPageRoute<Map<String, bool>>(
        builder: (_) => const ConfiguracoesScreen(),
      ),
    );

    if (!mounted || resultado == null) return;

    final notificacoes = resultado['notificacoes'] ?? false;
    final economico = resultado['modoEconomico'] ?? false;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Configuracoes: notificacoes=$notificacoes, economico=$economico',
        ),
      ),
    );
  }

  Future<void> _sair() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair do exemplo?'),
        content: const Text(
          'A pilha de rotas sera limpa e o app voltara para a entrada.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (!mounted || confirmar != true) return;

    // pushAndRemoveUntil adiciona EntradaScreen e remove todas as rotas anteriores.
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (_) => const EntradaScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtrados = _livrosFiltrados;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogo'),
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
        onPressed: _adicionarLivro,
        icon: const Icon(Icons.add),
        label: const Text('Novo livro'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CabecalhoCatalogo(
                nomeUsuario: widget.nomeUsuario,
                total: _livros.length,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _buscaController,
                decoration: const InputDecoration(
                  labelText: 'Buscar por titulo ou autor',
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
                  // Iterable.map() transforma cada String em um FilterChip.
                  children: categorias.map((categoria) {
                    return FilterChip(
                      label: Text(categoria),
                      selected: _categoria == categoria,
                      onSelected: (_) {
                        setState(() => _categoria = categoria);
                      },
                    );
                  }).toList(),
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Mostrar somente favoritos'),
                value: _somenteFavoritos,
                onChanged: (valor) {
                  setState(() => _somenteFavoritos = valor);
                },
              ),
              const Divider(),
              Expanded(
                child: filtrados.isEmpty
                    ? const Center(
                        child: Text('Nenhum livro encontrado.'),
                      )
                    : ListView.builder(
                        itemCount: filtrados.length,
                        itemBuilder: (context, index) {
                          final livro = filtrados[index];
                          return LivroCard(
                            livro: livro,
                            onTap: () => _abrirDetalhes(livro),
                            onFavorito: () {
                              setState(() {
                                livro.favorito = !livro.favorito;
                              });
                            },
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
