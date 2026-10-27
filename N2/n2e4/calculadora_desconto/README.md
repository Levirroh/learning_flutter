# N2 E4 — Calculadora de Desconto

Estudante: Johann Gossen Ruth
Matrícula: 130059
Disciplina e turma: Desenvolvimento de Dispositivos Móveis 4A
Professor: Diego Sauter Possamai

Projeto criado a partir do ZIP fornecido pelo professor. Os arquivos `lib/main.dart` e `lib/discount_calculator.dart` foram preservados. Foram completados os três testes unitários e o teste de widget.

## Executar

```sh
flutter pub get
flutter run
```

Com um Android conectado ou emulador aberto, a calculadora permite informar o valor e o desconto e apresenta o resultado após pressionar Calcular.

## Testes

```sh
flutter test
```

- 100 com 10% retorna 90.
- 200 com 25% retorna 150.
- 50 com 0% retorna 50.
- O teste de widget preenche os campos pelas Keys, toca em Calcular e confere `Valor final: R$ 90.00`.

Resultado da execução: quatro testes aprovados. A análise com `flutter analyze` também passou.

## Builds Android

```sh
flutter build apk --release
flutter build appbundle
```

Builds de 20/10/2026, disponíveis nos caminhos abaixo e conferidos pelos SHA-256 de evidencias/arquivos.json:

- `build/app/outputs/flutter-apk/app-release.apk`
- `build/app/outputs/bundle/release/app-release.aab`

Foi utilizada a configuração de assinatura padrão gerada pelo Flutter para esta atividade acadêmica.

## Evidências

O aplicativo foi executado no emulador Pixel 8. O exemplo 100 com 10% apresentou `Valor final: R$ 90.00`.

- `evidencias/aplicativo.png`: captura real da tela do emulador Android.
- `evidencias/testes.png`: imagem do log real dos quatro testes aprovados.
- `evidencias/apk.png`: imagem do registro real do build APK e dos dados do arquivo.
- `evidencias/aab.png`: imagem do registro real do build AAB e dos dados do arquivo.
- Os arquivos `.txt` guardam os logs e os dados usados nas imagens. `arquivos.json` contém tamanho e SHA-256 dos builds.

As três imagens de logs são registros renderizados a partir dos arquivos salvos, identificados como tal; não são capturas de janelas de terminal. A captura do aplicativo veio diretamente do emulador.

## Entrega

`JohannGossenRuth_N2_E4.zip` contém o projeto, testes, plataformas, evidências e os dois builds release. Caches e arquivos intermediários de compilação foram omitidos. O envio no Microsoft Teams deve ser feito pelo estudante.
