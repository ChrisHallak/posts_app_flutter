import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/dataresources/remote_datasource.dart';
import 'package:posts_app/features/posts/data/models/post_model.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/repos/post_repo.dart';

import '../dataresources/local_datasource.dart';

class PostRepoImp implements PostRepo {
  final RemoteDatasource remoteDatasource;
  final LocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  PostRepoImp(
      {required this.remoteDatasource,
      required this.localDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>>? getAllPosts() async {
    bool isConnected = await networkInfo.isDeviceConnected;
    print('Internet : $isConnected');

    if (isConnected) {
      try {
        List<PostModel> allPosts = await remoteDatasource.getAllPosts();
        localDatasource.cacheData(allPosts);
        return Right(allPosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        List<PostModel> cachedPosts = await localDatasource.getCachedData();
        return Right(cachedPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>>? addPost(Post post) async {
    print('here in the post remo add post ');
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    if (await networkInfo.isDeviceConnected) {
      print('post repo add post The device is connected');
      try {
        return Right(await remoteDatasource.addPost(postModel));
      } on ServerException {
        print('exception in add post repo imp');
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>>? deletePost(int id) async {
    print('here in the post remo update post ');

    if (await networkInfo.isDeviceConnected) {
      try {
        return Right(await remoteDatasource.deletePost(id));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>>? updatePost(Post post) async {
    print('here in the post remo delete post ');

    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    if (await networkInfo.isDeviceConnected) {
      try {
        return Right(await remoteDatasource.updatePost(postModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  getMessage() {}

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();
}
