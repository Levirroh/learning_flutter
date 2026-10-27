import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_agenda_eventos_atividade_base/app.dart';
import 'package:flutter_agenda_eventos_atividade_base/models/evento.dart';
import 'package:flutter_agenda_eventos_atividade_base/screens/home_screen.dart';
import 'package:flutter_agenda_eventos_atividade_base/screens/entrada_screen.dart';
import 'package:flutter_agenda_eventos_atividade_base/screens/configuracoes_screen.dart';
import 'package:flutter_agenda_eventos_atividade_base/screens/novo_evento_screen.dart';
import 'package:flutter_agenda_eventos_atividade_base/widgets/evento_card.dart';

Future<void> abrirAgenda(WidgetTester tester) async {
  tester.view.physicalSize = const Size(430, 1100);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const AgendaEventosApp());
  await tester.enterText(find.byType(TextField), 'Johann');
  await tester.tap(find.text('Entrar'));
  await tester.pumpAndSettle();
}

Future<void> tocar(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Finder card(String titulo) => find.byWidgetPredicate(
      (widget) => widget is EventoCard && widget.evento.titulo == titulo,
    );

void main() {
  testWidgets('Entrada valida o nome', (tester) async {
    await tester.pumpWidget(const AgendaEventosApp());
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();
    expect(find.text('Informe seu nome.'), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('Combina busca por titulo ou local, categoria e inscricoes',
      (tester) async {
    await abrirAgenda(tester);
    await tester.enterText(find.byType(TextField), 'AUDITORIO');
    await tester.pumpAndSettle();
    expect(card('Game Design na Pratica'), findsOneWidget);
    expect(card('Introducao ao Flutter'), findsNothing);
    await tocar(tester, find.widgetWithText(FilterChip, 'Jogos'));
    await tocar(tester, find.byType(SwitchListTile));
    expect(card('Game Design na Pratica'), findsOneWidget);
    await tocar(tester, find.byTooltip('Cancelar inscricao'));
    expect(find.text('Nenhum evento encontrado.'), findsOneWidget);
    await tocar(tester, find.byType(SwitchListTile));
    await tocar(tester, find.widgetWithText(FilterChip, 'Todos'));
    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.pumpAndSettle();
    expect(card('Introducao ao Flutter'), findsOneWidget);
  });

  testWidgets('Detalhes recebe o objeto e atualiza inscricao na Home',
      (tester) async {
    await abrirAgenda(tester);
    await tocar(tester, find.text('Introducao ao Flutter'));
    expect(find.text('Local: Sala A10'), findsOneWidget);
    await tocar(tester, find.widgetWithText(FilledButton, 'Inscrever-se'));
    expect(find.widgetWithText(FilledButton, 'Cancelar inscricao'),
        findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(
        tester
            .widget<EventoCard>(card('Introducao ao Flutter'))
            .evento
            .inscrito,
        isTrue);
    await tocar(tester, find.text('Introducao ao Flutter'));
    await tocar(
        tester, find.widgetWithText(FilledButton, 'Cancelar inscricao'));
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(
        tester
            .widget<EventoCard>(card('Introducao ao Flutter'))
            .evento
            .inscrito,
        isFalse);
  });

  testWidgets('Cancelar exclusao preserva evento e confirmar remove',
      (tester) async {
    await abrirAgenda(tester);
    await tocar(tester, find.text('Game Design na Pratica'));
    await tocar(tester, find.byTooltip('Excluir'));
    await tocar(tester, find.text('Cancelar'));
    expect(find.text('Game Design na Pratica'), findsOneWidget);
    await tocar(tester, find.byTooltip('Excluir'));
    await tocar(tester, find.widgetWithText(FilledButton, 'Excluir'));
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(card('Game Design na Pratica'), findsNothing);
    expect(find.text('Game Design na Pratica excluido.'), findsOneWidget);
  });

  testWidgets('Cadastro valida, aguarda 600 ms e devolve todos os dados',
      (tester) async {
    tester.view.physicalSize = const Size(430, 1100);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    Evento? resultado;
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (context) {
      return Scaffold(
          body: TextButton(
              onPressed: () async {
                resultado = await Navigator.push<Evento>(
                    context,
                    MaterialPageRoute<Evento>(
                        builder: (_) => const NovoEventoScreen()));
              },
              child: const Text('Abrir')));
    })));
    await tocar(tester, find.text('Abrir'));
    await tocar(tester, find.text('Salvar evento'));
    expect(find.text('Informe o titulo.'), findsOneWidget);
    expect(find.text('Informe o local.'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsNothing);
    await tester.enterText(
        find.byType(TextFormField).at(0), '  Encontro Flutter  ');
    await tester.enterText(find.byType(TextFormField).at(1), 'Sala 10');
    await tester.enterText(
        find.byType(TextFormField).at(2), 'Projetos da turma.');
    await tocar(tester, find.byType(SwitchListTile));
    await tester.tap(find.text('Salvar evento'));
    await tester.pump();
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 599));
    expect(resultado, isNull);
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pumpAndSettle();
    expect(resultado!.titulo, 'Encontro Flutter');
    expect(resultado!.local, 'Sala 10');
    expect(resultado!.descricao, 'Projetos da turma.');
    expect(resultado!.categoria, 'Tecnologia');
    expect(resultado!.inscrito, isTrue);
    expect(resultado!.id, greaterThan(0));
  });

  testWidgets('Evento retornado pelo cadastro aparece na lista',
      (tester) async {
    await abrirAgenda(tester);
    await tocar(tester, find.text('Novo evento'));
    await tester.enterText(find.byType(TextFormField).at(0), 'Novo encontro');
    await tester.enterText(find.byType(TextFormField).at(1), 'Sala 12');
    await tocar(tester, find.text('Salvar evento'));
    await tester.enterText(find.byType(TextField), 'Novo encontro');
    await tester.pumpAndSettle();
    expect(card('Novo encontro'), findsOneWidget);
  });

  testWidgets('Configuracoes retorna exatamente as duas chaves solicitadas',
      (tester) async {
    Map<String, bool>? resultado;
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (context) {
      return Scaffold(
          body: TextButton(
              onPressed: () async {
                resultado = await Navigator.push<Map<String, bool>>(
                    context,
                    MaterialPageRoute<Map<String, bool>>(
                        builder: (_) => const ConfiguracoesScreen()));
              },
              child: const Text('Abrir')));
    })));
    await tocar(tester, find.text('Abrir'));
    await tocar(tester, find.byType(SwitchListTile));
    await tocar(tester, find.byType(CheckboxListTile));
    await tocar(tester, find.text('Salvar e voltar'));
    expect(resultado, {'notificacoes': false, 'modoCompacto': true});
  });

  testWidgets('Saida cancela ou limpa a pilha de rotas', (tester) async {
    await abrirAgenda(tester);
    await tocar(tester, find.byTooltip('Sair'));
    await tocar(tester, find.text('Cancelar'));
    expect(find.byType(HomeScreen), findsOneWidget);
    await tocar(tester, find.byTooltip('Sair'));
    await tocar(tester, find.widgetWithText(FilledButton, 'Sair'));
    expect(find.byType(EntradaScreen), findsOneWidget);
    expect(find.byType(HomeScreen, skipOffstage: false), findsNothing);
    expect(
        Navigator.canPop(tester.element(find.byType(EntradaScreen))), isFalse);
  });

  testWidgets('Listener recebe estados e e liberado ao fechar', (tester) async {
    await abrirAgenda(tester);
    await tocar(tester, find.byTooltip('Ciclo de vida'));
    // Eventos controlados somente para testar o listener.
    for (final estado in [
      AppLifecycleState.inactive,
      AppLifecycleState.hidden,
      AppLifecycleState.paused,
      AppLifecycleState.hidden,
      AppLifecycleState.inactive,
      AppLifecycleState.resumed
    ]) {
      tester.binding.handleAppLifecycleStateChanged(estado);
    }
    await tester.pumpAndSettle();
    expect(find.text('Estado observado: resumed'), findsOneWidget);
    expect(find.text('paused'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
