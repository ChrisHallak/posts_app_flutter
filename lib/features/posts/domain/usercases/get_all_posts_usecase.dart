import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';
import '../repos/post_repo.dart';

class GetAllPostsUseCase {
  final PostRepo repo;
  GetAllPostsUseCase({required this.repo});

  Future<Either<Failure, List<Post>>>? call() {
    return repo.getAllPosts();
  }
}
