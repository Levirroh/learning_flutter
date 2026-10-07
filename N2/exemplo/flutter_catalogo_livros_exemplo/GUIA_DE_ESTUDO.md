# Guia de estudo do projeto

Este projeto foi montado para servir como referencia das aulas de **elementos comuns do Flutter** e **Android, navegacao e ciclo de vida**.

## 1. Ordem recomendada de leitura

1. `lib/main.dart`
2. `lib/app.dart`
3. `lib/screens/entrada_screen.dart`
4. `lib/screens/home_screen.dart`
5. `lib/widgets/livro_card.dart`
6. `lib/screens/detalhes_livro_screen.dart`
7. `lib/screens/novo_livro_screen.dart`
8. `lib/screens/configuracoes_screen.dart`
9. `lib/screens/ciclo_vida_screen.dart`
10. `docs/MainActivity_exemplo.kt`

## 2. Onde cada assunto aparece

| Assunto | Arquivo principal |
|---|---|
| MaterialApp | `lib/app.dart` |
| Scaffold / AppBar / SafeArea | todas as telas |
| Row / Column / Padding / SizedBox | varias telas |
| Stack / Positioned | `widgets/cabecalho_catalogo.dart` |
| ListView.builder | `screens/home_screen.dart` |
| Card / ListTile | `widgets/livro_card.dart` |
| TextField | entrada e home |
| Form / TextFormField | novo livro |
| Switch / Checkbox | detalhes e configuracoes |
| Dropdown | novo livro e configuracoes |
| SnackBar | entrada e home |
| AlertDialog | detalhes e home |
| ProgressIndicator | novo livro |
| setState() | telas StatefulWidget |
| Widget reutilizavel | `widgets/livro_card.dart` |
| Map<K,V> | `utils/categorias.dart` e configuracoes |
| Iterable.map() | filtros e dropdowns |
| Navigator.push() | home -> detalhes/configuracoes/ciclo |
| Navigator.pop() com resultado | novo livro/configuracoes/detalhes |
| pushReplacement() | entrada -> home |
| pushAndRemoveUntil() | logout -> entrada |
| AppLifecycleListener | `screens/ciclo_vida_screen.dart` |
| Activity Android | `docs/MainActivity_exemplo.kt` |

## 3. Tres estados diferentes

O projeto separa tres ideias que costumam ser confundidas:

- **Estado do aplicativo:** primeiro plano, inativo, oculto, pausado. Observado com `AppLifecycleListener`.
- **Estado de navegacao:** qual rota esta no topo da pilha do `Navigator`.
- **Estado da interface:** busca, filtros, favorito, lido e campos de formulario, controlados com `State` e `setState()`.

Mudar um filtro com `setState()` nao muda a Activity Android. Abrir uma rota com `Navigator.push()` normalmente nao cria uma nova Activity. Pressionar Inicio no Android muda o ciclo de vida do app, mas nao remove cada rota da pilha.

## 4. Fluxo de navegacao

```text
Entrada
  | pushReplacement
  v
Home
  |-- push --> Detalhes -- pop --> Home
  |-- push --> Novo livro -- pop(Livro) --> Home
  |-- push --> Configuracoes -- pop(Map) --> Home
  |-- push --> Ciclo de vida -- pop --> Home
  |
  | pushAndRemoveUntil
  v
Entrada
```

## 5. Pilha do Navigator x widget Stack

Os nomes sao parecidos, mas o papel e diferente:

- **Navigator:** administra o historico de rotas/telas.
- **Stack:** sobrepoe widgets na mesma area visual.

O `Stack` aparece em `CabecalhoCatalogo`. A pilha de rotas aparece nas chamadas ao `Navigator`.

## 6. Experimentos sugeridos

1. Abra um livro e pressione Voltar. Observe que a Home reaparece.
2. Entre no app e tente voltar para a tela de entrada. `pushReplacement()` impede esse retorno.
3. Cadastre um livro. Observe o valor retornando com `Navigator.pop(context, livro)`.
4. Abra Configuracoes. O resultado volta como `Map<String, bool>`.
5. Abra Ciclo de vida, pressione Inicio no Android e depois retorne ao app.
6. Ative somente favoritos e veja a lista ser reconstruida por `setState()`.
7. Adicione `debugPrint()` em `initState()`, `build()` e `dispose()` de uma tela e compare os momentos em que cada metodo ocorre.

## 7. Persistencia

Os livros e configuracoes deste exemplo ficam apenas em memoria. Isso e proposital: o foco e estado local, navegacao e ciclo de vida. Fechar o processo pode apagar alteracoes. Persistencia com arquivo, banco ou backend deve ser tratada como outro problema.
