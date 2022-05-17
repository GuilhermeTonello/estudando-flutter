import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'XXXX',
        border: OutlineInputBorder(),
      ),
      maxLength: 4,
      obscureText: true,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 48,
        letterSpacing: 24,
      ),
    );
  }
}
