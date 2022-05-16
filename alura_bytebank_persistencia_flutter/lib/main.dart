import 'package:flutter/material.dart';

import 'package:alura_bytebank_persistencia_flutter/screens/dashboard.dart';
import 'package:alura_bytebank_persistencia_flutter/themes/default_theme.dart';

void main() {
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
			theme: defaultTheme,
      home: const Dashboard(),
    );
  }
}
