import 'package:flutter/material.dart';

import 'package:alura_bytebank/screens/transferencias/lista_transferencia.dart';

void main() => runApp(const BytebankApp());

class BytebankApp extends StatelessWidget {

  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaTransferencias(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green[900],
          secondary: Colors.blueAccent.shade700,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent[700]
          )
        ),
      ),
    );
  }
  
}
