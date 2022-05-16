import 'package:flutter/material.dart';

import 'package:alura_bytebank/components/editor.dart';
import 'package:alura_bytebank/models/transferencia.dart';

const _appBarTitle = 'Nova transferência';

const _numeroContaFieldLabel = 'Número da conta';
const _numeroContaFieldHint = '0000';

const _valorFieldLabel = 'Valor';
const _valorFieldHint = '0.00';

const _confirmButtonText = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {

  const FormularioTransferencia({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
  
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  
  final TextEditingController _numeroContaFieldController = TextEditingController();
  final TextEditingController _valorFieldController = TextEditingController();

  _criarTransferencia(BuildContext context) {
    final double? valor = 
      double.tryParse(_valorFieldController.text.replaceAll(',', '.'));
    final int? numeroConta = 
      int.tryParse(_numeroContaFieldController.text);
    if (valor != null && numeroConta != null) {
      final Transferencia transferencia = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferencia);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_appBarTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(_numeroContaFieldController, _numeroContaFieldLabel, _numeroContaFieldHint),
            Editor(_valorFieldController, _valorFieldLabel, _valorFieldHint, icon: Icons.monetization_on),
            ElevatedButton(
              onPressed: () => _criarTransferencia(context), 
              child: const Text(_confirmButtonText)),
          ],
        ),
      )
    );
  }
  
}
