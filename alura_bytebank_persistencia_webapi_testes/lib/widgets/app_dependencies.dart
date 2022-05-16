import 'package:alura_bytebank/database/daos/contact_dao.dart';
import 'package:alura_bytebank/http/webclients/transaction_webclient.dart';
import 'package:flutter/cupertino.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  const AppDependencies({
    Key? key,
    required Widget child,
    required this.contactDao,
    required this.transactionWebClient,
  }) : super(key: key, child: child);

  static AppDependencies? of(BuildContext context) => 
    context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao 
      || transactionWebClient != oldWidget.transactionWebClient;
  }
}
