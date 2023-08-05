import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/show_snack_bar.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/add_post_page.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_page.dart';

import '../../domain/entities/post.dart';

class PostDetailedPage extends StatelessWidget {
  final Post post;

  const PostDetailedPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Detailed Page')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
            listener: (context, state) {
          if (state is AddDeleteUpdateSuccessState) {
            showSuccessSnackBar(context, state.message);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => PostsPage()),
              (route) => false,
            );
          } else if (state is AddDeleteUpdateErrorState) {
            showErrorSnackBar(context, state.message);
          }
        }, builder: (context, state) {
          if (state is LoadingState) return LoadingWidget();
          return Column(children: [
            Text(
              post.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.black),
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10, vertical: 20.0),
              child: Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              post.body,
              style: TextStyle(fontSize: 15.0, color: Colors.black87),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10, vertical: 20.0),
              child: Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AddPostPage(
                                  isUpdate: true,
                                  post: post,
                                )));
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.teal,
                ),
                MaterialButton(
                  onPressed: () {
                    BlocProvider.of<AddDeleteUpdateBloc>(context)
                        .add(DeletePostEvent(postId: post.id));
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.redAccent,
                ),
              ],
            ),
          ]);
        }),
      ),
    );
  }
}
