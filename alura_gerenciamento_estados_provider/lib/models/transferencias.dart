import 'package:flutter/material.dart';

import 'package:alura_gerenciamento_estados_provider/models/transferencia.dart';

class Transferencias extends ChangeNotifier {

  final List<Transferencia> _transferencias = [];

  int length() => _transferencias.length;

  Transferencia getTransferencia(int index) => _transferencias[index];

  Transferencia reversedListGetTransferencia(int index) {
    final reversedList = _transferencias.reversed.toList();
    return reversedList[index];
  }

  void adicionaTransferencia(Transferencia transferencia) {
    _transferencias.add(transferencia);
    notifyListeners();
  }

}