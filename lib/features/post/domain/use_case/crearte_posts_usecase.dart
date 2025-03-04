import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';
import '../repository/post_repository.dart';

class CreatePostUseCase {
  final IPostRepository repository;

  CreatePostUseCase(this.repository);

  Future<Either<Failure, void>> call(PostEntity post) async {
    return await repository.createPost(post);
  }
}
