import 'package:flutter/material.dart';

import 'package:alura_bytebank_persistencia_flutter/screens/contacts/contacts_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Theme.of(context).colorScheme.primary,
              child: InkWell( // GestureDetector do Material, para ter o efeito ao clicar no botão
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ContactsList(),
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 100,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Icon(
                        Icons.people,
                        color: Colors.white,
                        size: 32.0,
                      ),
                      Text(
                        'Contatos',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
