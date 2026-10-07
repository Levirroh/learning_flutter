import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  bool _notificacoes = true;
  bool _modoEconomico = false;
  String _tamanhoTexto = 'Normal';

  void _salvar() {
    // Map<String, bool> agrupa dois valores para devolver a tela anterior.
    Navigator.pop<Map<String, bool>>(context, {
      'notificacoes': _notificacoes,
      'modoEconomico': _modoEconomico,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuracoes')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('Notificacoes'),
              subtitle: const Text('Exemplo de bool + onChanged + setState().'),
              value: _notificacoes,
              onChanged: (valor) => setState(() => _notificacoes = valor),
            ),
            CheckboxListTile(
              title: const Text('Modo economico'),
              subtitle: const Text('Outro controle ligado ao estado local.'),
              value: _modoEconomico,
              onChanged: (valor) {
                setState(() => _modoEconomico = valor ?? false);
              },
            ),
            const Divider(),
            DropdownButtonFormField<String>(
              initialValue: _tamanhoTexto,
              decoration: const InputDecoration(
                labelText: 'Preferencia de tamanho de texto',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Pequeno', child: Text('Pequeno')),
                DropdownMenuItem(value: 'Normal', child: Text('Normal')),
                DropdownMenuItem(value: 'Grande', child: Text('Grande')),
              ],
              onChanged: (valor) {
                if (valor != null) {
                  setState(() => _tamanhoTexto = valor);
                }
              },
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _salvar,
              icon: const Icon(Icons.check),
              label: const Text('Salvar e voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
