import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import '../pages/post_detailed_page.dart';

class PostsWidget extends StatelessWidget {
  final List<Post> allPosts;
  const PostsWidget({required this.allPosts});

  @override
  Widget build(BuildContext context) {
    print('here is the posts widget ');
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return buildPostItem(allPosts[index], context);
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 10.0, vertical: 10.0),
              child: Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
            );
          },
          itemCount: allPosts.length),
    );
  }

  Widget buildPostItem(post, context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        radius: 25.0,
        child: Text(
          post.id.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        post.title.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        post.body.toString(),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PostDetailedPage(
                      post: post,
                    )));

        print('list tile pressed');
      },
      contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10.0),
    );
  }
}
