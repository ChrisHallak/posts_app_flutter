import 'package:flutter/material.dart';

void showSuccessSnackBar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.greenAccent, content: Text(message)));
}

void showErrorSnackBar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.redAccent, content: Text(message)));
}
