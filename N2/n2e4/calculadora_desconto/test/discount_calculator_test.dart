import 'package:flutter_test/flutter_test.dart';
import 'package:calculadora_desconto/discount_calculator.dart';

void main() {
  group('DiscountCalculator', () {
    test('10% de desconto em R\$ 100', () {
      final result = DiscountCalculator.calculate(100, 10);
      expect(result, 90);
    });

    test('25% de desconto em R\$ 200', () {
      final result = DiscountCalculator.calculate(200, 25);
      expect(result, 150);
    });

    test('0% de desconto em R\$ 50', () {
      final result = DiscountCalculator.calculate(50, 0);
      expect(result, 50);
    });
  });
}
