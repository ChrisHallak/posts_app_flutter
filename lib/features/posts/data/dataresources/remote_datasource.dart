import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:posts_app/core/errors/exceptions.dart';

import '../models/post_model.dart';

abstract class RemoteDatasource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class RemoteDatasourceWithHttp implements RemoteDatasource {
  final Client client;
  RemoteDatasourceWithHttp({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final Response response = await client.get(Uri.parse(BASE_URL + "/posts"),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> jsonPosts = json.decode(response.body);
      List<PostModel> postModels = jsonPosts
          .map<PostModel>((jsonPost) => PostModel.fromJson(jsonPost))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response =
        await client.post(Uri.parse(BASE_URL + "/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    Response response = await client
        .delete(Uri.parse(BASE_URL + '/posts/${postId.toString()}'));
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    Map<String, dynamic> body = {
      'title': postModel.title,
      'body': postModel.body
    };
    Response response = await client.put(
        Uri.parse(BASE_URL + '/posts/${postModel.id.toString()}'),
        body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
