import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/exceptions.dart';

import '../models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDatasource {
  Future<List<PostModel>> getCachedData();
  Future<Unit> cacheData(List<PostModel> postModels);
}

const CACHED_POSTS = "CACHED_POSTS";

class LocalDatasoucreImp implements LocalDatasource {
  SharedPreferences sharedPrefrences;
  LocalDatasoucreImp({required this.sharedPrefrences});

  @override
  Future<Unit> cacheData(List<PostModel> postModels) {
    List<Map<String, dynamic>> postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPrefrences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedData() {
    dynamic posts = sharedPrefrences.getString(CACHED_POSTS);
    if (posts == null) throw EmptyCacheException();
    List<dynamic> postsJson = json.decode(posts);
    List<PostModel> postModels = postsJson
        .map<PostModel>((postJson) => PostModel.fromJson(postJson))
        .toList();
    return Future.value(postModels);
  }
}
