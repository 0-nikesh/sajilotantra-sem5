import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repository/post_repository.dart';

class AddCommentUseCase {
  final IPostRepository repository;

  AddCommentUseCase(this.repository);

  Future<Either<Failure, void>> call(String postId, String commentText) async {
    return await repository.addComment(postId, commentText);
  }
}
