import 'package:flutter/material.dart';

class Editor extends StatelessWidget {

  final TextEditingController _controller;
  final String _label;
  final String _hint;
  final IconData? icon;

  const Editor(this._controller, this._label, this._hint, {Key? key, this.icon})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: _label,
            hintText: _hint,
            icon: icon != null ? Icon(icon) : null,
          ),
          style: const TextStyle(
            fontSize: 24.0
          ),
          keyboardType: const TextInputType.numberWithOptions(),
        ),
      );
  }
  
}
