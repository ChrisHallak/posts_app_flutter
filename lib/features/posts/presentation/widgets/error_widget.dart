import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String message;
  final bool isLocal;
  const MyErrorWidget({required this.message, required this.isLocal});

  @override
  Widget build(BuildContext context) {
    print('here is the error widget ');

    if (isLocal) {
      return Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.red, fontSize: 30.0),
        ),
      );
    } else {
      return Text(message);
    }
  }
}
