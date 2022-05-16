import 'package:flutter/material.dart';

class Saldo extends ChangeNotifier {
  double valor;

  Saldo(this.valor);

  void deposita(double valor) {
    this.valor += valor;
    notifyListeners();
  }

  void saca(double valor) {
    this.valor -= valor;
    notifyListeners();
  }

  @override
  String toString() {
    String saldoAsString = valor
        .toStringAsFixed(valor.truncateToDouble() == valor ? 2 : 2)
        .replaceFirst('.', ',');
    return 'R\$ $saldoAsString';
  }
}
