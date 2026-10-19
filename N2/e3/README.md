# Agenda de Eventos

Estudante: [preencher nome completo e matrícula]

Aplicativo Flutter de eventos acadêmicos com entrada por nome, pesquisa, filtros, inscrições, cadastro, exclusão, configurações e histórico de ciclo de vida.

## Executar

Com Flutter instalado e um Android conectado ou emulador aberto, execute na pasta do projeto:

```sh
flutter pub get
flutter run
```

Para verificar o código e rodar os testes:

```sh
flutter analyze
flutter test
```

Não foram adicionados pacotes externos. Os dados ficam em memória e são reiniciados ao sair da sessão ou encerrar o aplicativo. A opção de notificações guarda uma preferência; não agenda notificações do Android.

## Organização

- `lib/models/`: classe Evento.
- `lib/data/`: categorias e eventos iniciais.
- `lib/widgets/`: card reutilizável do evento.
- `lib/screens/`: telas do aplicativo.
- `GUIA_TODOS.md`: localização e conferência dos 12 itens da atividade.
- `RELATORIO_MODELO.md`: esqueleto para preencher no Google Docs ou Word e exportar em PDF.

Como o projeto base citado no enunciado não foi disponibilizado, este projeto foi criado do zero a pedido do estudante. Os 12 comportamentos foram implementados e identificados no código como `TODO_ATIVIDADE_XX concluído`.

## Teste real no Android

1. Entre com seu nome e confira a lista inicial.
2. Pesquise por título e local. Combine a busca com categoria e somente inscrições.
3. Faça e cancele uma inscrição tanto no card quanto nos detalhes.
4. Cadastre um evento; teste também os campos vazios e o indicador de carregamento.
5. Teste cancelar e confirmar a exclusão.
6. Altere e salve as configurações. Reabra a tela e confira os valores.
7. Abra Ciclo de vida, pressione Home, aguarde e retorne ao aplicativo.
8. Observe o histórico e o console do `flutter run`. Registre somente os estados realmente recebidos.
9. Teste cancelar e confirmar a saída. Após confirmar, a tela de entrada não deve permitir voltar à Home anterior.

O histórico é criado ao abrir a tela Ciclo de vida e descartado ao fechá-la, quando o listener é liberado. Os eventos simulados no teste automatizado não são evidência do teste obrigatório no Android.

## Entrega

Preencha a identificação neste README e no relatório. Insira capturas da própria execução e explicações com suas palavras. Exporte o relatório em PDF e confira a legibilidade. Entregue o PDF e o ZIP com o projeto completo, sem `build/` e `.dart_tool/`.
