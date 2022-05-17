import 'package:flutter/material.dart';

import 'package:alura_bloc/components/loading_circle.dart';

class LoadingPage extends StatelessWidget {
  final String message;

  const LoadingPage({Key? key, this.message = 'Loading...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processing'),
      ),
      body: LoadingCircle(message: message),
    );
  }
}
