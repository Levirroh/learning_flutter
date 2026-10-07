// Exemplo didatico: o arquivo real e gerado dentro de android/ pelo Flutter.
// Caminho comum:
// android/app/src/main/kotlin/<pacote>/MainActivity.kt

package com.example.flutter_catalogo_livros_exemplo

import io.flutter.embedding.android.FlutterActivity

// Em um app Flutter comum, esta Activity hospeda o conteudo Flutter.
// As telas HomeScreen, DetalhesLivroScreen etc. NAO sao novas Activities.
// Elas sao widgets/rotas gerenciados pelo Navigator dentro do Flutter.
class MainActivity : FlutterActivity()
