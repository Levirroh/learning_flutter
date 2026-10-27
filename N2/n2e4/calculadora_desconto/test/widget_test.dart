import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_desconto/main.dart';

void main() {
  testWidgets(
    'Calcula desconto pela interface',
    (WidgetTester tester) async {
      await tester.pumpWidget(const DiscountApp());

      await tester.enterText(find.byKey(const Key('valueField')), '100');
      await tester.enterText(find.byKey(const Key('discountField')), '10');
      await tester.tap(find.byKey(const Key('calculateButton')));
      await tester.pump();
      expect(find.text('Valor final: R\$ 90.00'), findsOneWidget);
    },
  );
}
