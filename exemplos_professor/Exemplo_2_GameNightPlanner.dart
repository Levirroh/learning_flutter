// EXEMPLO 2 — GAME NIGHT PLANNER
// Nível: aproximadamente 2x a complexidade do GameStore,
// mas ainda muito abaixo do Crazy Eights.
// Foco: null safety, construtores, factory, Map<String, dynamic>,
// Map por ID, List, filtros, ranking e dados simulando JSON/API.

class JogoOnline {
  final int id;
  final String nome;
  final String genero;
  final bool gratuito;
  final int maxJogadores;
  final String? observacao;

  const JogoOnline({
    required this.id,
    required this.nome,
    required this.genero,
    this.gratuito = false,
    this.maxJogadores = 4,
    this.observacao,
  })  : assert(id > 0, 'O id deve ser positivo.'),
        assert(maxJogadores > 0, 'maxJogadores deve ser positivo.');

  // Factory: transforma um Map semelhante a JSON em objeto Dart.
  factory JogoOnline.fromMap(Map<String, dynamic> dados) {
    return JogoOnline(
      id: dados['id'] as int,
      nome: dados['nome'] as String,
      genero: dados['genero'] as String,
      gratuito: dados['gratuito'] as bool? ?? false,
      maxJogadores: dados['maxJogadores'] as int? ?? 4,
      observacao: dados['observacao'] as String?,
    );
  }

  String get tipoAcesso => gratuito ? 'Gratuito' : 'Pago';
}

class Participante {
  final String nome;
  final String? apelido;
  final List<int> jogosDisponiveis;

  // Map: chave = id do jogo; valor = interesse de 1 a 3.
  final Map<int, int> interesse;

  const Participante({
    required this.nome,
    this.apelido,
    required this.jogosDisponiveis,
    required this.interesse,
  });

  factory Participante.fromMap(Map<String, dynamic> dados) {
    return Participante(
      nome: dados['nome'] as String,
      apelido: dados['apelido'] as String?,
      jogosDisponiveis: List<int>.from(dados['jogos'] as List),
      interesse: Map<int, int>.from(dados['interesse'] as Map? ?? const {}),
    );
  }

  String get nomeExibicao {
    final apelidoLimpo = apelido?.trim();

    if (apelidoLimpo == null || apelidoLimpo.isEmpty) {
      return nome;
    }

    return '$apelidoLimpo ($nome)';
  }

  bool temAcesso(int jogoId) => jogosDisponiveis.contains(jogoId);

  int interesseEm(int jogoId) => interesse[jogoId] ?? 0;
}

class GameNight {
  final List<JogoOnline> jogos;
  final List<Participante> participantes;

  // late final: será preenchido no construtor depois que a lista chegar.
  late final Map<int, JogoOnline> catalogoPorId;

  GameNight({
    required this.jogos,
    required this.participantes,
  }) {
    catalogoPorId = {
      for (final jogo in jogos) jogo.id: jogo,
    };
  }

  // Pode retornar null caso o ID não exista.
  JogoOnline? jogoPorId(int id) => catalogoPorId[id];

  List<Participante> participantesComAcesso(int jogoId) {
    return participantes.where((p) => p.temAcesso(jogoId)).toList();
  }

  int pontuacaoDoJogo(int jogoId) {
    int pontos = 0;

    for (final participante in participantes) {
      if (participante.temAcesso(jogoId)) {
        pontos += participante.interesseEm(jogoId);
      }
    }

    return pontos;
  }

  // Retorna null quando ninguém possui o jogo.
  double? mediaDeInteresse(int jogoId) {
    final comAcesso = participantesComAcesso(jogoId);

    if (comAcesso.isEmpty) {
      return null;
    }

    int soma = 0;
    for (final participante in comAcesso) {
      soma += participante.interesseEm(jogoId);
    }

    return soma / comAcesso.length;
  }

  Map<int, int> get pontuacaoPorJogo {
    return {
      for (final jogo in jogos) jogo.id: pontuacaoDoJogo(jogo.id),
    };
  }

  JogoOnline? get melhorJogo {
    if (jogos.isEmpty) return null;

    JogoOnline? melhor;
    int maiorPontuacao = -1;

    for (final jogo in jogos) {
      final pontos = pontuacaoDoJogo(jogo.id);

      if (pontos > maiorPontuacao) {
        maiorPontuacao = pontos;
        melhor = jogo;
      }
    }

    return melhor;
  }
}

void imprimirRanking(GameNight noite) {
  print('==========================================');
  print('          GAME NIGHT PLANNER');
  print('==========================================');

  // Cópia da lista + cascade para ordenar.
  final ranking = [...noite.jogos]
    ..sort(
      (a, b) => noite
          .pontuacaoDoJogo(b.id)
          .compareTo(noite.pontuacaoDoJogo(a.id)),
    );

  print('RANKING');

  for (int i = 0; i < ranking.length; i++) {
    final jogo = ranking[i];
    final pessoas = noite.participantesComAcesso(jogo.id);
    final media = noite.mediaDeInteresse(jogo.id);

    print('${i + 1}. ${jogo.nome}');
    print('   ${jogo.tipoAcesso} | ${jogo.genero}');
    print('   Acesso: ${pessoas.length} participante(s)');
    print('   Pontuação: ${noite.pontuacaoDoJogo(jogo.id)}');
    print('   Interesse médio: ${media?.toStringAsFixed(1) ?? 'Sem votos'}');
    print('   Obs.: ${jogo.observacao ?? 'Nenhuma'}');
  }

  print('');

  final escolhido = noite.melhorJogo;
  print('JOGO RECOMENDADO: ${escolhido?.nome ?? 'Nenhum jogo disponível'}');

  print('');
  print('PARTICIPANTES DO JOGO RECOMENDADO');

  if (escolhido != null) {
    for (final participante in noite.participantesComAcesso(escolhido.id)) {
      print('- ${participante.nomeExibicao}');
    }
  }
}

void main() {
  // Estes Maps simulam dados recebidos de JSON/API.
  final dadosJogos = <Map<String, dynamic>>[
    {
      'id': 1,
      'nome': 'Destiny 2',
      'genero': 'Shooter / RPG',
      'gratuito': true,
      'maxJogadores': 6,
    },
    {
      'id': 2,
      'nome': 'Helldivers 2',
      'genero': 'Cooperativo',
      'maxJogadores': 4,
      'observacao': 'Todos precisam ter o jogo',
    },
    {
      'id': 3,
      'nome': 'Marvel Rivals',
      'genero': 'Hero Shooter',
      'gratuito': true,
      'maxJogadores': 6,
    },
    {
      'id': 4,
      'nome': 'PEAK',
      'genero': 'Cooperativo',
      'maxJogadores': 4,
    },
  ];

  final dadosParticipantes = <Map<String, dynamic>>[
    {
      'nome': 'Ana',
      'apelido': 'Nyx',
      'jogos': [1, 2, 3],
      'interesse': {1: 3, 2: 2, 3: 2},
    },
    {
      'nome': 'Bruno',
      'jogos': [1, 3, 4],
      'interesse': {1: 2, 3: 3, 4: 3},
    },
    {
      'nome': 'Caio',
      'apelido': 'Raven',
      'jogos': [1, 2, 4],
      'interesse': {1: 3, 2: 3, 4: 3},
    },
    {
      'nome': 'Duda',
      'jogos': [3, 4],
      'interesse': {3: 2, 4: 3},
    },
  ];

  final jogos = dadosJogos.map(JogoOnline.fromMap).toList();
  final participantes =
      dadosParticipantes.map(Participante.fromMap).toList();

  final noite = GameNight(
    jogos: jogos,
    participantes: participantes,
  );

  imprimirRanking(noite);
}
