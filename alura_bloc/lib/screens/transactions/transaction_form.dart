import 'package:alura_bloc/components/container.dart';
import 'package:alura_bloc/http/webclients/transaction_webclient.dart';
import 'package:alura_bloc/screens/error.dart';
import 'package:alura_bloc/screens/loading.dart';
import 'package:alura_bloc/screens/transactions/transaction_form_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';
import 'package:uuid/uuid.dart';

import 'package:alura_bloc/http/http_exception.dart';

import 'package:alura_bloc/components/transaction_auth_dialog.dart';
import 'package:alura_bloc/components/input_field.dart';

import 'package:alura_bloc/models/contact.dart';
import 'package:alura_bloc/models/transaction.dart';

class TransactionFormCubit extends Cubit<TransactionFormState> {
  final TransactionWebClient _transactionWebClient = TransactionWebClient();

  TransactionFormCubit() : super(const ShowTransactionFormState());

  void saveTransaction(Transaction transaction, String password,
      BuildContext widgetContext) async {
    try {
      await _transactionWebClient
          .saveTransaction(transaction, password)
          .then((transaction) => emit(const SendingTransactionFormState()))
          .whenComplete(() => emit(const SentTransactionFormState()));
    } on HttpException catch (ex) {
      emit(FatalErrorTransactionFormState(ex.message));
    } on TimeoutException {
      const String message =
          'Could not reach server, check your internet connection';
      emit(const FatalErrorTransactionFormState(message));
    } on Exception {
      emit(const FatalErrorTransactionFormState('Unknown Error'));
    }
  }
}

class TransactionFormContainer extends BlocContainer {
  final Contact _contact;

  const TransactionFormContainer(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (blocContext) => TransactionFormCubit(),
      child: BlocListener<TransactionFormCubit, TransactionFormState>(
        listener: (contextBloc, state) {
          if (state is SentTransactionFormState) {
            Navigator.pop(context);
          } else if (state is FatalErrorTransactionFormState) {
            push(contextBloc, ErrorPage(message: state.message));
          }
        },
        child: _TransactionForm(_contact),
      ),
    );
  }
}

// ignore: must_be_immutable
class _TransactionForm extends StatelessWidget {
  final Contact _contact;

  const _TransactionForm(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ShowTransactionFormState:
            return _TransactionFormPage(_contact);
          case SendingTransactionFormState:
          case SentTransactionFormState:
            return const LoadingPage(message: 'Sending...');
          case FatalErrorTransactionFormState:
          default:
            final FatalErrorTransactionFormState fatalErrorState =
                state as FatalErrorTransactionFormState;
            return ErrorPage(message: fatalErrorState.message);
        }
      },
    );
  }
}

class _TransactionFormPage extends StatelessWidget {
  final Contact _contact;

  _TransactionFormPage(this._contact);

  final TextEditingController _valueFieldController = TextEditingController();
  final String _transactionId = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New transaction')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Text(
              _contact.name,
              style: const TextStyle(fontSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                _contact.accountNumber.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InputField(
              _valueFieldController,
              label: 'Value',
              hint: '0.00',
              type: const TextInputType.numberWithOptions(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: const Text('Transfer'),
                  onPressed: () {
                    final double? value = double.tryParse(
                        _valueFieldController.text.replaceAll(',', '.'));
                    if (value != null) {
                      final Transaction transaction =
                          Transaction(_transactionId, value, _contact);
                      showDialog(
                        context: context,
                        builder: (contextDialog) => TransactionAuthDialog(
                          onConfirm: (password) {
                            BlocProvider.of<TransactionFormCubit>(context)
                                .saveTransaction(
                                    transaction, password, context);
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
