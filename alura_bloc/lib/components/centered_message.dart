import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {

  final String message;
  final IconData? icon;
  final Color? iconColor;

  const CenteredMessage(this.message, {Key? key, this.icon, this.iconColor = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Icon(
              icon, 
              size: 48.0, 
              color: iconColor,
            ),
            visible: icon != null,
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
  
}