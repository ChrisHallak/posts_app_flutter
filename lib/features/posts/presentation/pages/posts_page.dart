import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/globals.dart';
import 'package:posts_app/features/posts/presentation/bloc/get_refresh/get_refresh_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/posts_widget.dart';
import 'add_post_page.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    //BlocProvider.of<GetRefreshBloc>(context).add(GetAllPostsEvent());
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('here in the posts page');
    return Scaffold(
      appBar: AppBar(title: Text('Posts Page')),
      body: BlocBuilder<GetRefreshBloc, GetRefreshState>(
        builder: (context, state) {
          print('Post Page BUILDER  $state');
          if (state is LoadingPostsState) {
            return LoadingWidget();
          } else if (state is LoadedPostsState) {
            NUMBER_OF_POSTS = state.allPosts.length;
            return RefreshIndicator(
                onRefresh: () {
                  return refreshPostPage(context);
                },
                child: PostsWidget(allPosts: state.allPosts));
          } else if (state is ErrorState) {
            return MyErrorWidget(
                message: state.message, isLocal: state.isLocal);
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddPostPage(
                        isUpdate: false,
                      )));

          //BlocProvider.of<GetRefreshBloc>(context).add(GetAllPostsEvent());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> refreshPostPage(context) async {
    return BlocProvider.of<GetRefreshBloc>(context).add(GetAllPostsEvent());
  }
}
