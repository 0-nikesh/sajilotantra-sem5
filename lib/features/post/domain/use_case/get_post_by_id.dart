import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';
import '../repository/post_repository.dart';

class GetPostByIdUseCase {
  final IPostRepository repository;

  GetPostByIdUseCase(this.repository);

  Future<Either<Failure, PostEntity?>> call(String postId) async {
    return await repository.getPostById(postId);
  }
}
