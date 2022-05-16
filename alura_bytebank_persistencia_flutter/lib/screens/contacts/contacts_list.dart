import 'package:flutter/material.dart';

import 'package:alura_bytebank_persistencia_flutter/components/loading_circle.dart';
import 'package:alura_bytebank_persistencia_flutter/components/contact_item.dart';
import 'package:alura_bytebank_persistencia_flutter/screens/contacts/contact_form.dart';

import 'package:alura_bytebank_persistencia_flutter/models/contact.dart';
import 'package:alura_bytebank_persistencia_flutter/database/daos/contact_dao.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactsListState();
  
}

class _ContactsListState extends State<ContactsList> {

  final ContactDao _contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: FutureBuilder<List<Contact>>(
          initialData: const [],
          future: _contactDao.findAllContacts(),
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
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return ContactItem(contact);
                  },
                  itemCount: contacts.length,
                );
            }
            return const Text('Unknown error. Try again.');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ContactForm(),
            ),
          ).then((value) => setState(() {})); // setState para ter a lista atualizada ao voltar da página de salvar
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
