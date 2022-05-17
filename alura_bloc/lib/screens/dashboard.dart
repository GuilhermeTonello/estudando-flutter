import 'package:alura_bloc/components/container.dart';
import 'package:alura_bloc/components/feature_item.dart';
import 'package:alura_bloc/models/name.dart';
import 'package:alura_bloc/screens/contacts/contacts_list.dart';
import 'package:alura_bloc/screens/name.dart';
import 'package:alura_bloc/screens/transactions/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contextBloc) => NameCubit('Guilherme'),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (contextBloc, state) => Text('Welcome $state'),
        ),
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
                            _navigateToContactList(context);
                          },
                        ),
                        FeatureItem(
                          'Transactions feed',
                          Icons.description,
                          onClick: () {
                            _navigateTo(context, TransactionsList());
                          },
                        ),
                        FeatureItem(
                          'Change name',
                          Icons.person_outline,
                          onClick: () => _navigateToChangeNamePage(context),
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

  void _navigateToContactList(BuildContext blocContext) {
    push(blocContext, ContactsListContainer());
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (contextMaterial) => screen,
      ),
    );
  }

  void _navigateToChangeNamePage(BuildContext contextBloc) {
    Navigator.push(
      contextBloc,
      MaterialPageRoute(
        builder: (contextMaterial) => BlocProvider.value(
          value: BlocProvider.of<NameCubit>(contextBloc),
          child: const NameContainer(),
        ),
      ),
    );
  }
}
