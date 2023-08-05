import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:posts_app/features/posts/presentation/pages/test.dart';
import 'package:posts_app/features/posts/presentation/widgets/form_widget.dart';

import '../../../../core/show_snack_bar.dart';
import '../../domain/entities/post.dart';

class AddPostPage extends StatelessWidget {
  final bool isUpdate;
  final Post? post;

  const AddPostPage({super.key, required this.isUpdate, this.post});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(isUpdate ? 'Update Post Page' : 'Add Post Page')),
      body: Padding(
          padding: EdgeInsets.all(30.0),
          child: BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
            listener: (context, state) {
              print('ADD listerner $state');
              if (state is AddDeleteUpdateSuccessState) {
                showSuccessSnackBar(context, state.message);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => PostsPage()),
                  (route) => false,
                );
                /*BlocProvider.of<AddDeleteUpdateBloc>(context)
                    .add(ResetStateEvent());*/
              } else if (state is AddDeleteUpdateErrorState) {
                showErrorSnackBar(context, state.message);
                /*BlocProvider.of<AddDeleteUpdateBloc>(context)
                    .add(ResetStateEvent());*/
              }
            },
            builder: (context, state) {
              print('Add Page BUILDER  $state');
              if (state is AddDeleteUpdateInitial) print('Initial');
              if (state is LoadingState) {
                return LoadingWidget();
              }
              return FormWidget(
                isUpdatePost: isUpdate,
                post: post,
              );
              //return TestPage();
            },
          )),
    );
  }
}
