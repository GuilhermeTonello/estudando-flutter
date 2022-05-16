import 'package:flutter/material.dart';

import 'package:alura_bytebank/components/password_field.dart';

const transactionAuthDialogTextFieldPasswordKey = Key('transactionAuthDialogTextFieldPassword');

class TransactionAuthDialog extends StatelessWidget {
  final TextEditingController _passwordFieldController = TextEditingController();

  final Function(String password) onConfirm;

  TransactionAuthDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: transactionAuthDialogTextFieldPasswordKey,
      title: const Text('Authenticate'),
      content: PasswordField(_passwordFieldController),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text(
            'Confirm',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          onPressed: () {
            onConfirm(_passwordFieldController.text);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
