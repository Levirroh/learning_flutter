class DiscountCalculator {
  static double calculate(double value, double discount) {
    if (value < 0) {
      throw ArgumentError('O valor não pode ser negativo.');
    }

    if (discount < 0 || discount > 100) {
      throw ArgumentError('O desconto deve estar entre 0 e 100.');
    }

    return value - (value * discount / 100);
  }
}
