import 'package:flutter/material.dart';

class ChangeScreenButton extends StatelessWidget {
  final String text;
  final Widget screen;

  const ChangeScreenButton({Key? key, required this.text, required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (mprContext) => screen)),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
