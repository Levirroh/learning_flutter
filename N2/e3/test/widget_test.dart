import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agenda_eventos/main.dart';
import 'package:agenda_eventos/screens/home_screen.dart';
import 'package:agenda_eventos/screens/entrada_screen.dart';
import 'package:agenda_eventos/screens/detalhes_evento_screen.dart';
import 'package:agenda_eventos/screens/novo_evento_screen.dart';
import 'package:agenda_eventos/widgets/evento_card.dart';

Future<void> abrirAgenda(WidgetTester tester) async {
  tester.view.physicalSize = const Size(430, 1100);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const MainApp());
  await tester.enterText(find.byType(TextFormField), "Johann");
  await tester.tap(find.text("Entrar"));
  await tester.pumpAndSettle();
}

Finder card(String titulo) => find.byWidgetPredicate(
  (widget) => widget is EventoCard && widget.evento.titulo == titulo,
);

void simularSegundoPlano(WidgetTester tester) {
  for (final state in [
    AppLifecycleState.inactive,
    AppLifecycleState.hidden,
    AppLifecycleState.paused,
    AppLifecycleState.hidden,
    AppLifecycleState.inactive,
    AppLifecycleState.resumed,
  ]) {
    tester.binding.handleAppLifecycleStateChanged(state);
  }
}

Future<void> tocar(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Entrada exige nome e envia o nome informado', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.tap(find.text("Entrar"));
    await tester.pumpAndSettle();
    expect(find.text("Informe seu nome"), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
    await tester.enterText(find.byType(TextFormField), "  Maria  ");
    await tester.tap(find.text("Entrar"));
    await tester.pumpAndSettle();
    expect(find.text("Olá, Maria!"), findsOneWidget);
  });

  testWidgets(
    'Combina busca, categoria e inscrições e atualiza a lista ao cancelar',
    (tester) async {
      await abrirAgenda(tester);
      final busca = find.byType(TextField);
      await tester.enterText(busca, "LABORATÓRIO");
      await tester.pumpAndSettle();
      expect(find.text("2 evento(s) encontrado(s)"), findsOneWidget);
      expect(card("Introdução ao Flutter"), findsNothing);

      await tocar(tester, find.widgetWithText(FilterChip, "Oficina"));
      await tocar(tester, find.byType(SwitchListTile));
      expect(find.text("1 evento(s) encontrado(s)"), findsOneWidget);
      await tocar(
        tester,
        find.descendant(
          of: card("Git na prática"),
          matching: find.widgetWithText(ElevatedButton, "Cancelar inscrição"),
        ),
      );
      expect(find.text("Nenhum evento encontrado."), findsOneWidget);

      await tocar(tester, find.byType(SwitchListTile));
      await tocar(tester, find.widgetWithText(FilterChip, "Todos"));
      await tester.enterText(busca, "flutter");
      await tester.pumpAndSettle();
      expect(find.text("1 evento(s) encontrado(s)"), findsOneWidget);
      expect(card("Introdução ao Flutter"), findsOneWidget);
    },
  );

  testWidgets(
    'Inscrição feita no card aparece nos detalhes e pode ser cancelada lá',
    (tester) async {
      await abrirAgenda(tester);
      final flutterCard = card("Introdução ao Flutter");
      await tocar(
        tester,
        find.descendant(
          of: flutterCard,
          matching: find.widgetWithText(ElevatedButton, "Inscrever-se"),
        ),
      );
      expect(
        find.descendant(
          of: flutterCard,
          matching: find.text("Inscrição confirmada"),
        ),
        findsOneWidget,
      );
      await tocar(
        tester,
        find.descendant(of: flutterCard, matching: find.text("Detalhes")),
      );
      expect(find.text("Local: Auditório principal"), findsOneWidget);
      expect(find.text("Data: 10/11/2026"), findsOneWidget);
      await tocar(tester, find.text("Cancelar inscrição"));
      expect(find.widgetWithText(FilledButton, "Inscrever-se"), findsOneWidget);
      await tocar(tester, find.text("Voltar à agenda"));
      expect(
        find.descendant(
          of: flutterCard,
          matching: find.text("Inscrição confirmada"),
        ),
        findsNothing,
      );
    },
  );

  testWidgets(
    'Todos os eventos abrem seus dados e excluir respeita a confirmação',
    (tester) async {
      await abrirAgenda(tester);
      for (final titulo in [
        "Introdução ao Flutter",
        "Git na prática",
        "Banco de dados",
      ]) {
        await tocar(
          tester,
          find.descendant(of: card(titulo), matching: find.text("Detalhes")),
        );
        expect(find.text(titulo), findsOneWidget);
        expect(find.byType(DetalhesEventoScreen), findsOneWidget);
        await tocar(tester, find.text("Voltar à agenda"));
      }
      await tocar(
        tester,
        find.descendant(
          of: card("Git na prática"),
          matching: find.text("Detalhes"),
        ),
      );
      await tocar(tester, find.text("Excluir evento"));
      await tester.tap(find.text("Cancelar"));
      await tester.pumpAndSettle();
      expect(find.byType(DetalhesEventoScreen), findsOneWidget);
      await tocar(tester, find.text("Excluir evento"));
      await tester.tap(find.widgetWithText(FilledButton, "Excluir"));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(card("Git na prática"), findsNothing);
      expect(find.text("Git na prática excluído"), findsOneWidget);
      expect(find.text("2 evento(s) encontrado(s)"), findsOneWidget);
    },
  );

  testWidgets(
    'Cadastro valida, carrega por 600 ms e retorna o evento preenchido',
    (tester) async {
      await abrirAgenda(tester);
      await tocar(tester, find.byTooltip("Novo evento"));
      await tocar(tester, find.text("Salvar evento"));
      expect(find.text("Preencha este campo"), findsNWidgets(3));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await tester.enterText(
        find.byType(TextFormField).at(0),
        "Encontro de tecnologia",
      );
      await tester.enterText(find.byType(TextFormField).at(1), "Sala 10");
      await tester.enterText(
        find.byType(TextFormField).at(2),
        "Apresentação dos projetos da turma.",
      );
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Oficina").last);
      await tester.pumpAndSettle();
      await tester.tap(find.text("Salvar evento"));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 599));
      expect(find.byType(NovoEventoScreen), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 1));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text("4 evento(s) encontrado(s)"), findsOneWidget);

      await tester.enterText(find.byType(TextField), "Encontro de tecnologia");
      await tester.pumpAndSettle();
      await tocar(
        tester,
        find.descendant(
          of: card("Encontro de tecnologia"),
          matching: find.text("Detalhes"),
        ),
      );
      expect(find.text("Local: Sala 10"), findsOneWidget);
      expect(find.text("Categoria: Oficina"), findsOneWidget);
      expect(find.text("Apresentação dos projetos da turma."), findsOneWidget);
    },
  );

  testWidgets(
    'Configurações só são aplicadas ao salvar e persistem ao reabrir',
    (tester) async {
      await abrirAgenda(tester);
      await tocar(tester, find.byTooltip("Configurações"));
      await tester.tap(find.widgetWithText(SwitchListTile, "Notificações"));
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text("Notificações: ativadas"), findsOneWidget);

      await tocar(tester, find.byTooltip("Configurações"));
      await tester.tap(find.widgetWithText(SwitchListTile, "Notificações"));
      await tester.tap(find.widgetWithText(SwitchListTile, "Modo compacto"));
      await tocar(tester, find.text("Salvar e voltar"));
      expect(find.text("Notificações: desativadas"), findsOneWidget);
      expect(
        tester.widget<EventoCard>(card("Introdução ao Flutter")).compacto,
        isTrue,
      );
      await tocar(tester, find.byTooltip("Configurações"));
      final switches = tester
          .widgetList<SwitchListTile>(find.byType(SwitchListTile))
          .toList();
      expect(switches[0].value, isFalse);
      expect(switches[1].value, isTrue);
    },
  );

  testWidgets(
    'Sair pode ser cancelado e confirmação remove as rotas anteriores',
    (tester) async {
      await abrirAgenda(tester);
      await tocar(tester, find.byTooltip("Sair"));
      await tester.tap(find.text("Cancelar"));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
      await tocar(tester, find.byTooltip("Sair"));
      await tester.tap(find.widgetWithText(FilledButton, "Sair"));
      await tester.pumpAndSettle();
      expect(find.byType(EntradaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsNothing);
      expect(
        Navigator.canPop(tester.element(find.byType(EntradaScreen))),
        isFalse,
      );
    },
  );

  testWidgets('Listener recebe estados e é liberado ao fechar sua tela', (
    tester,
  ) async {
    await abrirAgenda(tester);
    await tocar(tester, find.byTooltip("Ciclo de vida"));
    // Simulação somente no teste automatizado; não substitui o teste no Android.
    simularSegundoPlano(tester);
    await tester.pumpAndSettle();
    expect(find.text("Estado atual: resumed"), findsOneWidget);
    final states = tester
        .widgetList<Text>(find.byType(Text))
        .map((widget) => widget.data ?? "")
        .toList();
    final paused = states.indexWhere(
      (text) => RegExp(r'^\d+\. paused$').hasMatch(text),
    );
    final resumed = states.lastIndexWhere(
      (text) => RegExp(r'^\d+\. resumed$').hasMatch(text),
    );
    expect(paused, greaterThanOrEqualTo(0));
    expect(resumed, greaterThan(paused));
    await tester.pageBack();
    await tester.pumpAndSettle();
    simularSegundoPlano(tester);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
