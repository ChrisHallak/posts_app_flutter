import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repos/post_repo.dart';

class DeletePostUseCase {
  final PostRepo repo;
  DeletePostUseCase({required this.repo});
  Future<Either<Failure, Unit>>? call(id) {
    return repo.deletePost(id);
  }
}
