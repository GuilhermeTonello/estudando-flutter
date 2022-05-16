import 'package:flutter/material.dart';

import 'package:alura_bytebank_persistencia_flutter/models/contact.dart';

class ContactItem extends StatelessWidget {

  final Contact contact;

  const ContactItem(this.contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

}
