import 'package:flutter/material.dart';

import 'package:alura_bloc/models/contact.dart';

class ContactItem extends StatelessWidget {

  final Contact contact;
  final Function onClick;

  const ContactItem(this.contact, {Key? key, required this.onClick}) : super(key: key);

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
        onTap: () => onClick(),
      ),
    );
  }

}
