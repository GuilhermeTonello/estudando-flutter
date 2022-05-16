import 'package:flutter/material.dart';

import 'package:alura_bytebank/components/item_transferencia.dart';
import 'package:alura_bytebank/screens/transferencias/formulario_transferencia.dart';
import 'package:alura_bytebank/models/transferencia.dart';

class ListaTransferencias extends StatefulWidget {

  final List<Transferencia> _transferencias = [];

  ListaTransferencias({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
  
}

class ListaTransferenciasState extends State<ListaTransferencias> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transferências'),),
      body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, index) {
            final transferencia = widget._transferencias[index];
            return ItemTransferencia(transferencia);
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => const FormularioTransferencia()
              )
            );
          future.then((transferencia) => _atualizarListaDeTransferencias(transferencia));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _atualizarListaDeTransferencias(Transferencia? transferencia) {
    if (transferencia != null) {
      setState(() {
        widget._transferencias.add(transferencia);
      });
    }
  }

}
