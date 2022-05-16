import 'package:alura_gerenciamento_estados_provider/models/transferencias.dart';
import 'package:flutter/material.dart';

import 'package:alura_gerenciamento_estados_provider/components/item_transferencia.dart';
import 'package:alura_gerenciamento_estados_provider/screens/transferencias/formulario_transferencia.dart';
import 'package:provider/provider.dart';

class ListaTransferencias extends StatelessWidget {
  const ListaTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: Consumer<Transferencias>(
        builder: (consumerContext, transferencias, child) {
          return ListView.builder(
            itemCount: transferencias.length(),
            itemBuilder: (context, index) {
              final transferencia = transferencias.getTransferencia(index);
              return ItemTransferencia(transferencia);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormularioTransferencia()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
