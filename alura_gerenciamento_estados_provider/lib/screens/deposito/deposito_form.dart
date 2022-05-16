import 'package:alura_gerenciamento_estados_provider/components/editor.dart';
import 'package:alura_gerenciamento_estados_provider/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepositoForm extends StatelessWidget {
  final TextEditingController _valorFieldController = TextEditingController();

  DepositoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fazer um depósito'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              _valorFieldController,
              'Valor',
              '0.00',
              icon: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => _criaDeposito(context),
              child: const Text('Realizar depósito',
                  style: TextStyle(
                    fontSize: 24,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _criaDeposito(BuildContext widgetContext) {
    final double? valor =
        double.tryParse(_valorFieldController.text.replaceAll(',', '.'));
    final bool depositoValido = valor != null && valor > 0;
    if (depositoValido) {
      _atualizaEstado(widgetContext, valor);
      Navigator.pop(widgetContext);
    }
  }

  _atualizaEstado(BuildContext widgetContext, double valor) {
    Provider.of<Saldo>(widgetContext, listen: false).deposita(valor);
  }
}
