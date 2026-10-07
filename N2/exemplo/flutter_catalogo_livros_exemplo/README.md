# Biblioteca de Bolso - exemplo didatico Flutter

Projeto de referencia para estudantes. O objetivo e reunir em um app pequeno os principais elementos das aulas de Flutter: widgets comuns, composicao, estado local, navegacao e ciclo de vida.

## O que o app demonstra

- `MaterialApp`, `Scaffold`, `AppBar`, `SafeArea`
- `Padding`, `SizedBox`, `Row`, `Column`, `Expanded`, `Stack`
- `Card`, `ListTile`, `Chip`, icones
- `TextField`, `TextFormField`, `Switch`, `Checkbox`, `DropdownButtonFormField`
- `FilledButton`, `IconButton`, `FloatingActionButton`
- `SnackBar`, `AlertDialog`, `LinearProgressIndicator`
- `ListView.builder`
- `StatefulWidget` e `setState()`
- widgets reutilizaveis
- `Map<K,V>` e `Iterable.map()`
- `Navigator.push()`, `pop()`, `pushReplacement()` e `pushAndRemoveUntil()`
- retorno de dados entre telas
- `AppLifecycleListener`
- relacao entre Flutter e `FlutterActivity` no Android

## Estrutura

```text
lib/
├─ main.dart
├─ app.dart
├─ data/
│  └─ livros_iniciais.dart
├─ models/
│  └─ livro.dart
├─ screens/
│  ├─ entrada_screen.dart
│  ├─ home_screen.dart
│  ├─ detalhes_livro_screen.dart
│  ├─ novo_livro_screen.dart
│  ├─ configuracoes_screen.dart
│  └─ ciclo_vida_screen.dart
├─ utils/
│  └─ categorias.dart
└─ widgets/
   ├─ cabecalho_catalogo.dart
   └─ livro_card.dart

docs/
└─ MainActivity_exemplo.kt
```

## Como preparar e executar

Este pacote contem o codigo didatico e o `pubspec.yaml`. Como as pastas de plataforma sao geradas pelo proprio Flutter, execute uma vez dentro da pasta do projeto:

```bash
flutter create --platforms=android .
```

Depois:

```bash
flutter pub get
flutter run
```

Se o projeto ja tiver a pasta `android/` gerada pelo Flutter, basta usar:

```bash
flutter pub get
flutter run
```

## Testando o ciclo de vida no Android

1. Execute no emulador ou aparelho Android.
2. Entre no catalogo.
3. Toque no icone de sincronizacao na AppBar.
4. Deixe a tela de Ciclo de vida aberta.
5. Pressione o botao Inicio do Android.
6. Volte pelo seletor de aplicativos.
7. Observe a tela e o console.

A correspondencia entre Android e Flutter e aproximada, nao um mapeamento um-para-um. Em termos didaticos:

- `onResume()` + foco se relaciona com `resumed`;
- `onPause()` ou perda de foco pode se relacionar com `inactive`;
- `onStop()` se relaciona com a transicao para `hidden`/`paused`.

## Importante: uma tela Flutter nao e uma Activity

Em um projeto Flutter Android comum, `MainActivity` herda de `FlutterActivity` e hospeda o conteudo Flutter. As telas em `lib/screens/` sao widgets e rotas do `Navigator`; normalmente nao criamos uma Activity Android para cada tela.

Veja tambem `GUIA_DE_ESTUDO.md`.
