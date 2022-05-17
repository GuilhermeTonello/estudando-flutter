import 'package:flutter/material.dart';

import 'package:alura_bloc/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          transaction.contact.name,
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          transaction.value.toString(),
          style: const TextStyle(fontSize: 16),
        ),
        leading: const Icon(Icons.monetization_on),
      ),
    );
  }
}
