import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'THIS FIELD CAN NOT BE EMPTY';
            },
            decoration: InputDecoration(label: Text('some title')),
          ),
          MaterialButton(
              color: Colors.amber,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print('Test page validation');
                }
              }),
        ],
      ),
    );
  }
}
