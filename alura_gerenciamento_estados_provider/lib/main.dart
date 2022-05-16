import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:alura_gerenciamento_estados_provider/models/saldo.dart';
import 'package:alura_gerenciamento_estados_provider/models/transferencias.dart';
import 'package:alura_gerenciamento_estados_provider/screens/dashboard/dashboard.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Saldo(0)),
        ChangeNotifierProvider(create: (context) => Transferencias()),
      ],
      child: const BytebankApp(),
    ));

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Dashboard(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green[900],
          secondary: Colors.blueAccent.shade700,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
        ),
      ),
    );
  }
}
