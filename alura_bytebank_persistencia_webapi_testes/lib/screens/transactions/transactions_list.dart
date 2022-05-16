import 'package:alura_bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'package:alura_bytebank/components/centered_message.dart';
import 'package:alura_bytebank/components/loading_circle.dart';
import 'package:alura_bytebank/components/transaction_item.dart';

import 'package:alura_bytebank/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: FutureBuilder<List<Transaction>>(
        initialData: const [],
        future: dependencies?.transactionWebClient.findAllTransactions(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const LoadingCircle();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions =
                    snapshot.data as List<Transaction>;

                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return TransactionItem(transaction);
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              
              return const CenteredMessage(
                'No transactions found.',
                icon: Icons.warning,
              );
          }
          return const CenteredMessage('Unknown error. Try again.');
        },
      ),
    );
  }
}
