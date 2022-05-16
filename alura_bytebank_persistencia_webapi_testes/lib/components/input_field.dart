import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final String hint;

  const InputField(this.controller,
      {Key? key,
      this.type = TextInputType.text,
      this.label = '',
      this.hint = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      style: const TextStyle(fontSize: 24),
    );
  }
}
