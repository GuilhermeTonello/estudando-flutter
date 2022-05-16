import 'package:alura_bytebank/components/centered_message.dart';
import 'package:alura_bytebank/screens/transactions/transaction_form.dart';
import 'package:alura_bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'package:alura_bytebank/components/loading_circle.dart';
import 'package:alura_bytebank/components/contact_item.dart';
import 'package:alura_bytebank/screens/contacts/contact_form.dart';

import 'package:alura_bytebank/models/contact.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Transfer')),
      body: FutureBuilder<List<Contact>>(
          initialData: const [],
          future: dependencies?.contactDao.findAllContacts(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none: // future não iniciou. usar quando o usuário inicia o future
                break;
              case ConnectionState.waiting: // esperando o future
                return const LoadingCircle();
              case ConnectionState.active: // future executado mas não terminado por completo
                break;
              case ConnectionState.done: // terminou o future
                final List<Contact> contacts = snapshot.data as List<Contact>;
                if (contacts.isEmpty) {
                  return const CenteredMessage('No contact registered!',
                      icon: Icons.warning);
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return ContactItem(
                      contact,
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TransactionForm(contact),
                          ),
                        );
                      },
                    );
                  },
                  itemCount: contacts.length,
                );
            }
            return const Text('Unknown error. Try again.');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const ContactForm(),
                ),
              )
              .then((value) => setState(
                  () {})); // setState para ter a lista atualizada ao voltar da página de salvar
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
