import 'dart:math'; // Importa utilitários de aleatoriedade (embaralhar baralho, escolhas aleatórias).

/// CRAZY EIGHTS — Simulação automática (4 jogadores, só texto)
/// Objetivo: imprimir cada jogada, sem interação do usuário, até alguém ficar sem cartas.
/// Regras chave: 8 é coringa (quem joga escolhe o naipe); se o monte acabar, reembaralha o descarte.
/// Cores: usamos EMOJIS (compatíveis com o console do DartPad) para indicar vermelho/branco e coringa.

enum ColorStyle { emoji, none } // Estilo de "cor": com emoji (compatível) ou sem nada.
const colorStyle = ColorStyle.emoji; // Padrão: usar emojis para indicar cores/tipos de carta.

/// Adorna o texto da carta conforme estilo/semântica (8 = coringa, vermelho = ♥♦, branco = ♠♣).
String paint(String txt, {required bool isEight, required Suit suit}) {
  if (colorStyle == ColorStyle.none) return txt;        // Se não quiser "cores", devolve puro.
  if (isEight) return '🟩$txt';                         // Marca 8 (coringa) com emoji verde.
  final isRed = suit == Suit.hearts || suit == Suit.diamonds; // Define se o naipe é vermelho.
  return isRed ? '🟥$txt' : '⬜$txt';                    // Vermelho para ♥♦, "branco" para ♠♣.
}

enum Suit { spades, hearts, diamonds, clubs } // Enum dos 4 naipes do baralho padrão.

/// Traduz o naipe para o símbolo usual (♠ ♥ ♦ ♣) para exibir.
String suitSymbol(Suit s) =>
    {Suit.spades: '♠', Suit.hearts: '♥', Suit.diamonds: '♦', Suit.clubs: '♣'}[s]!;

/// Representa uma carta com rank (2..10, J, Q, K, A) e naipe.
class Card {
  final String rank; // Valor nominal da carta, como string.
  final Suit suit;   // Naipe da carta.
  const Card(this.rank, this.suit); // Construtor imutável.

  bool get isEight => rank == '8';  // Facilita checar se a carta é um 8 (coringa no Crazy Eights).

  /// Formata a carta para exibição, aplicando a "cor" por emoji.
  String disp() => paint('$rank${suitSymbol(suit)}', isEight: isEight, suit: suit);
}

/// Estrutura de baralho: cria 52 cartas, embaralha, permite comprar do topo.
class Deck {
  final _r = Random();          // RNG para embaralhar.
  final List<Card> _cards = []; // Pilha de cartas (topo = fim da lista).

  Deck() {
    // Constrói todas as 52 cartas (13 ranks × 4 naipes).
    const ranks = ['2','3','4','5','6','7','8','9','10','J','Q','K','A'];
    for (final s in Suit.values) {
      for (final r in ranks) {
        _cards.add(Card(r, s)); // Cria a carta e adiciona ao baralho.
      }
    }
    _cards.shuffle(_r); // Embaralha o baralho.
  }

  bool get isEmpty => _cards.isEmpty; // Indica se acabou o monte.

  /// Compra uma carta do topo (remove do fim da lista).
  Card draw() {
    if (_cards.isEmpty) throw StateError('Deck vazio'); // Segurança: não deveria acontecer sem reembaralhar.
    return _cards.removeLast(); // Remove e retorna a carta do topo.
  }

  /// Reabastece o monte com cartas (ex: descarte - topo), e reembaralha.
  void addAllAndShuffle(Iterable<Card> cards) {
    _cards.addAll(cards); // Adiciona de volta as cartas ao monte.
    _cards.shuffle(_r);   // Embaralha novamente para aleatoriedade.
  }
}

/// Representa um jogador (nome + mão).
class Player {
  final String name;       // Identificador do jogador, ex.: "P1".
  final List<Card> hand = []; // Mão de cartas do jogador.
  Player(this.name);       // Construtor.

  /// Formata a mão para exibição, mostrando cada carta e a contagem.
  String handDisp() => '[ ${hand.map((c) => c.disp()).join(' ')} ] (${hand.length})';
}

/// Motor do jogo: cria jogadores, controla monte/descarte, aplica regras e imprime cada passo.
class CrazyEights {
  final List<Player> players = [Player('P1'), Player('P2'), Player('P3'), Player('P4')]; // 4 jogadores.
  final Deck deck = Deck();   // Monte principal.
  final List<Card> discard = []; // Pilha de descarte (topo = último elemento).
  final _rng = Random();      // RNG auxiliar (ex.: escolher naipe inicial se 8 abrir a mesa).

  Suit? requiredSuit; // Quando a carta do topo é 8, guarda o naipe que foi declarado e precisa ser seguido.

  // ---------- Setup (distribuição e carta inicial) ----------
  void dealInitial() {
    // Distribui 5 cartas para cada jogador (regra comum para 3+ jogadores).
    for (int i = 0; i < 5; i++) {
      for (final p in players) {
        p.hand.add(deck.draw()); // Cada jogador compra 1 carta por rodada de distribuição.
      }
    }
    // Vira a primeira carta do monte para a pilha de descarte (inicia a mesa).
    final first = deck.draw();
    discard.add(first);
    if (first.isEight) {
      // Se a primeira carta é 8, alguém precisa escolher o naipe que "vale".
      requiredSuit = Suit.values[_rng.nextInt(4)]; // Aqui escolhemos aleatoriamente para a simulação.
      print('Topo inicial é 8 — naipe declarado: 🟩${suitSymbol(requiredSuit!)}'); // Log informativo.
    }
  }

  Card get top => discard.last; // Retorna a carta do topo do descarte (estado atual da mesa).

  /// Regras de jogada: pode jogar 8 (sempre), ou casar naipe/valor (ou seguir naipe declarado).
  bool isPlayable(Card c) {
    if (c.isEight) return true;               // 8 sempre pode.
    if (requiredSuit != null) return c.suit == requiredSuit; // Se há naipe declarado, só vale esse naipe.
    return c.suit == top.suit || c.rank == top.rank;         // Caso normal: casa por naipe OU por rank.
  }

  /// Ao jogar um 8, escolhemos qual naipe declarar.
  /// Estratégia: declara o naipe que o jogador tem mais cartas (aumenta chance de jogar de novo depois).
  Suit chooseSuitForEight(Player p) {
    final counts = <Suit, int>{for (final s in Suit.values) s: 0}; // Mapa de contagem por naipe.
    for (final c in p.hand) {
      if (!c.isEight) counts[c.suit] = (counts[c.suit] ?? 0) + 1;  // Conta apenas não-8.
    }
    Suit best = Suit.values[_rng.nextInt(4)]; // Valor padrão aleatório (caso mão esteja vazia/sem não-8).
    int bestCount = -1;                       // Guarda a maior contagem vista.
    counts.forEach((s, n) {
      if (n > bestCount) { best = s; bestCount = n; } // Atualiza se encontrar naipe mais frequente.
    });
    return best; // Retorna o naipe "ideal" para declarar.
  }

  /// Se o monte acabar, reembaralha a pilha de descarte (menos o topo) para formar novo monte.
  void refillDeckIfNeeded() {
    if (deck.isEmpty && discard.length > 1) { // Só faz sentido se há cartas suficientes no descarte.
      final keepTop = discard.removeLast();   // Mantém a carta do topo (estado atual da mesa).
      deck.addAllAndShuffle(discard);         // Move o restante do descarte para o monte e embaralha.
      discard
        ..clear()                             // Limpa a pilha de descarte...
        ..add(keepTop);                       // ...e recoloca apenas o topo original.
      print('(Monte refeito a partir do descarte)'); // Log da operação.
    }
  }

  // ---------- Estratégia de jogada do bot ----------
  /// Escolhe qual carta jogar: prioriza NÃO gastar 8 se houver alternativa.
  Card? chooseCardToPlay(Player p) {
    final playable = p.hand.where(isPlayable).toList(); // Filtra cartas jogáveis segundo a mesa.
    final nonEights = playable.where((c) => !c.isEight).toList(); // De preferência, cartas que não são 8.

    if (nonEights.isNotEmpty) {
      // Ordena para preferir casar o naipe "relevante" (o declarado, se houver, ou o do topo).
      nonEights.sort((a, b) {
        int score(Card c) {
          int s = 0;
          if (requiredSuit != null && c.suit == requiredSuit) s += 2; // Bônus por seguir naipe declarado.
          if (requiredSuit == null && c.suit == top.suit) s += 1;     // Bônus por manter naipe do topo.
          return s; // Quanto maior, mais "atraente" é jogar essa carta.
        }
        return score(b) - score(a); // Ordena do maior score para o menor.
      });
      return nonEights.first; // Joga a melhor carta não-8.
    }

    // Se não há alternativa, joga um 8 (se existir).
    final eights = playable.where((c) => c.isEight);
    return eights.isNotEmpty ? eights.first : null; // Se nem 8 tem, retorna null (sem jogada).
  }

  // ---------- Laço principal da simulação ----------
  void run() {
    dealInitial(); // Prepara mãos e vira a primeira carta.
    printState();  // Mostra o estado inicial: mãos de todos + topo.

    int turn = 0;           // Índice do turno global (cicla entre P1..P4).
    int safety = 0;         // Contador para trava de segurança (evita loop eterno).
    const SAFETY_MAX_TURNS = 500; // Limite arbitrário de jogadas.

    while (safety++ < SAFETY_MAX_TURNS) { // Laço até alguém vencer ou atingir a trava.
      final current = players[turn % players.length]; // Jogador da vez.

      if (current.hand.isEmpty) { // Caso extremo: alguém zerou no turno anterior.
        print('\n${current.name} já está sem cartas!'); // Mensagem informativa.
        break; // Sai do laço (não deve acontecer aqui, mas é seguro).
      }

      // Mostra contexto do início do turno: quem joga, topo atual e (se houver) naipe declarado.
      final topStr = top.disp(); // Representação do topo (rank+símbolo com "cor"/emoji).
      final reqStr = (requiredSuit != null)
          ? ' (naipe declarado: 🟩${suitSymbol(requiredSuit!)})' // Mostra naipe exigido após 8.
          : '';
      print('\n--- Vez de ${current.name} ---  Topo: $topStr$reqStr');

      Card? toPlay = chooseCardToPlay(current); // Tenta escolher uma carta para jogar.

      // Se não achou carta jogável, compra até encontrar uma (regra escolhida para a simulação).
      if (toPlay == null) {
        int draws = 0; // Contador de compras neste turno (apenas para log/limite).
        while (true) {
          refillDeckIfNeeded();        // Garante que há monte (reembaralha se necessário).
          final drawn = deck.draw();   // Compra 1 carta.
          current.hand.add(drawn);     // Adiciona à mão do jogador.
          draws++;                     // Atualiza contador para log.
          print('${current.name} comprou ${drawn.disp()}'); // Log da compra.

          if (isPlayable(drawn)) {     // Se a carta recém-comprada já é jogável, joga-a imediatamente.
            toPlay = drawn;            // Define como jogada do turno...
            print('${current.name} vai jogar a carta recém-comprada.'); // Log...
            break;                     // ...e sai do loop de compras.
          }
          if (draws >= 10) {           // Limite de 10 compras por turno: evita muito spam numa mão travada.
            print('${current.name} comprou 10 cartas e não achou jogada — passa a vez.');
            break;                     // Passa a vez sem jogar.
          }
        }
      }

      // Executa a jogada (se de fato existe e é válida).
      if (toPlay != null && current.hand.contains(toPlay) && isPlayable(toPlay)) {
        current.hand.remove(toPlay); // Remove a carta da mão do jogador...
        discard.add(toPlay);         // ...e coloca na pilha de descarte (vira topo).

        if (toPlay.isEight) {        // Se for coringa (8), o jogador declara um naipe.
          final chosen = chooseSuitForEight(current); // Escolha "inteligente": o naipe mais abundante na mão.
          requiredSuit = chosen;      // Passa a valer esse naipe para a próxima jogada.
          print('${current.name} jogou ${toPlay.disp()} e DECLAROU naipe: 🟩${suitSymbol(chosen)}'); // Log.
        } else {
          requiredSuit = null;        // Qualquer carta comum "limpa" a exigência anterior de 8.
          print('${current.name} jogou ${toPlay.disp()}'); // Log da jogada normal.
        }
      } else {
        print('${current.name} não conseguiu jogar.'); // Caso tenha comprado 10 e ainda não deu certo.
      }

      // Condição de vitória: se o jogador ficou sem cartas após jogar, ele vence.
      if (current.hand.isEmpty) {
        printState(); // Mostra o estado final das mãos.
        print('\n>>> ${current.name} venceu! Ficou sem cartas. 🎉'); // Parabéns!
        return; // Encerra a simulação.
      }

      printState(); // Mostra o estado após a jogada deste turno.
      turn++;       // Passa a vez para o próximo jogador (P1→P2→P3→P4→P1...).
    }

    print('\n[Encerrado por segurança após muitas jogadas sem vencedor]'); // Chegou na trava.
  }

  /// Imprime a mão de cada jogador e o topo do descarte (com naipe declarado, se houver).
  void printState() {
    print('\nEstado atual:');             // Título do bloco de estado.
    for (final p in players) {            // Itera pelos 4 jogadores...
      print('  ${p.name}: ${p.handDisp()}'); // ...e imprime mão formatada + contagem.
    }
    final topStr = top.disp();            // Topo do descarte formatado.
    final reqStr = (requiredSuit != null) // Sufixo informando naipe declarado (se existir).
        ? ' (naipe declarado: 🟩${suitSymbol(requiredSuit!)})'
        : '';
    print('  Descarte (topo): $topStr$reqStr'); // Linha final do estado.
  }
}

void main() {
  // Mensagens de abertura e legenda dos símbolos (para leitura do console).
  print('=== Oito Maluco — Simulação automática (4 jogadores) ===');
  print('Legenda: 🟥 vermelhas (♥ ♦), ⬜ brancas (♠ ♣), 🟩 coringa (8).');
  CrazyEights().run(); // Dispara a simulação completa (sem interação).
}
