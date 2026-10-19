import 'package:catalogo_produto/item_screen.dart';
import 'package:catalogo_produto/main.dart';
import 'package:catalogo_produto/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Abre os dados de cada produto e retorna ao catálogo', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    final products = [
      ("War", "118,91", 38),
      ("Monopoly", "130,50", 23),
      ("Jogo da Vida", "103,30", 17),
    ];

    for (final product in products) {
      await tester.tap(find.byTooltip("Detalhes de ${product.$1}"));
      await tester.pumpAndSettle();

      final details = tester.widget<ItemScreen>(find.byType(ItemScreen));
      expect(details.item.name, product.$1);
      expect(find.text(details.item.description), findsOneWidget);
      expect(find.text("Preço: R\$ ${product.$2}"), findsOneWidget);
      expect(find.text("Quantidade disponível: ${product.$3}"), findsOneWidget);

      await tester.tap(find.text("Voltar ao catálogo"));
      await tester.pumpAndSettle();
      expect(find.byType(MainScreen), findsOneWidget);
    }
  });

  testWidgets('Mostra transformações e mensagem do nome selecionado', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text("Lista original: [1, 2, 3, 4, 5]"));
    expect(find.text('Strings: ["1", "2", "3", "4", "5"]'), findsOneWidget);
    expect(find.text("Multiplicados por 2: [2, 4, 6, 8, 10]"), findsOneWidget);
    for (final word in ["Flutter", "é", "incrível"]) {
      expect(find.text(word), findsOneWidget);
    }

    for (final name in ["Ana", "Bruno", "Carlos"]) {
      await tester.ensureVisible(find.text(name));
      await tester.pumpAndSettle();
      await tester.tap(find.text(name));
      await tester.pumpAndSettle();
      expect(find.text("Você selecionou $name"), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
    }
  });

  testWidgets('Mantém o histórico entre telas e recebe eventos', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    final home = tester.widget<MainScreen>(find.byType(MainScreen));
    final before = List<String>.of(home.history.value);

    await tester.tap(find.byTooltip("Detalhes de War"));
    await tester.pumpAndSettle();
    expect(home.history.value, before);
    expect(
      tester.widget<ItemScreen>(find.byType(ItemScreen)).history,
      same(home.history),
    );

    // Eventos simulados para testar o código, não são evidências de uso no Android.
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();
    final after = List<String>.of(home.history.value);
    expect(after.any((entry) => entry.endsWith("paused")), isTrue);
    expect(after.last, endsWith("resumed"));

    await tester.tap(find.text("Voltar ao catálogo"));
    await tester.pumpAndSettle();
    expect(home.history.value, after);
  });
}
