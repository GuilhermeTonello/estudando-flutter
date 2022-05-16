import 'package:alura_gerenciamento_estados_provider/components/ultimas_transferencias.dart';
import 'package:alura_gerenciamento_estados_provider/screens/transferencias/lista_transferencia.dart';
import 'package:flutter/material.dart';

import 'package:alura_gerenciamento_estados_provider/components/change_screen_button.dart';
import 'package:alura_gerenciamento_estados_provider/components/saldo_card.dart';
import 'package:alura_gerenciamento_estados_provider/screens/deposito/deposito_form.dart';
import 'package:alura_gerenciamento_estados_provider/screens/transferencias/formulario_transferencia.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: ListView(
        children: <Widget>[
          const Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <ChangeScreenButton>[
              ChangeScreenButton(
                text: 'Depositar',
                screen: DepositoForm(),
              ),
              ChangeScreenButton(
                text: 'Nova transferência',
                screen: FormularioTransferencia(),
              ),
            ],
          ),
          const UltimasTransferencias(),
        ],
      ),
    );
  }
}
