import 'package:alura_bloc/components/container.dart';
import 'package:alura_bloc/database/daos/contact_dao.dart';
import 'package:alura_bloc/components/centered_message.dart';
import 'package:alura_bloc/screens/contacts/contacts_list_states.dart';
import 'package:alura_bloc/screens/transactions/transaction_form.dart';
import 'package:flutter/material.dart';

import 'package:alura_bloc/components/loading_circle.dart';
import 'package:alura_bloc/components/contact_item.dart';
import 'package:alura_bloc/screens/contacts/contact_form.dart';

import 'package:alura_bloc/models/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListCubit extends Cubit<ContactsListState> {
  ContactsListCubit() : super(const InitContactsListState());

  reload(ContactDao contactDao) {
    emit(const LoadingContactsListState());
    contactDao.findAllContacts()
      .then((contacts) => emit(LoadedContactsListState(contacts)));
  }
}

class ContactsListContainer extends BlocContainer {
  final ContactDao _contactDao = ContactDao();

  ContactsListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsListCubit>(
      create: (blocContext) {
        final cubit = ContactsListCubit();
        cubit.reload(_contactDao);
        return cubit;
      },
      child: _ContactsList(_contactDao),
    );
  }
}

class _ContactsList extends StatelessWidget {
  final ContactDao _contactDao;

  const _ContactsList(this._contactDao, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transfer')),
      body: BlocBuilder<ContactsListCubit, ContactsListState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case InitContactsListState:
              case LoadingContactsListState:
                return const LoadingCircle();
              case LoadedContactsListState:
                final LoadedContactsListState contactsState = state as LoadedContactsListState;
                final List<Contact> contacts = contactsState.contacts;

                if (contacts.isEmpty) {
                  return const CenteredMessage('No contact registered!',
                      icon: Icons.warning);
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return ContactItem(
                      contact,
                      onClick: () => push(context, TransactionFormContainer(contact)),
                    );
                  },
                  itemCount: contacts.length,
                );
            }
            return const Text('Unknown error. Try again.');
          }),
      floatingActionButton: _buildAddContactButton(context),
    );
  }

  FloatingActionButton _buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => const ContactForm(),
              ),
            ).then((contacts) => context.read<ContactsListCubit>().reload(_contactDao));
      },
      child: const Icon(Icons.add),
    );
  }
}
