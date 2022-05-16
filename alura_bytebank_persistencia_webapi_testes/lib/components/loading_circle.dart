import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  final String message;

  const LoadingCircle({Key? key, this.message = 'Loading...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          Text(
            message,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
