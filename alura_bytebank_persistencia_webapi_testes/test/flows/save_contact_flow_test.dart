import 'package:alura_bytebank/http/webclients/transaction_webclient.dart';
import 'package:alura_bytebank/models/contact.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';

import 'package:alura_bytebank/main.dart';
import 'package:alura_bytebank/screens/dashboard.dart';

import 'package:alura_bytebank/database/daos/contact_dao.dart';
import 'package:alura_bytebank/screens/contacts/contact_form.dart';
import 'package:alura_bytebank/screens/contacts/contacts_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mocks/save_contact_flow_test.mocks.dart';
import '../utils/predicates.dart';

@GenerateMocks([ContactDao, TransactionWebClient])
void main() {

  testWidgets('Flow test: Deve salvar um contato', (tester) async {
    final contactDao = MockContactDao();
    final transactionWebClient = MockTransactionWebClient();
    
    final Contact contactToSave = Contact(0, 'Guilherme', 1000);

    List<Contact> contacts = [];
    when(contactDao.findAllContacts())
      .thenAnswer((_) async => Future.value(contacts));
    when(contactDao.saveContact(contactToSave))
      .thenAnswer((_) async => Future.value(1));
    
    // Dashboard
    await tester.pumpWidget(BytebankApp(contactDao, transactionWebClient));

    final Finder dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    // Transfer button
    final Finder transferFeature = find.byWidgetPredicate(
      (widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on)
    );
    expect(transferFeature, findsOneWidget);
    await tester.tap(transferFeature);
    await tester.pumpAndSettle();

    verify(contactDao.findAllContacts())
      .called(1);

    // Contacts List
    final Finder contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    // Add contact button
    final Finder addContactButton = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(addContactButton, findsOneWidget);
    await tester.tap(addContactButton);
    await tester.pumpAndSettle();

    // Contact form
    final Finder contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate((widget) => textFieldMatcher(widget, 'Full name'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, contactToSave.name);

    final accountNumberTextField = find.byWidgetPredicate((widget) => textFieldMatcher(widget, 'Account number'));
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, contactToSave.accountNumber.toString());

    final createButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(contactDao.saveContact(contactToSave))
      .called(1);

    // Contacts list
    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

    verify(contactDao.findAllContacts())
      .called(1);
  });

}
