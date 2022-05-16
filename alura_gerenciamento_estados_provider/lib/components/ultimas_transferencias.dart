import 'package:alura_gerenciamento_estados_provider/components/change_screen_button.dart';
import 'package:alura_gerenciamento_estados_provider/components/item_transferencia.dart';
import 'package:alura_gerenciamento_estados_provider/models/transferencias.dart';
import 'package:alura_gerenciamento_estados_provider/screens/transferencias/lista_transferencia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UltimasTransferencias extends StatelessWidget {
  const UltimasTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Últimas Transferências',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
          child: Consumer<Transferencias>(
              builder: (consumerContext, transferencias, child) {
            final int quantidade = transferencias.length();

            if (quantidade == 0) {
              return const Text(
                'Nenhuma transferência foi efetuada.',
                style: TextStyle(
                  fontSize: 24,
                ),
              );
            }

            int tamanho = 3;
            if (quantidade < 3) {
              tamanho = quantidade;
            }
            return ListView.builder(
                itemCount: tamanho,
                shrinkWrap: true,
                itemBuilder: (listContext, index) {
                  return ItemTransferencia(
                      transferencias.reversedListGetTransferencia(index));
                });
          }),
        ),
        const ChangeScreenButton(
          text: 'Mostrar transferências',
          screen: ListaTransferencias(),
        ),
      ],
    );
  }
}
