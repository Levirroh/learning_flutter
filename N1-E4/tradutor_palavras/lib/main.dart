import 'package:flutter/material.dart';

void main() {
  runApp(const TradutorApp());
}

class TradutorApp extends StatelessWidget {
  const TradutorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tradutor de Palavras',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const TradutorScreen(),
    );
  }
}

class TradutorScreen extends StatefulWidget {
  const TradutorScreen({super.key});

  @override
  State<TradutorScreen> createState() => _TradutorScreenState();
}

class _TradutorScreenState extends State<TradutorScreen> {
  int palavraAtual = 0;
  bool mostrarTraducao = false;

  final List<Map<String, String>> palavras = [
    {
      'portugues': 'Casa',
      'ingles': 'House',
      'espanhol': 'Casa',
    },
    {
      'portugues': 'Livro',
      'ingles': 'Book',
      'espanhol': 'Libro',
    },
    {
      'portugues': 'Cachorro',
      'ingles': 'Dog',
      'espanhol': 'Perro',
    },
    {
      'portugues': 'Gato',
      'ingles': 'Cat',
      'espanhol': 'Gato',
    },
    {
      'portugues': 'Água',
      'ingles': 'Water',
      'espanhol': 'Agua',
    },
    {
      'portugues': 'Comida',
      'ingles': 'Food',
      'espanhol': 'Comida',
    },
    {
      'portugues': 'Escola',
      'ingles': 'School',
      'espanhol': 'Escuela',
    },
    {
      'portugues': 'Carro',
      'ingles': 'Car',
      'espanhol': 'Coche',
    },
    {
      'portugues': 'Amigo',
      'ingles': 'Friend',
      'espanhol': 'Amigo',
    },
    {
      'portugues': 'Cidade',
      'ingles': 'City',
      'espanhol': 'Ciudad',
    },
  ];

  void proximaPalavra() {
    setState(() {
      palavraAtual++;

      if (palavraAtual >= palavras.length) {
        palavraAtual = 0;
      }

      mostrarTraducao = false;
    });
  }

  void palavraAnterior() {
    setState(() {
      palavraAtual--;

      if (palavraAtual < 0) {
        palavraAtual = palavras.length - 1;
      }

      mostrarTraducao = false;
    });
  }

  void exibirTraducao() {
    setState(() {
      mostrarTraducao = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palavra = palavras[palavraAtual];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tradutor de Palavras'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                palavra['portugues']!,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              if (mostrarTraducao) ...[
                Text(
                  'Inglês: ${palavra['ingles']}',
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Espanhol: ${palavra['espanhol']}',
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: palavraAnterior,
                    child: const Text('Anterior'),
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton(
                    onPressed: exibirTraducao,
                    child: const Text('Mostrar tradução'),
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton(
                    onPressed: proximaPalavra,
                    child: const Text('Próxima'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}