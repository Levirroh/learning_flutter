# Catálogo de Jogos

Integrantes: [preencher os nomes completos]

Catálogo simples de jogos de tabuleiro feito em Flutter. Os produtos ficam no código, sem banco de dados. Inclui detalhes dos jogos, transformações de listas e histórico do ciclo de vida.

## Executar

Com o Flutter instalado e um Android conectado ou emulador aberto, execute na pasta `catalogo_produto`:

```sh
flutter pub get
flutter run
```

Para conferir o código e rodar os testes:

```sh
flutter analyze
flutter test
```

## Conferência no Android

1. Abra o aplicativo e confira o registro inicial em “Ciclo de vida”, no final do catálogo.
2. Abra os detalhes de cada jogo e volte pelo botão “Voltar ao catálogo”. Confira nome, descrição, preço e quantidade.
3. Confira as transformações e pressione cada botão de nome.
4. Pressione Home no Android e retorne pelo ícone do app ou pelos aplicativos recentes.
5. Leia o histórico e registre somente os estados que apareceram. Ele é compartilhado pelas duas telas e dura enquanto o aplicativo permanece aberto. Não há gravação em disco.

Os testes automatizados verificam navegação, transformações, mensagens e manutenção do histórico. Os eventos de ciclo de vida usados no teste são simulados e não substituem as capturas da execução no Android.

## Entrega

Preencha `RELATORIO_MODELO.md`, insira capturas da versão entregue e exporte o documento para PDF pelo Google Docs ou Word. Complete os integrantes neste README.

Compacte a pasta do projeto com `lib/`, `android/`, `pubspec.yaml`, `pubspec.lock`, testes e demais arquivos necessários. As pastas `build/`, `.dart_tool/` e arquivos locais de IDE não precisam entrar no ZIP.
