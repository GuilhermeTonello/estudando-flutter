import 'package:alura_gerenciamento_estados_provider/models/saldo.dart';
import 'package:alura_gerenciamento_estados_provider/models/transferencias.dart';
import 'package:flutter/material.dart';

import 'package:alura_gerenciamento_estados_provider/components/editor.dart';
import 'package:alura_gerenciamento_estados_provider/models/transferencia.dart';
import 'package:provider/provider.dart';

const _appBarTitle = 'Nova transferência';

const _numeroContaFieldLabel = 'Número da conta';
const _numeroContaFieldHint = '0000';

const _valorFieldLabel = 'Valor';
const _valorFieldHint = '0.00';

const _confirmButtonText = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _numeroContaFieldController =
      TextEditingController();
  final TextEditingController _valorFieldController = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  _criarTransferencia(BuildContext context) {
    final double? valor =
        double.tryParse(_valorFieldController.text.replaceAll(',', '.'));
    final int? numeroConta = int.tryParse(_numeroContaFieldController.text);
    final bool transferenciaValida = _validaTransferencia(context, valor, numeroConta);
    if (transferenciaValida) {
      Transferencia novaTransferencia = Transferencia(valor!, numeroConta!);
      _atualizaEstado(context, novaTransferencia);
      _numeroContaFieldController.clear();
      _valorFieldController.clear();
      Navigator.pop(context);
    }
  }

  _validaTransferencia(BuildContext widgetContext, double? valor, int? numeroConta) {
    final double saldoAtual = Provider.of<Saldo>(widgetContext, listen: false).valor;
    final bool saldoSuficiente = valor != null && valor <= saldoAtual;

    final bool transferenciaValida = numeroConta != null && saldoSuficiente;
    return transferenciaValida;
  }

  _atualizaEstado(BuildContext widgetContext, Transferencia novaTransferencia) {
    Provider.of<Transferencias>(widgetContext, listen: false)
        .adicionaTransferencia(novaTransferencia);
    Provider.of<Saldo>(widgetContext, listen: false)
        .saca(novaTransferencia.valorTransferencia);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(_appBarTitle)),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(_numeroContaFieldController, _numeroContaFieldLabel,
                  _numeroContaFieldHint),
              Editor(_valorFieldController, _valorFieldLabel, _valorFieldHint,
                  icon: Icons.monetization_on),
              ElevatedButton(
                  onPressed: () => _criarTransferencia(context),
                  child: const Text(_confirmButtonText)),
            ],
          ),
        ));
  }
}
