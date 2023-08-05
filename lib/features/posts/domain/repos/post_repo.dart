import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';

abstract class PostRepo extends Equatable {
  Future<Either<Failure, List<Post>>>? getAllPosts() {}
  Future<Either<Failure, Unit>>? deletePost(int id) {}
  Future<Either<Failure, Unit>>? addPost(Post post) {}
  Future<Either<Failure, Unit>>? updatePost(Post post) {}

  @override
  List<Object?> get props => throw UnimplementedError();
}
