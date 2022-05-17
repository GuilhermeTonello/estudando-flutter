import 'package:flutter/material.dart';

import 'package:alura_bloc/themes/default_theme.dart';
import 'package:alura_bloc/screens/dashboard.dart';

void main() {
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: defaultTheme,
        home: const DashboardContainer(),
    );
  }
}
