import 'package:flutter_test/flutter_test.dart';

import 'package:alura_bytebank/models/transaction.dart';
import 'package:alura_bytebank/models/contact.dart';

void main() {
  test('Deve retornar um valor quando a transaferência for criada', () {
    final Transaction transaction = Transaction('', 200.0, Contact(0, '', 0));
    expect(transaction.value, 200);
  });

  test('Deve falhar quando enviar uma transferência menor ou igual a 0 (zero)', () {
    expect(() => Transaction('', 0, Contact(0, '', 0)), throwsAssertionError);
  });
}
