import 'package:alura_bytebank/components/centered_message.dart';
import 'package:flutter/material.dart';

class ResponseDialong extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final Color? iconColor;

  const ResponseDialong(this.title, this.message,
      {Key? key, this.icon, this.iconColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CenteredMessage(
              message,
              icon: icon,
              iconColor: iconColor,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'OK',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}

class FailureDialog extends StatelessWidget {
  final String message;

  const FailureDialog(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponseDialong(
      'Failure',
      message,
      icon: Icons.warning,
      iconColor: Colors.red,
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String message;

  const SuccessDialog(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponseDialong(
      'Failure',
      message,
      icon: Icons.check_circle_outline_outlined,
      iconColor: Colors.green,
    );
  }
}
