import 'package:alura_bytebank/components/loading_circle.dart';
import 'package:alura_bytebank/http/webclients/transaction_webclient.dart';
import 'package:alura_bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:uuid/uuid.dart';

import 'package:alura_bytebank/http/http_exception.dart';

import 'package:alura_bytebank/components/transaction_auth_dialog.dart';
import 'package:alura_bytebank/components/response_dialong.dart';
import 'package:alura_bytebank/components/input_field.dart';

import 'package:alura_bytebank/models/contact.dart';
import 'package:alura_bytebank/models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm(this.contact, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueFieldController = TextEditingController();

  final String _transactionId = const Uuid().v4();

  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('New transaction')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Visibility(
              child: const LoadingCircle(message: 'Sending...'),
              visible: _isSending,
            ),
            Text(
              widget.contact.name,
              style: const TextStyle(fontSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                widget.contact.accountNumber.toString(),
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
                    final double? value = double.tryParse(_valueFieldController.text.replaceAll(',', '.'));
                    if (value != null) {
                      final Transaction transaction = Transaction(_transactionId, value, widget.contact);
                      showDialog(
                        context: context, 
                        builder: (contextDialog) => TransactionAuthDialog(
                          onConfirm: (password) {
                            _saveTransaction(transaction, password, context, dependencies!.transactionWebClient);
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

  void _saveTransaction(Transaction transaction, 
    String password, 
    BuildContext widgetContext,
    TransactionWebClient transactionWebClient) async {
    try {
      setState(() {
        _isSending = true;
      });
      await transactionWebClient.saveTransaction(transaction, password)
        .whenComplete(() => setState(() => _isSending = false));
      _showSuccessMessage(widgetContext);
    } on HttpException catch (ex) {
      _showFailureMessage(
        widgetContext,
        message: ex.message,
      );
    } on TimeoutException {
      _showFailureMessage(
        widgetContext, 
        message: 'Could not reach server, check your internet connection',
      );
    } on Exception {
      _showFailureMessage(widgetContext);
    }
  }

  void _showSuccessMessage(BuildContext widgetContext, {String message = 'Transaction was successful'}) {
      showDialog(
        context: widgetContext, 
        builder: (contextDialog) => SuccessDialog(message),
      ).then((value) => Navigator.pop(widgetContext));
  }

  void _showFailureMessage(BuildContext widgetContext, {String message = 'Unknown Error'}) {
    showDialog(
      context: widgetContext, 
      builder: (contextDialong) => FailureDialog(message),
    );
  }
}
