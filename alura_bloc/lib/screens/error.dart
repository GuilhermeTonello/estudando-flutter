import 'package:alura_bloc/components/container.dart';
import 'package:flutter/material.dart';

class ErrorPage extends BlocContainer {
  final String message;

  const ErrorPage({Key? key, this.message = 'Unknown Error'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
  
}