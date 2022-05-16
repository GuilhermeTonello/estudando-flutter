import 'package:alura_bytebank/database/daos/contact_dao.dart';
import 'package:alura_bytebank/http/webclients/transaction_webclient.dart';
import 'package:alura_bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'package:alura_bytebank/screens/dashboard.dart';
import 'package:alura_bytebank/themes/default_theme.dart';

void main() {
  runApp(BytebankApp(
    ContactDao(),
    TransactionWebClient(),
  ));
}

class BytebankApp extends StatelessWidget {
  final ContactDao _contactDao;
  final TransactionWebClient _transactionWebClient;

  const BytebankApp(this._contactDao, this._transactionWebClient, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      transactionWebClient: _transactionWebClient,
      contactDao: _contactDao,
      child: MaterialApp(
        theme: defaultTheme,
        home: const Dashboard(),
      ),
    );
  }
}
