import 'package:alura_bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'package:alura_bytebank/models/contact.dart';

class ContactForm extends StatefulWidget {
  const ContactForm( {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactFormState();
  
}

class _ContactFormState extends State<ContactForm> {

  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _accountNumberFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('New contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _nameFieldController,
              decoration: const InputDecoration(
                labelText: 'Full name'
              ),
              style: const TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextField(
                controller: _accountNumberFieldController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Account number',
                  hintText: '0000',
                ),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  final String name = _nameFieldController.text;
                  final int? accountNumber = int.tryParse(_accountNumberFieldController.text);
                  if (name.isNotEmpty && accountNumber != null) {
                    final Contact contact = Contact(0, name, accountNumber);
                    dependencies?.contactDao.saveContact(contact)
                      .then((id) => Navigator.pop(context));
                  }
                }, 
                child: const Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}