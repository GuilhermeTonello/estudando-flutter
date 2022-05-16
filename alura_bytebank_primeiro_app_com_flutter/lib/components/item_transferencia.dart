import 'package:flutter/material.dart';

import 'package:alura_bytebank/models/transferencia.dart';

class ItemTransferencia extends StatelessWidget {

  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia, {Key? key}) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
              child: ListTile(
                leading: const Icon(Icons.monetization_on),
                title: Text('R\$ ${_transferencia.valorTransferencia}'),
                subtitle: Text('Destino: ${_transferencia.contaDestino}'),
              ),
            );
  }
  
}
