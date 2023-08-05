import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repos/post_repo.dart';

import '../../../../core/errors/failures.dart';

class AddPostUseCase {
  final PostRepo repo;
  AddPostUseCase({required this.repo});

  Future<Either<Failure, Unit>>? call(post) {
    return repo.addPost(post);
  }
}
