import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';
import '../repository/post_repository.dart';

class FetchPostsUseCase {
  final IPostRepository repository;

  FetchPostsUseCase(this.repository);

  Future<Either<Failure, List<PostEntity>>> call() async {
    return await repository.getAllPosts();
  }
}
