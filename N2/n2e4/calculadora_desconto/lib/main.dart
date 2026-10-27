import 'package:flutter/material.dart';
import 'discount_calculator.dart';

void main() {
  runApp(const DiscountApp());
}

class DiscountApp extends StatelessWidget {
  const DiscountApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Desconto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DiscountPage(),
    );
  }
}

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  final valueController = TextEditingController();
  final discountController = TextEditingController();
  String result = '';

  void calculate() {
    final value = double.tryParse(valueController.text.replaceAll(',', '.'));
    final discount = double.tryParse(discountController.text.replaceAll(',', '.'));

    if (value == null || discount == null) {
      setState(() => result = 'Informe valores válidos.');
      return;
    }

    try {
      final finalValue = DiscountCalculator.calculate(value, discount);
      setState(() {
        result = 'Valor final: R\$ ${finalValue.toStringAsFixed(2)}';
      });
    } on ArgumentError {
      setState(() => result = 'Valores inválidos.');
    }
  }

  @override
  void dispose() {
    valueController.dispose();
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Desconto'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                key: const Key('valueField'),
                controller: valueController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Valor do produto',
                  prefixText: 'R\$ ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                key: const Key('discountField'),
                controller: discountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Desconto',
                  suffixText: '%',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                key: const Key('calculateButton'),
                onPressed: calculate,
                child: const Text('Calcular'),
              ),
              const SizedBox(height: 24),
              Text(
                result,
                key: const Key('resultText'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
