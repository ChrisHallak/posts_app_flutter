import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/globals.dart';
import '../../domain/entities/post.dart';
import '../bloc/add_delete_update/add_delete_update_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({
    Key? key,
    required this.isUpdatePost,
    this.post,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isUpdatePost) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'title must not be empty';
            },
            onTap: () {},
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('Title'),
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder()),
            controller: titleController,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                print('the value is empty');
                return 'body must not be empty';
              }
            },
            onTap: () {},
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                label: Text('Body'),
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder()),
            controller: bodyController,
            minLines: 6,
            maxLines: 6,
          ),
          SizedBox(
            height: 40,
          ),
          MaterialButton(
            minWidth: 100,
            color: Colors.teal,
            child: Text(
              widget.isUpdatePost ? 'update' : 'add',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              print('button is pressed ');
              if (formKey.currentState!.validate()) {
                print('validation');

                print('add button pressed');
                String title = titleController.text;
                String body = bodyController.text;
                Post newPost = Post(
                    id: (widget.isUpdatePost
                        ? widget.post!.id
                        : NUMBER_OF_POSTS + 1),
                    title: title,
                    body: body);

                BlocProvider.of<AddDeleteUpdateBloc>(context).add(
                    widget.isUpdatePost
                        ? UpdatePostEvent(post: widget.post!)
                        : AddPostEvent(post: newPost));
              }
            },
          ),
        ],
      ),
    );
  }
}
