// EXEMPLO 1 — GAME BACKLOG
// Nível: um pouco mais complexo que o GameStore
// Foco: classes, construtores, null safety, List, Map e getters.

enum StatusJogo { backlog, jogando, concluido }

String statusTexto(StatusJogo status) {
  switch (status) {
    case StatusJogo.backlog:
      return 'Backlog';
    case StatusJogo.jogando:
      return 'Jogando';
    case StatusJogo.concluido:
      return 'Concluído';
  }
}

String dinheiro(double valor) => 'R\$ ${valor.toStringAsFixed(2)}';

class Jogo {
  final String titulo;
  final String genero;
  final double preco;
  final String? observacao; // pode ser null
  final StatusJogo status;

  // Construtor principal com parâmetros nomeados.
  const Jogo({
    required this.titulo,
    required this.genero,
    required this.preco,
    this.observacao,
    this.status = StatusJogo.backlog,
  }) : assert(preco >= 0, 'O preço não pode ser negativo.');

  // Construtor nomeado: cria diretamente um jogo gratuito.
  const Jogo.gratuito({
    required this.titulo,
    required this.genero,
    this.observacao,
    this.status = StatusJogo.backlog,
  }) : preco = 0;

  String get observacaoExibida => observacao ?? 'Sem observação';
}

class PerfilJogador {
  final String nome;
  final String? apelido; // null safety: pode não existir
  final List<Jogo> biblioteca;
  final Map<String, int> horasPorJogo;

  PerfilJogador({
    required this.nome,
    this.apelido,
    required this.biblioteca,
    Map<String, int>? horasPorJogo,
  }) : horasPorJogo = horasPorJogo ?? {};

  String get nomeExibicao {
    final apelidoLimpo = apelido?.trim();

    if (apelidoLimpo == null || apelidoLimpo.isEmpty) {
      return nome;
    }

    return '$apelidoLimpo ($nome)';
  }

  int horasDe(Jogo jogo) => horasPorJogo[jogo.titulo] ?? 0;

  double get valorTotalBiblioteca {
    double total = 0;

    for (final jogo in biblioteca) {
      total += jogo.preco;
    }

    return total;
  }

  Map<StatusJogo, int> get quantidadePorStatus {
    final resumo = <StatusJogo, int>{
      for (final status in StatusJogo.values) status: 0,
    };

    for (final jogo in biblioteca) {
      resumo[jogo.status] = (resumo[jogo.status] ?? 0) + 1;
    }

    return resumo;
  }

  // Retorno nullable: pode encontrar um jogo ou não.
  Jogo? buscarPorTitulo(String titulo) {
    for (final jogo in biblioteca) {
      if (jogo.titulo.toLowerCase() == titulo.toLowerCase()) {
        return jogo;
      }
    }

    return null;
  }
}

void imprimirPerfil(PerfilJogador perfil) {
  print('==========================================');
  print('           GAME BACKLOG');
  print('==========================================');
  print('Jogador: ${perfil.nomeExibicao}');
  print('Jogos cadastrados: ${perfil.biblioteca.length}');
  print('Valor da biblioteca: ${dinheiro(perfil.valorTotalBiblioteca)}');
  print('');

  print('BIBLIOTECA');

  for (final jogo in perfil.biblioteca) {
    print('- ${jogo.titulo}');
    print('  Gênero: ${jogo.genero}');
    print('  Status: ${statusTexto(jogo.status)}');
    print('  Preço: ${dinheiro(jogo.preco)}');
    print('  Horas: ${perfil.horasDe(jogo)}');
    print('  Observação: ${jogo.observacaoExibida}');
  }

  print('');
  print('RESUMO POR STATUS');

  final resumo = perfil.quantidadePorStatus;
  for (final status in StatusJogo.values) {
    print('${statusTexto(status)}: ${resumo[status] ?? 0}');
  }

  print('');

  final procurado = perfil.buscarPorTitulo('Hades');
  print('Busca por Hades: ${procurado?.genero ?? 'Jogo não encontrado'}');
}

void main() {
  final jogos = <Jogo>[
    const Jogo(
      titulo: 'Hades',
      genero: 'Action Roguelike',
      preco: 73.50,
      observacao: 'Retomar a campanha',
      status: StatusJogo.jogando,
    ),
    const Jogo(
      titulo: 'Stardew Valley',
      genero: 'Simulação',
      preco: 24.99,
      status: StatusJogo.concluido,
    ),
    const Jogo(
      titulo: 'Celeste',
      genero: 'Plataforma',
      preco: 36.99,
    ),
    const Jogo.gratuito(
      titulo: 'Warframe',
      genero: 'Action RPG',
      observacao: 'Jogar com o grupo',
      status: StatusJogo.jogando,
    ),
  ];

  final perfil = PerfilJogador(
    nome: 'Ana Souza',
    apelido: 'Nyx',
    biblioteca: jogos,
    horasPorJogo: {
      'Hades': 18,
      'Stardew Valley': 65,
      'Warframe': 42,
    },
  );

  imprimirPerfil(perfil);
}
