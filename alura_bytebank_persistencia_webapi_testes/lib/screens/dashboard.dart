import 'package:alura_bytebank/components/feature_item.dart';
import 'package:alura_bytebank/screens/transactions/transactions_list.dart';
import 'package:flutter/material.dart';

import 'package:alura_bytebank/screens/contacts/contacts_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext builderContext, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/bytebank_logo.png'),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        FeatureItem(
                          'Transfer',
                          Icons.monetization_on,
                          onClick: () {
                            _navigateTo(context, const ContactsList());
                          },
                        ),
                        FeatureItem(
                          'Transactions feed',
                          Icons.description,
                          onClick: () {
                            _navigateTo(context, const TransactionsList());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
