import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('here is the loading widget ');
    return Center(
        child: CircularProgressIndicator(
      color: Colors.teal,
    ));
  }
}
