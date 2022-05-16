import 'package:alura_bytebank/components/response_dialong.dart';
import 'package:alura_bytebank/components/transaction_auth_dialog.dart';
import 'package:alura_bytebank/http/webclients/transaction_webclient.dart';
import 'package:alura_bytebank/models/transaction.dart';
import 'package:alura_bytebank/screens/contacts/contacts_list.dart';
import 'package:alura_bytebank/screens/transactions/transaction_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mocks/transfer_flow_test.mocks.dart';
import '../utils/predicates.dart';

import 'package:alura_bytebank/database/daos/contact_dao.dart';
import 'package:alura_bytebank/main.dart';
import 'package:alura_bytebank/models/contact.dart';
import 'package:alura_bytebank/screens/dashboard.dart';

@GenerateMocks([ContactDao, TransactionWebClient])
void main() {
  testWidgets('Flow test: Deve fazer a transferência para um contato', (tester) async {
    final contactDao = MockContactDao();
    final transactionWebClient = MockTransactionWebClient();
    
    final Contact contact = Contact(0, 'Guilherme', 1000);
    const String password = '0000';
    const double value = 200;
    final Transaction transaction = Transaction('', value, contact);

    List<Contact> contacts = [contact];
    when(contactDao.findAllContacts())
      .thenAnswer((invocation) async => contacts);
    when(transactionWebClient.saveTransaction(transaction, password))
      .thenAnswer((invocation) async => transaction);
    
    // Dashboard
    await tester.pumpWidget(BytebankApp(contactDao, transactionWebClient));

    final Finder dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    // Transfer feature button
    final Finder transferFeature = find.byWidgetPredicate(
      (widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on)
    );
    expect(transferFeature, findsOneWidget);
    await tester.tap(transferFeature);
    await tester.pumpAndSettle();

    verify(contactDao.findAllContacts())
      .called(1);

    // Contacts List/Contact Item
    final contactItem = find.byWidgetPredicate((widget) => contactItemMatcher(widget, contact));
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    // Transaction form
    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);
    expect(find.text(contact.name), findsOneWidget);
    expect(find.text(contact.accountNumber.toString()), findsOneWidget);

    final valueTextField = find.byWidgetPredicate((widget) => inputFieldMatcher(widget, 'Value'));
    expect(valueTextField, findsOneWidget);

    // Enviando transferência
    await tester.enterText(valueTextField, value.toString());

    final transferButton = find.widgetWithText(ElevatedButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    // Authentication dialog
    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);


    final passwordTextField = find.byKey(transactionAuthDialogTextFieldPasswordKey);
    expect(passwordTextField, findsOneWidget);
    await tester.enterText(passwordTextField, password);

    final confirmButton = find.widgetWithText(TextButton, 'Confirm');
    expect(confirmButton, findsOneWidget);
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    // Success Dialog
    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final successDialogOkButton = find.widgetWithText(TextButton, 'OK');
    expect(successDialogOkButton, findsOneWidget);
    await tester.tap(successDialogOkButton);
    await tester.pumpAndSettle();

    // Retornando para a Contacts List
    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);
  });
}