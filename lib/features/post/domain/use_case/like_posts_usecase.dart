import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repository/post_repository.dart';

class LikePostUseCase {
  final IPostRepository repository;

  LikePostUseCase(this.repository);

  Future<Either<Failure, void>> call(String postId) async {
    return await repository.likePost(postId);
  }
}
