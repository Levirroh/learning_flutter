# Agenda de Eventos — N2 E3

Estudante: Johann Gossen Ruth
Matrícula: 130059
Disciplina e turma: Desenvolvimento de Dispositivos Móveis 4A
Professor: Diego Sauter Possamai

Atividade concluída sobre flutter_agenda_eventos_atividade_base.zip. A estrutura e os componentes do professor foram mantidos; os 12 pontos foram implementados nas telas originais, sem pacotes adicionais.

## Execução

```sh
flutter pub get
flutter run
```

## Verificação

```sh
flutter analyze
flutter test
```

Os dados ficam em memória. As configurações retornam um Map com notificacoes e modoCompacto; a Home apresenta os valores em um SnackBar, conforme o comportamento do projeto-base. A opção de notificações não agenda avisos no Android. O seletor visual existente no projeto-base não faz parte do Map solicitado.

O histórico é criado ao abrir Ciclo de vida e descartado ao fechar a tela. O estado inicial vem de WidgetsBinding.instance.lifecycleState; as demais entradas vêm de onStateChange. O listener é liberado em dispose.

Os relatórios e as evidências para entrega ficam separados desta pasta de código. Execute o aplicativo em Android para conferir as funcionalidades e observar os estados recebidos pelo listener.

Entregue o relatório PDF e o ZIP completo sem build/ e .dart_tool/.
